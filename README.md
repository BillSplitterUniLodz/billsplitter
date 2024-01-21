# README
# Create database
docker-compose up --build dynamodb dynamodb-admin

rake dynamoid:create_tables

# Run dev console

rails c

# Start server

rails s
