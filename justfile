# Local Variables:
# mode: makefile
# End:
# vim: set ft=make :

ISO_DATE_TAG  := `date +%Y%m%d`
GIT_SHORT_TAG := `git rev-parse --short HEAD`

IMAGE_SLUG := "registry.cloud.okteto.net/kingdonb/sample_transect:"
DEVIMAGE   := IMAGE_SLUG + "dev"
IMAGE      := IMAGE_SLUG + GIT_SHORT_TAG

install:
  kubectl apply -f k8s.yml

# quay:
#   docker build -t $(IMAGE) . && docker push $(IMAGE)

build:
  okteto build -t {{DEVIMAGE}} . --target dev \
    && okteto build -t {{IMAGE}} .

pull:
  docker pull {{IMAGE}}

run:
  yarn install --check-files
  RAILS_ENV=development exec ./bin/webpack-dev-server&
  RAILS_ENV=development bundle exec rails s -b 0.0.0.0
