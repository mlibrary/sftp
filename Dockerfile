FROM ruby:3.2
ARG UNAME=app
ARG UID=1000
ARG GID=1000

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  vim

RUN gem install bundler
ENV BUNDLE_PATH /gems
ENV PATH="$PATH:/app/exe:/app/bin"

RUN groupadd -g ${GID} -o ${UNAME}
RUN useradd -m -d /app -u ${UID} -g ${GID} -o -s /bin/bash ${UNAME}
RUN mkdir -p /gems && chown ${UID}:${GID} /gems
USER $UNAME

WORKDIR /app
COPY --chown=${UID}:${GID} . /app
RUN bundle install
