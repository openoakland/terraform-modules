MODULES := $(dir $(wildcard */))

MODULE_TEST_TARGETS := $(addprefix test., $(MODULES))


test: $(MODULE_TEST_TARGETS)

$(MODULE_TEST_TARGETS): test.%:
	cd $* && terraform init && terraform validate -check-variables=false

clean:
	find . -name .terraform -exec rm -rf "{}" \;

.PHONY: test $(MODULE_TEST_TARGETS)
