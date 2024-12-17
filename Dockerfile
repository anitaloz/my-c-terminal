# # Stage 1: Build the C code
# FROM alpine:latest AS builder
# WORKDIR /app
# COPY src/ ./src/
# COPY Makefile ./
# RUN apk add --no-cache make
# RUN make
# RUN apk add --no-cache libc6-dev musl-dev

# # Stage 2: Minimal image with only the terminal
# FROM alpine:latest
# WORKDIR /app
# COPY --from=builder /app/myterminal /usr/local/bin/myterminal
# CMD ["/usr/local/bin/myterminal"]




# Stage 1: Build dependencies and compile the C code
FROM gcc:11 AS builder
WORKDIR /app
COPY . .
RUN gcc -o myapp src/main.c

# Stage 2: Create the minimal runtime image
FROM debian:bullseye-slim
WORKDIR /app
COPY --from=builder /app/myapp .
CMD ["./myapp"]



# Stage 1: Build the C code (If needed - adapt to your build process)
#FROM alpine:latest AS builder
#WORKDIR /app
#COPY src/ ./src/
#COPY Makefile ./
#RUN make
#RUN apk add --no-cache libc6-dev musl-dev


# Stage 2: Minimal image with only the terminal
# FROM alpine:latest
# WORKDIR /app
# COPY src/myterminal /usr/local/bin/myterminal  
# RUN chmod +x /usr/local/bin/myterminal       
# CMD ["/usr/local/bin/myterminal"]            
