From: kris_kelvin@excite.com
To: linuxppc-dev@lists.linuxppc.org
Subject: MBX860, initrd, problems
Message-Id: <932163450.18283.993@excite.com>
Date: Fri, 16 Jul 1999 15:17:30 PDT
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi everybody.

I am new to this list (although I think I have done my
homework), so please accept my apologies if my questions
sound annoying to you.

I am planning to run Linux on a custom 860 board (which is
being built at the moment). For now, I am going to use an
MBX860 board for experiments.

I have downloaded some of the files available at
ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded and
I have read embedded_notes and mbxnotes.
My development platform includes an old 7200/75 Macintosh
on which I have installed Release 4 of PowerPC Linux - to
be used for compiling the kernel and programs for the
board - as well as a few PCs.

I have connected the board to my local Ethernet and plugged
its serial port to a serial port of one of my PCs.

My first problem is that I cannot compile the 2.2.5 kernel
that I downloaded from linuxppc.cs.nmt.edu. It gives me the
following compilation errors:

==================
m8xx_setup.c: In function `m8xx_init_IRQ':
m8xx_setup.c:280: warning: implicit declaration of function
`cpm_interrupt_init'
m8xx_setup.c:285: `i8259_pic' undeclared (first use this function)
m8xx_setup.c:285: (Each undeclared identifier is reported only once
m8xx_setup.c:285: for each function it appears in.)
m8xx_setup.c:287: warning: implicit declaration of function
`i8259_init'm8xx_setup.c:288: `mbx_i8259_action' undeclared (first use this
function)
m8xx_setup.c: In function `m8xx_ide_insw':m8xx_setup.c:300: too few
arguments to function `ide_insw'm8xx_setup.c:300: warning: left-hand operand
of comma expression has no effect
m8xx_setup.c:300: parse error before `)'
m8xx_setup.c: In function `m8xx_ide_check_region':m8xx_setup.c:325: parse
error before `}'m8xx_setup.c:325: warning: control reaches end of non-void
function
make[1]: *** [m8xx_setup.o] Error 1
==================

Now, when I look at the source, m8xx_setup.c appears to be
messy with many syntactic errors. What is going on? I though
that 2.2.5 was the recommended kernel. If this isn't the
case, perhaps somebody can point me to the place where I
can find the correct version.

On the other hand, I have managed to compile and boot the
2.2p7 kernel from linuxppc.cs.nmt.edu. Well, I could use
it as the target system, but I see that initrd support
(which I need) is missing from 2.2p7 (there's no mbxboot
directory in arch/ppc). So what should I do?

Some people on this list have successfully installed initrd
kernels on their boards. Perhaps they could point me to the
kernel they started with. Any hints will be much
appreciated. I don't want to get a free ride (I am prepared
to spend some effort on this project) but at least I would
like to know that I have started from the right place.

Thanks in advance and best regards,

Kris Kelvin




_______________________________________________________
Get your free, private email at http://mail.excite.com/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
