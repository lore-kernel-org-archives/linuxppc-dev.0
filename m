Message-ID: <3AB0F900.EB03EB20@esd-electronics.com>
Date: Thu, 15 Mar 2001 18:16:48 +0100
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: compiling 2.4.0 for IBM405CR problem
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

while building a kernel from the MontaVista sources (2.4.0) for the
IBM405CR I got these undefined references:

arch/ppc/kernel/kernel.o: In function `time_init':
/home/matthias/canbtgw/linux/linux_01.02.16/arch/ppc/kernel/time.c:326:
undefined reference to `isa_io_base'
/home/matthias/canbtgw/linux/linux_01.02.16/arch/ppc/kernel/time.c:326:
undefined reference to `isa_mem_base'
/home/matthias/canbtgw/linux/linux_01.02.16/arch/ppc/kernel/time.c:326:
undefined reference to `pci_dram_offset'
make: *** [vmlinux] Error
1

What can I do ?

Matthias
--
-------------------------------------------------
\ Matthias Fuchs                                 \
 \ esd electronic system design Gmbh              \
  \ Vahrenwalder Straﬂe 205                        \
   \ D-30165 Hannover                               \
    \ email: matthias.fuchs@esd-electronics.com      \
     \ phone: +49-511-37298-0                         \
      \ fax:   +49-511-37298-68                        \
       --------------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
