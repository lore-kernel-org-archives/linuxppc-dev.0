From: MAC21C@chollian.net
Message-Id: <200010260055.JAA14919@ldap.dacom.co.kr>
Date: Thu, 26 Oct 2000 09:56:23 +0900
To: linuxppc-embedded@lists.linuxppc.org
Subject: QM_MODULES
Reply-To: MAC21C@chollian.net
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello all!!

I have a problum.

I made the test.c file for device driver test.

========== test.c ===================
#define MODULE
#include <linux/kernel.h>
#include <linux/module.h>

#if CONFIG_MODVERSIONS==1
#define MODVERSION
#include <linux/modversions.h>
#endif

int init_module(void) { printk("Hello, kim\n"); return 0; }
void cleanup_module(void) { printk("Goodbye Kim\n"); }
======================================
And, compile options
powerpc-linux-gcc -D__KERNEL__ -O -c test.c
/tmp/cc8k7ews.s: Assembler messages:
/tmp/cc8k7ews.s:6: Warning: Ignoring changed section attributes for .modinfo

warning message and i execute the insmod

insmod test.o
insmod : QM_MODULES function not implmented

I don't know, warning message and error message.

help me~~!!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
