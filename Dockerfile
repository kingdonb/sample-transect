FROM kingdonb/docker-rvm-support:latest AS builder

LABEL version="2.0.0"
LABEL maintainer="kingdon.b@nd.edu"
ENV RUBY=2.7.1

# USER ${RVM_USER}

COPY --chown=${RVM_USER} Gemfile Gemfile.lock .ruby-version ${APPDIR}/
# COPY --chown=${RVM_USER} vendor/gems ${APPDIR}/vendor/gems
RUN rvm ${RUBY} do bash -c 'bundle config set frozen true && bundle install && bundle clean --force'

COPY --chown=${RVM_USER} Rakefile ${APPDIR}/
COPY --chown=${RVM_USER} config/ ${APPDIR}/config/
COPY --chown=${RVM_USER} bin/ ${APPDIR}/bin/

COPY --chown=${RVM_USER} app/javascript ${APPDIR}/app/javascript/
COPY --chown=${RVM_USER} .browserslistrc babel.config.js package.json yarn.lock postcss.config.js ${APPDIR}/

RUN ASSET_PRECOMPILE=1 rvm ${RUBY} do bundle exec rake assets:precompile
ENV RAILS_ENV production

RUN rvm ${RUBY} do bundle install
RUN yarn install
RUN ASSET_PRECOMPILE=1 rvm ${RUBY} do bundle exec rake assets:precompile

FROM builder AS dev
ENV RAILS_ENV development

RUN  rvm ${RUBY} do bash -c 'bundle config set with development && bundle install'
ENV PORT 3000
EXPOSE 3000

FROM kingdonb/docker-rvm-support:latest AS production

LABEL version="2.0.0"
LABEL maintainer="kingdon.b@nd.edu"
ENV RUBY=2.7.1

USER root

# WORKDIR ${APPDIR} - this is set upstream by docker-rvm-support
COPY --chown=${RVM_USER} --from=builder /usr/local/ /usr/local/
COPY --chown=${RVM_USER} --from=builder ${APPDIR} ${APPDIR}
COPY --chown=${RVM_USER} . ${APPDIR}
# RUN chown -R ${RVM_USER} ${APPDIR}
USER ${RVM_USER}
ENV RAILS_ENV production
RUN echo 'gem: --no-document' > /home/${RVM_USER}/.gemrc && bash -
RUN yarn install --check-files
RUN ./bin/webpack

# Expose port 3000 to the Docker host, so we can access it
# from the outside.
ENV PORT 3000
ENV RAILS_SERVE_STATIC_FILES true
EXPOSE 3000

CMD rvm ${RUBY} do bash --login -c 'rails s -p $PORT -b 0.0.0.0'