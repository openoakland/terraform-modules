MODULES := \
    beanstalk_app \
    beanstalk_env

MODULE_TEST_TARGETS := $(addprefix test., $(MODULES))


test: $(MODULE_TEST_TARGETS)

$(MODULE_TEST_TARGETS): test.%:
	cd $* && terraform init && terraform validate -check-variables=false


.PHONY: test $(MODULE_TEST_TARGETS)
