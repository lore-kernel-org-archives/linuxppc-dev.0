Message-ID: <40EF2824.7030109@g-house.de>
Date: Sat, 10 Jul 2004 01:20:04 +0200
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: still binutils problems: Error: Unrecognized opcode: `dssall'
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



hi,

$subject was discussed quite often here, but i am not sure, if a
solution was found. may i ask if the error is a toolchain (gcc/binutils)
error, or is the kernel to be fixed?

thanks,
Christian.

  CC      arch/ppc/kernel/ppc_htab.o
  AS      arch/ppc/kernel/l2cr.o
arch/ppc/kernel/l2cr.S: Assembler messages:
arch/ppc/kernel/l2cr.S:110: Error: Unrecognized opcode: `dssall'
arch/ppc/kernel/l2cr.S:278: Error: Unrecognized opcode: `dssall'
arch/ppc/kernel/l2cr.S:387: Error: Unrecognized opcode: `dssall'
make[1]: *** [arch/ppc/kernel/l2cr.o] Error 1

GNU ld version 2.15
  Supported emulations:
   elf32ppclinux
   elf32ppc
   elf32ppcsim

- --
BOFH excuse #416:

We're out of slots on the server

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
