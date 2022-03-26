FROM circleci/golang:1.17 as builder
ENV CGO_ENABLED 0
WORKDIR /home/circleci/project

COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN make

FROM cimg/base:2022.03 as production

COPY --from=builder /home/circleci/project/build/linux/amd64/circleci /usr/local/bin
