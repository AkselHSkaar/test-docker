FROM node:20-alpine
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable

WORKDIR /app

COPY pnpm-lock.yaml* package*.json ./

COPY . .

RUN corepack prepare pnpm@latest-8 --activate
RUN pnpm install --frozen-lockfile

RUN pnpm run build

ENV PORT=4000
EXPOSE 4000

CMD ["pnpm", "run", "start"]

# docker build -f Dockerfile -t projectname:1.0 .
# docker run -d -p 4000:4000 projectname:1.0