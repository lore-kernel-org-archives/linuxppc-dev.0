Message-ID: <3B55931C.1D2678D8@highway.ne.jp>
Date: Wed, 18 Jul 2001 22:46:05 +0900
From: kaoru Fukui <k_fukui@highway.ne.jp>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: linux kernel-2.4.7.pre7 from bk tree
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

I have a promlem.
here is

ld  -r -o kernel.o entry.o traps.o irq.o idle.o time.o misc.o process.o
signal.o ptrace.o ppc_htab.o semaphore.o syscalls.o align.o setup.o
ppc_ksyms.o pci.o pci-dma.o smp.o pmac_pic.o pmac_setup.o pmac_time.o
prom.o feature.o pmac_pci.o chrp_setup.o chrp_time.o chrp_pci.o
open_pic.o indirect_pci.o i8259.o prep_pci.o prep_time.o prep_nvram.o
prep_setup.o pmac_nvram.o pmac_backlight.o sleep.o
smp.o: In function `ipi_recv':
smp.o(.sbss+0x14): multiple definition of `ipi_recv'
irq.o(.sbss+0xc): first defined here
smp.o: In function `ipi_sent':
smp.o(.sbss+0x18): multiple definition of `ipi_sent'
irq.o(.sbss+0x10): first defined here
prep_setup.o: In function `empty_zero_page':
prep_setup.o(.bss+0x0): multiple definition of `empty_zero_page'
chrp_setup.o(.bss+0x0): first defined here
make[1]: *** [kernel.o] Error 1
make[1]: Leaving directory `/usr/src/redhat/BUILD/linux/arch/ppc/kernel'

make: *** [_dir_arch/ppc/kernel] Error 2
[root@g4mpKFUKUI linux]#


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
