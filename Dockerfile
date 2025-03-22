FROM node:22-alpine AS build-env
WORKDIR /app
RUN corepack enable pnpm && corepack install -g pnpm@latest-10
COPY pnpm-lock.yaml ./
RUN pnpm fetch

ADD . ./
RUN pnpm install -r --offline
RUN pnpm build

FROM nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build-env /app/build/client/ /app/


