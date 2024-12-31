# Base image with R, Quarto, and renv support
FROM analythium/r2u-quarto:20.04

# Set the working directory
WORKDIR /usr/src/app

# Copy and install R dependencies
# Use a single RUN command to minimize image layers
COPY renv.lock renv.lock
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json
COPY .Rprofile .Rprofile
RUN R -e "install.packages('renv')" && \
    R -e "renv::restore(prompt = FALSE)"

# Copy Quarto project files
COPY _quarto.yml _quarto.yml
COPY website/index.qmd .

# Set the default command to render the Quarto project
CMD ["quarto", "render", "/usr/src/app"]
