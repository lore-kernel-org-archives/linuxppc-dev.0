Message-ID: <3A55F347.2DC0065E@iiic.ethz.ch>
Date: Fri, 05 Jan 2001 17:16:07 +0100
From: Michel Dänzer <michdaen@iiic.ethz.ch>
MIME-Version: 1.0
To: christophe barbe <christophe.barbe@inup.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: gcc, floating point and linux kernel module
References: <20010105101323.B9136@pc8.inup.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


christophe barbe wrote:

> I'm compiling a kernel module for the linux 2.2.18 on a PPC target (MPC750)
> with the following gcc :
> gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)
>
> The resulting object uses FPU opcode to do optimization for 64 bits
> variables. I've add at the end of this mail the command line to compile one
> of the object included in the module which uses FPU, the guilty part of the
> code and the generated asm.
>
> It's a bad thing to use FPU in the kernel mode (under linux), so my question
> is is there a way to turn of FPU usage ?

arch/ppc/Makefile uses -msoft-float.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
