From: Miles Lane <miles.lane@comcast.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.6.0-test2-bk2 (linus' tree) -- arch/ppc/platforms/pmac_cpufreq.c:219: undefined reference to `cpufreq_frequency_table_verify'
Date: Sun, 3 Aug 2003 14:56:11 -0700
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200308031456.11550.miles.lane@comcast.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


After patching arch/ppc/kernel/setup.c to include cpu.h,
I got this error:

  LD      .tmp_vmlinux1
arch/ppc/platforms/built-in.o(.pmac.text+0x584c): In function
`pmac_cpufreq_setup':
arch/ppc/platforms/pmac_cpufreq.c:219: undefined reference to
`cpufreq_frequency_table_verify'
arch/ppc/platforms/built-in.o(.pmac.text+0x588c):arch/ppc/platforms/pmac_cpufreq.c:229:
undefined reference to `cpufreq_frequency_table_target'
arch/ppc/platforms/built-in.o(.pmac.text+0x5930):arch/ppc/platforms/pmac_cpufreq.c:254:
undefined reference to `cpufreq_frequency_table_cpuinfo'
make: *** [.tmp_vmlinux1] Error 1

CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_6xx=y

CONFIG_PM=y
# CONFIG_8260 is not set
CONFIG_GENERIC_ISA_DMA=y
CONFIG_PPC_STD_MMU=y
CONFIG_PPC_MULTIPLATFORM=y
CONFIG_PPC_CHRP=y
CONFIG_PPC_PMAC=y
CONFIG_PPC_PREP=y
CONFIG_PPC_OF=y
CONFIG_ALTIVEC=y
CONFIG_TAU=y
# CONFIG_TAU_INT is not set
CONFIG_TAU_AVERAGE=y
CONFIG_CPU_FREQ=y
# CONFIG_CPU_FREQ_PROC_INTF is not set
CONFIG_CPU_FREQ_24_API=y
CONFIG_CPU_FREQ_PMAC=y

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
