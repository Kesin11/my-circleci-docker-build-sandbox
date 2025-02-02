FROM circleci/golang:1.17 as builder
ENV CGO_ENABLED 0
# If don't change USER from circleci, build will fail only exec on CircleCI
USER root
WORKDIR /home/circleci/project

COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN make

FROM cimg/base:2022.03 as production
LABEL org.opencontainers.image.source https://github.com/Kesin11/my-circleci-docker-build-sandbox

COPY --from=builder /home/circleci/project/build/linux/amd64/circleci /usr/local/bin
