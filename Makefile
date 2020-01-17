MODULES := $(dir $(wildcard */))

MODULE_TEST_TARGETS := $(addprefix test., $(MODULES))


test: $(MODULE_TEST_TARGETS)

$(MODULE_TEST_TARGETS): test.%:
	cd $* && terraform init && AWS_DEFAULT_REGION=us-west-1 terraform validate

clean:
	find . -name .terraform -exec rm -rf "{}" \;

.PHONY: test $(MODULE_TEST_TARGETS)
