CACHED :=

build: cache
	chmod 0755 .cache/bin/* rc/concourse-*
	docker build -t homeports-dev/concourse .
clean:
	rm -fr .cache

CACHED += .cache/bin/init
.cache/bin/init:
	mkdir -p $$(dirname $@)
	curl -Lo $@ http://ci-niftylogic-com.s3.amazonaws.com/init-linux_amd64

CACHED += .cache/bin/rlog
.cache/bin/rlog:
	mkdir -p $$(dirname $@)
	curl -Lo $@ http://ci-niftylogic-com.s3.amazonaws.com/rlog-linux_amd64

CACHED += .cache/bin/concourse
.cache/bin/concourse:
	mkdir -p $$(dirname $@)
	curl -Lo $@ https://github.com/concourse/concourse/releases/download/v2.7.0/concourse_linux_amd64

CACHED += .cache/bin/fly
.cache/bin/fly:
	mkdir -p $$(dirname $@)
	curl -Lo $@ https://github.com/concourse/concourse/releases/download/v2.7.0/fly_linux_amd64

cache: $(CACHED)

.PHONY: build cache clean
