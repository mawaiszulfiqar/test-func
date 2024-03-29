FROM node:18 as build
ARG APP_CONTEXT 
ARG PORT=3000

WORKDIR /build
COPY package.json .
COPY yarn.lock .
COPY ./apps/${APP_CONTEXT}/package.json apps/${APP_CONTEXT}/
COPY ./packages packages
RUN yarn install
COPY ./apps/${APP_CONTEXT} apps/${APP_CONTEXT}

WORKDIR /build/apps/${APP_CONTEXT}
RUN yarn build


FROM build as server

EXPOSE ${PORT}
CMD ["yarn", "start"]
