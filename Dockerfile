# Use an official Python runtime as a parent image
FROM python:3.9-slim-buster

# Set the working directory to /app
WORKDIR /app

# Copy the requirements file into the container at /app
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container at /app
COPY Django-Project /app

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV DJANGO_ENV=production

# Run Django migrations
RUN python manage.py migrate --noinput

# Expose the port that the Django app will listen on
EXPOSE 8000

# Start the Django app using Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "myproject.wsgi"]
