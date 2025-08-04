# syntax=docker.io/docker/dockerfile:1.7-labs
FROM python:3.11

ENV DUO_USE_VENV=false
ENV PYTHONUNBUFFERED=true

WORKDIR /app

# Copy project into /app (we’re already in /app because of WORKDIR)
COPY --exclude=antiabuse/antiporn --exclude=test --exclude=vm . .

# Install deps, fix line-endings, make script executable
RUN apt-get update -y \
 && apt-get install -y ffmpeg dos2unix \
 && dos2unix /app/api.main.sh \
 && chmod +x /app/api.main.sh \
 && pip install --no-cache-dir -r requirements.txt \
 && python -m spacy download en_core_web_sm

# Explicit exec-form command
CMD ["bash", "/app/api.main.sh"]
