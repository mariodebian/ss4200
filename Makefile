#DEBUG ?= n
KVERS ?=`uname -r`
KSOURCE ?= /usr/src/linux-headers-$(KVERS)


%.x:%.c
	gcc -o $@ $<

KBUILD_VERBOSE:=0

#obj-$(CONFIG_LEDS_INTEL_SS4200)		+= leds-ss4200.o
obj-m		+= leds-ss4200.o



default:
	make -C $(KSOURCE) LANG=C KBUILD_VERBOSE=${KBUILD_VERBOSE}  M=`pwd` modules

check:
	make -C $(KSOURCE) LANG=C KBUILD_VERBOSE=${KBUILD_VERBOSE} C=1 M=`pwd` modules

.PHONY: cscope
cscope:
	cscope -b -k -R

.PHONY: clean
clean:
	make -C $(KSOURCE) LANG=C KBUILD_VERBOSE=${KBUILD_VERBOSE}  M=`pwd` clean
	rm -f *.x *~ modules.order

install:
	mkdir -p /lib/modules/$(KVERS)/updates/ss4200
	install -m 644 leds-ss4200.ko /lib/modules/$(KVERS)/updates/ss4200
	depmod -ae
