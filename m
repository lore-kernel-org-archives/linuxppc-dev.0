From: Miles Lane <miles.lane@comcast.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.6.0-test3-bk1 -- include/asm/smp.h:61: error: `NR_CPUS' undeclared (first use in this function)
Date: Sun, 10 Aug 2003 11:42:16 -0700
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200308101142.16491.miles.lane@comcast.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  CC      kernel/timer.o
In file included from include/linux/smp.h:17,
                 from include/linux/kernel_stat.h:6,
                 from kernel/timer.c:22:
include/asm/smp.h: In function `any_online_cpu':
include/asm/smp.h:61: error: `NR_CPUS' undeclared (first use in this function)
include/asm/smp.h:61: error: (Each undeclared identifier is reported only once
include/asm/smp.h:61: error: for each function it appears in.)
make[1]: *** [kernel/timer.o] Error 1

CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_6xx=y

CONFIG_PM=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_PPC_STD_MMU=y
CONFIG_PPC_MULTIPLATFORM=y

CONFIG_PPC_CHRP=y
CONFIG_PPC_PMAC=y
CONFIG_PPC_PREP=y
CONFIG_PPC_OF=y
CONFIG_SMP=y
CONFIG_NR_CPUS=2
CONFIG_ALTIVEC=y
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_TABLE=y
CONFIG_CPU_FREQ_PROC_INTF=y
CONFIG_CPU_FREQ_24_API=y
CONFIG_CPU_FREQ_PMAC=y


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
