REPOSITORY=docker-terraform
CONTAINER=terraform
NAMESPACE=marcelocorreia

pipeline:
	fly -t main set-pipeline \
		-n -p $(CONTAINER) \
		-c pipeline.yml \
		-l /home/marcelo/.ssh/ci-credentials.yml \
		-v git_repo_url=git@github.com:$(NAMESPACE)/$(REPOSITORY).git \
        -v container_fullname=$(NAMESPACE)/$(CONTAINER) \
        -v container_name=$(CONTAINER) \
		-v git_repo=$(REPOSITORY) \
        -v git_branch=master

	fly -t main unpause-pipeline -p $(CONTAINER)
.PHONY: pipeline

destroy-pipeline:
	fly -t main destroy-pipeline \
	-p $(CONTAINER)

build:
	docker build -t $(NAMESPACE)/$(CONTAINER) .
.PHONY: build

run:
	docker run --rm $(NAMESPACE)/$(CONTAINER)
.PHONY: run

