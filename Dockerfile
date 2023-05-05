# Use an official Python runtime as a parent image
FROM python:3.9-slim-buster

# Set the working directory to /app
WORKDIR /app

# Copy the requirements.txt and nltk.txt file into the container at /app
COPY requirements.txt nltk.txt ./

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
RUN python -m nltk.downloader -d /usr/local/share/nltk_data -r nltk.txt

# Copy the runtime.txt and Procfile file into the container at /app
COPY runtime.txt Procfile ./

# Set environment variable for python runtime
ENV PYTHON_RUNTIME=$(cat runtime.txt)

# Expose port 5000 for the Flask app
EXPOSE 5000

# Copy the rest of the application code into the container at /app
COPY . .

# Run the command specified in Procfile to start the Flask app
CMD honcho start
