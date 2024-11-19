import pandas as pd
import requests
from difflib import get_close_matches
from textblob import TextBlob
from flask import Flask, request, jsonify

# Load the movie data
try:
    data = pd.read_csv('movies_with_tags_rating.csv', on_bad_lines='skip')
    print("Data loaded successfully")
except Exception as e:
    print(f"Error loading data: {e}")

# Extract genre names from the 'genre' column
def extract_genres(genre):
    genres = []
    possible_genres = ["action", "comedy", "drama", "horror", "thriller", "romance", "mystery", "sci-fi", "fantasy", "documentary"]
    if isinstance(genre, str):
        for g in possible_genres:
            if g in genre.lower():
                genres.append(g)
    return genres

# Check if 'genre' column exists and apply extraction
if 'genre' in data.columns:
    data['genre_names'] = data['genre'].apply(extract_genres)
else:
    print("Error: 'genre' column not found in the data")

# Scale ratings if 'rating' column exists
if 'rating' in data.columns:
    data['scaled_rating'] = (data['rating'] / 2).round(1)
else:
    print("Error: 'rating' column not found in the data")

# Initialize TMDb API key
TMDB_API_KEY = "YOUR_TMDB_API_KEY"  # Replace with your TMDb API Key

# Fetch similar movies from TMDb
def fetch_tmdb_recommendations(movie_title):
    search_response = requests.get(f"https://api.themoviedb.org/3/search/movie?api_key={TMDB_API_KEY}&query={movie_title}").json()

    if 'results' in search_response and search_response['results']:
        movie_id = search_response['results'][0]['id']
        recommendations_response = requests.get(f"https://api.themoviedb.org/3/movie/{movie_id}/similar?api_key={TMDB_API_KEY}").json()

        genres_response = requests.get(f"https://api.themoviedb.org/3/genre/movie/list?api_key={TMDB_API_KEY}").json()
        genre_mapping = {genre['id']: genre['name'] for genre in genres_response['genres']}

        similar_movies = []
        for movie in recommendations_response['results']:
            movie_genres = [genre_mapping.get(genre_id, "Unknown") for genre_id in movie['genre_ids']]
            similar_movies.append({
                'title': movie['title'],
                'genre': ', '.join(movie_genres),
                'rating': movie.get('vote_average', 'N/A')
            })

        # Format output for display
        response = "Here are some similar movies from TMDb:\n"
        for movie in similar_movies[:3]:  # Show top 3 movies
            response += f"- **{movie['title']}**\n  Genres: {movie['genre']}\n  Rating: {movie['rating']}/10\n\n"

        return response

    return f"No results found for '{movie_title}' in TMDb."

# Function to get sentiment of user input
def get_sentiment(text):
    analysis = TextBlob(text)
    return analysis.sentiment.polarity

# Function to get movies by genre and also show the highest-rated movie
def get_movies_by_genre(genre):
    genre = genre.lower()
    filtered_movies = data[data['genre_names'].apply(lambda genres: genre in genres)]

    if filtered_movies.empty:
        return "Sorry, no movies found for this genre."

    max_movies = 5
    limited_movies = filtered_movies.head(max_movies)
    highest_rated = limited_movies.loc[limited_movies['scaled_rating'].idxmax()]

    response = f"Here are some {genre.capitalize()} movies I've found:\n"
    for idx, row in limited_movies.iterrows():
        response += f"- {row['title']} (Rating: {row.get('scaled_rating', 'N/A')}/5.0)\n"

    response += f"\nThe highest-rated {genre.capitalize()} movie from this list is '{highest_rated['title']}' with a rating of {highest_rated['scaled_rating']}/5.0."

    return response

