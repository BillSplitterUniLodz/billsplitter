systemctl start docker
docker run -p 8000:8000 amazon/dynamodb-local
rake dynamoid:create_tables

