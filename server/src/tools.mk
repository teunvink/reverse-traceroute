BASE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
BIN := $(BASE_DIR)bin

LIBBPF_DIR := $(BASE_DIR)../libbpf
LIBBPF_SRC_DIR := $(LIBBPF_DIR)/src
LIBBPF_OUT_DIR := $(BIN)/libbpf
LIBBPF := $(LIBBPF_OUT_DIR)/libbpf.a

BPFTOOL_DIR := $(BASE_DIR)../bpftool
BPFTOOL_SRC_DIR := $(BPFTOOL_DIR)/src
BPFTOOL_OUT_DIR := $(BIN)/bpftool
BPFTOOL := $(BPFTOOL_OUT_DIR)/bpftool

INCLUDES := -I$(LIBBPF_OUT_DIR)

$(LIBBPF): | $(LIBBPF_OUT_DIR)
	$(MAKE) -C $(LIBBPF_SRC_DIR) BUILD_STATIC_ONLY=1 OBJDIR=$(LIBBPF_OUT_DIR) \
	   	DESTDIR=$(LIBBPF_OUT_DIR) INCLUDEDIR= USRDIR= install

$(BPFTOOL): | $(BPFTOOL_OUT_DIR)
	$(MAKE) -C $(BPFTOOL_SRC_DIR) OUTPUT=$(BPFTOOL_OUT_DIR)/

$(LIBBPF_OUT_DIR) $(BPFTOOL_OUT_DIR):
	@mkdir -p $@

.PHONY: clean
clean::
	rm -rf $(BIN)
