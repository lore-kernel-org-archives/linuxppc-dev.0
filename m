Date: Tue, 6 Nov 01 12:58:40 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111062058.AA03040@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: PATCH K2: remove dead code
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

Whoever has moved the two tiny shim functions from k2_pic.c into k2_setup.c
(mporter according to the logs) has apparently forgotten to delete k2_pic.c,
which is now dead code. This patch does so.

MS

Delete: arch/ppc/kernel/k2_pic.c
diff -Nru a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
--- a/arch/ppc/kernel/Makefile	Tue Nov  6 12:39:29 2001
+++ b/arch/ppc/kernel/Makefile	Tue Nov  6 12:39:29 2001
@@ -80,8 +80,8 @@
 					indirect_pci.o pci_auto.o todc_time.o
 obj-$(CONFIG_GEMINI)		+= gemini_prom.o gemini_pci.o gemini_setup.o \
 					open_pic.o
-obj-$(CONFIG_K2)		+= k2_setup.o k2_pic.o k2_pci.o i8259.o \
-					indirect_pci.o todc_time.o pci_auto.o
+obj-$(CONFIG_K2)		+= k2_setup.o k2_pci.o i8259.o indirect_pci.o \
+					todc_time.o pci_auto.o
 obj-$(CONFIG_LOPEC)		+= lopec_setup.o lopec_pci.o mpc10x_common.o \
 					indirect_pci.o pci_auto.o open_pic.o \
 					i8259.o todc_time.o

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