# Function to get movies similar to a given movie and also show the highest-rated movie
def get_similar_movies(movie_name, previous_recommendations):
    movie_name = movie_name.strip().lower()

    # Ensure 'title' column contains only strings
    data['title'] = data['title'].astype(str)

    possible_matches = get_close_matches(movie_name, data['title'].str.lower().tolist(), n=1, cutoff=0.6)

    if not possible_matches:
        return fetch_tmdb_recommendations(movie_name)  # Fall back to TMDb if no local match

    movie_name = possible_matches[0]
    target_movie = data[data['title'].str.lower() == movie_name]

    if target_movie.empty:
        return fetch_tmdb_recommendations(movie_name)  # Fall back to TMDb if no local match

    target_genres = target_movie.iloc[0]['genre_names']

    def genre_similarity(genres):
        return len(set(target_genres).intersection(set(genres)))

    data['similarity_score'] = data['genre_names'].apply(genre_similarity)
    similar_movies = data.sort_values(by='similarity_score', ascending=False)

    # Exclude previously recommended movies
    similar_movies = similar_movies[~similar_movies['title'].isin(previous_recommendations)]

    if similar_movies.empty:
        return fetch_tmdb_recommendations(movie_name)  # Fall back to TMDb if no more local similar movies

    max_movies = 5
    limited_movies = similar_movies.head(max_movies)
    highest_rated = limited_movies.loc[limited_movies['scaled_rating'].idxmax()]

    response = f"Movies similar to '{movie_name.title()}':\n"
    for idx, row in limited_movies.iterrows():
        response += f"- {row['title']} (Genres: {', '.join(row['genre_names']).title()}, Rating: {row.get('scaled_rating', 'N/A')}/5.0)\n"

    response += f"\nThe highest-rated movie similar to '{movie_name.title()}' is '{highest_rated['title']}' with a rating of {highest_rated['scaled_rating']}/5.0."

    return response, limited_movies['title'].tolist()

# Enhanced function to handle conversations with memory (basic session memory)
conversation_memory = {
    'last_genre': None,
    'last_movie': None,
    'previous_recommendations': []
}

def handle_conversation(user_input):
    user_input = user_input.lower().strip()
    sentiment = get_sentiment(user_input)

    if any(greeting in user_input for greeting in ["hi", "hello", "hey", "how are you", "good morning", "good evening"]):
        return "I'm doing great, thank you! How can I help you with movies today?"

    if 'more' in user_input and conversation_memory['last_genre']:
        return get_movies_by_genre(conversation_memory['last_genre'])

    elif "like" in user_input:
        movie_name = user_input.split("like", 1)[-1].strip()
        conversation_memory['last_movie'] = movie_name
        response, recommendations = get_similar_movies(movie_name, conversation_memory['previous_recommendations'])
        conversation_memory['previous_recommendations'].extend(recommendations)
        return response

    elif any(genre in user_input for genre in ["action", "comedy", "drama", "horror", "thriller", "romance"]):
        genre = next((g for g in ["action", "comedy", "drama", "horror", "thriller", "romance"] if g in user_input), None)
        conversation_memory['last_genre'] = genre
        return get_movies_by_genre(genre)

    elif 'recommend' in user_input or 'suggest' in user_input:
        return "I can recommend movies based on genres like Action, Comedy, Drama, and more! Just tell me what you're in the mood for."

    elif "thanks" in user_input or "thank you" in user_input:
        return "You're welcome! If you have more questions, feel free to ask."

    elif "bye" in user_input or "goodbye" in user_input:
        return "Goodbye! Have a great day!"

    # Handle sentiment
    if sentiment > 0.5:
        return "I'm glad you're feeling positive! How can I assist you further?"
    elif sentiment < -0.5:
        return "I'm sorry to hear that you're feeling down. Is there anything I can do to help?"
    else:
        return "I'm here to help! What can I do for you today?"

# Flask API Setup
app = Flask(__name__)

@app.route('/chat', methods=['POST'])
def chat():
    user_input = request.json.get('message')
    if user_input:
        response = handle_conversation(user_input)
        return jsonify({'response': response})
    return jsonify({'error': 'No message provided'}), 400

if __name__ == '__main__':
    app.run(debug=True)