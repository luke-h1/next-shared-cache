FROM node:20.11.0-alpine as base

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"

RUN npm i -g pnpm@9.0.6

WORKDIR /app

FROM base as builder 

COPY . .

RUN --mount=type=cache,id=pnpm,target=/pnpm/store \
    pnpm --frozen-lockfile --ignore-scripts install

RUN pnpm build

# production stage
FROM base as runner
WORKDIR /app

ENV NODE_ENV production

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

# Set the correct permission for prerender cache
RUN mkdir .next
RUN chown nextjs:nodejs .next

RUN apk add --no-cache bash tzdata git make clang

EXPOSE 3000
ENV port 3000
ENV HOSTNAME "0.0.0.0"

CMD ["pnpm", "start"]