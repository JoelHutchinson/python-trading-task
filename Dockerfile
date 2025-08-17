FROM python:3.9

# Set working directory
WORKDIR /code

# Install Poetry
RUN pip install --no-cache-dir poetry

# Copy Poetry config for better caching
COPY pyproject.toml poetry.lock /code/

# Install dependencies
RUN poetry config virtualenvs.create false \
    && poetry install --no-root --no-interaction --no-ansi

# Copy application code
COPY ./app /code/app

# Ensure __init__.py exists
RUN touch /code/app/__init__.py

# Install Uvicorn (after installing dependencies)
RUN pip install "uvicorn[standard]>=0.22.0,<0.23.0"

# Set PYTHONPATH so internal imports work
ENV PYTHONPATH="/code"

# Run the app
CMD ["uvicorn", "app.app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
