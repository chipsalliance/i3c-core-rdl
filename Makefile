# SPDX-License-Identifier: Apache-2.0

SHELL = /bin/bash
ROOT_DIR := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
SRC_DIR := $(ROOT_DIR)/src

PEAKRDL_CFG := $(SRC_DIR)/rdl/peakrdl.toml
export PEAKRDL_CFG
RDL_REGS := $(SRC_DIR)/rdl/registers.rdl

clean: ## Clean all generated sources
	rm -rf ./src/csr/html/
	rm -rf ./src/rdl/generate/

generate: ## Generate I3C SystemVerilog registers from SystemRDL definition
	python -m peakrdl regblock $(RDL_REGS) -o src/csr/ --cpuif passthrough
	python -m peakrdl html $(RDL_REGS) -o src/csr/html/
	python -m peakrdl markdown $(RDL_REGS) -o src/csr/documentation.md
	python -m peakrdl c-header $(RDL_REGS) -o src/csr/I3CCSR.h
.PHONY: generate

.DEFAULT_GOAL := help
HELP_COLUMN_SPAN = 11
HELP_FORMAT_STRING = "\033[36m%-$(HELP_COLUMN_SPAN)s\033[0m %s\n"
help: ## Show this help message
	@echo List of available targets:
	@grep -hE '^[^#[:blank:]]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf $(HELP_FORMAT_STRING), $$1, $$2}'
	@echo
	@echo List of available optional parameters:
	@echo -e "\033[36mTEST\033[0m        Name of the test run by 'make test' (default: None)"
