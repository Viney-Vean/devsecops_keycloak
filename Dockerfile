# Use the Keycloak base image
FROM quay.io/keycloak/keycloak:latest

# Copy the custom entrypoint script to /usr/local/bin and set execute permissions
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chmod +x /opt/keycloak/bin/kc.sh
# Set the entrypoint
CMD ["/usr/local/bin/entrypoint.sh"]
