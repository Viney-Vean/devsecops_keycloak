# Use the Keycloak base image
FROM quay.io/keycloak/keycloak:latest

# Copy the custom entrypoint script to /usr/local/bin and set execute permissions
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x entrypoint.sh
# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
