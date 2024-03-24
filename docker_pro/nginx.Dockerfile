# Use an official NGINX base image
FROM nginx:latest

LABEL maintainer="Viney Vean <viney.vean@gmail.com>"

# Remove the default Nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Copy NGINX configuration file to conf.d, this block is for http configuration
COPY ../requirements/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ../requirements/nginx/keycloak_http.conf /etc/nginx/conf.d/pgadmin.conf

# Copy NGINX configuration stream file to streamconf.d, this block is for stream configuration
COPY ../requirements/nginx/postgres.conf /etc/nginx/stream_conf.d/postgres.conf
COPY ../requirements/nginx/keycloak.conf /etc/nginx/stream_conf.d/keycloak.conf

# Start NGINX when the container starts
CMD ["nginx", "-g", "daemon off;"]
