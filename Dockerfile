FROM rstudio/plumber

# Add the scripts to the directory
COPY . /app/

WORKDIR /app

RUN R -e "install.packages('rjson'); \
          install.packages('remotes'); \
          remotes::install_deps('Playground', dependencies = TRUE); \
          remotes::install_local('Playground');"

CMD ["/app/plumber.R"]
