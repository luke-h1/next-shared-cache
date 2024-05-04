FROM node:20.9.0-alpine as builder

COPY . ./usr/src

WORKDIR /usr/src

RUN --mount=type=cache,id=pnpm,target=/pnpm/store \
    npm install -g pnpm && \
    pnpm i

FROM builder


RUN pnpm build

WORKDIR /usr/src/apps/web

EXPOSE 3000
CMD ["pnpm", "start"]