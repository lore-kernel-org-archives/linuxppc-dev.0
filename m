Message-ID: <017501bfb26a$8fcda600$bf0102c8@dell191.sc.mcel.mot.com>
From: "Rolf Liu" <rolfl@sc23.sc.mcel.mot.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Who ever encounter such an so strange problem about compiling ?
Date: Sun, 30 Apr 2000 07:08:53 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,everyone,
I am compiling the 8xxrom,which is the start-up and initialization code for
ppc 8xx board.And I have encountered so strange an problem:
"I can't compile the start.S file.",when I compile this file using the
following
flags , there comes so man errors:

powerpc-linux-gcc -g -O2 -mcpu=823 -Wall -I. -I./linux/include -I./linux/arc
h/pp
c/8xx_io -D__powerpc__ -DMHZ_50 -D__KERNEL__ -DDATA_MEM_ADDR=0x00010000 -DCO
NFIG
_8xx -fsigned-char -msoft-float  -pipe -fno-builtin -ffixed-r2 -Wno-uninitia
lize
d -mmultiple -mstring -D__ASSEMBLY__ -c romsys/start.S -o romsys/start.o

../usr/include/asm/fads.h: Assembler messages:
../usr/include/asm/fads.h:14: Error: Unrecognized opcode: `typedef'
../usr/include/asm/fads.h:15: Error: Unrecognized opcode: `unsigned'
../usr/include/asm/fads.h:16: Error: Unrecognized opcode: `unsigned'
../usr/include/asm/fads.h:17: Error: Unrecognized opcode: `unsigned'
../usr/include/asm/fads.h:18: Error: Unrecognized opcode: `unsigned'
../usr/include/asm/fads.h:19: Error: Unrecognized opcode: `unsigned'
../usr/include/asm/fads.h:20: Error: Rest of line ignored. First ignored
charac.
../usr/include/asm/fads.h:22: Error: Unrecognized opcode: `extern'

That seems the as(power-pc) can't recognize the `typedef`....,but why?
the most strange thing is when I move the start.S to another directory,
the compilation is successful.
who can give me a good answer?
thanks  a lot !!!!!!!


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
