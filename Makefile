MODULES := \
    beanstalk_app \
    beanstalk_env

MODULE_LINT_TARGETS := $(addprefix lint., $(MODULES))


lint: $(MODULE_LINT_TARGETS)

$(MODULE_LINT_TARGETS): lint.%:
	cd $* && terraform init && terraform validate -check-variables=false


.PHONY: lint $(MODULE_LINT_TARGETS)
