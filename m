From: "dong in kang" <dkang@east.isi.edu>
To: "'Mark A. Greer'" <mgreer@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Kernel parameters (Sandpoint X3 with Altimus MPC755)
Date: Tue, 20 May 2003 13:56:53 -0400
Message-ID: <001401c31ef9$329f8170$45a97241@Minjoo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <3ECA67C0.5070306@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 As a debugging tool, I'm using Metrowerks Codewarrior v.6.0 running on
Windows 2000 platform.
The BDI2000 for Codewarrior is connected to the JTAG port of the Sandpoint
X3.
I used the Codewarrior to load the linux kernel to the SDRAM of the
Sandpoint X3.
Of course, I used GCC to compile Montavista Linux kernel.
(I heard that BDIgdb is the best tool for Linux kernel debugging.
I'm considering purchasing BDIgdb. Currently, I have a problem of enabling
mmu.
After the initial boot part of the Linux finishes setting up BATs and
enables the mmu,
the address translation is not done properly. So, when the kernel jumps to
0xC0000000, it jumps to physical address 0xC0000000.
It crashes there. I suspect BDI2000 with Codewarrior does not support mmu.

 Dong-In


-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org] On Behalf Of Mark A.
Greer
Sent: Tuesday, May 20, 2003 1:37 PM
To: dong in kang
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel parameters (Sandpoint X3 with Altimus MPC755)



dong in kang wrote:

> Hello,
> I'm trying to boot Montavista Linux kernel on Sandpoint X3 with
>Altimus MPC755 CPU without bootloader and without using DINK32. (I'm
>using BDI2000 with Metrowerks Codewarrior v.6.0).
>
What do you mean when you say, "I'm using BDI2000 with Metrowerks
Codewarrior v.6.0"?

>I could read/write SDRAM before manually loading zImange.initrd.
>However, I don't know how to setup kernel parameters and command lines.
>What information should I put for kernel parameters? and where?
>
>
You shouldn't need any cmdline arguments unless you're doing something
special.  If you are, look in Documentation/kernel-parameters.txt for more
info.

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
