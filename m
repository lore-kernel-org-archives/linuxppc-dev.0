Message-ID: <3ECA7096.9060607@mvista.com>
Date: Tue, 20 May 2003 11:14:46 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: dong in kang <dkang@east.isi.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel parameters (Sandpoint X3 with Altimus MPC755)
References: <001401c31ef9$329f8170$45a97241@Minjoo>
In-Reply-To: <001401c31ef9$329f8170$45a97241@Minjoo>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


dong in kang wrote:

> As a debugging tool, I'm using Metrowerks Codewarrior v.6.0 running on
>Windows 2000 platform.
>The BDI2000 for Codewarrior is connected to the JTAG port of the Sandpoint
>X3.
>I used the Codewarrior to load the linux kernel to the SDRAM of the
>Sandpoint X3.
>Of course, I used GCC to compile Montavista Linux kernel.
>(I heard that BDIgdb is the best tool for Linux kernel debugging.
>I'm considering purchasing BDIgdb.
>
Okay, that helps...I think.  I still don't know what "BDI2000 for
codewarrior" means/is but anyway...

For right now, I recommend just using the telnet interface to the bdi.
Its simple and works.  You can download the zImage thru that interface
(and tftp).  The bdi manual has a page with all the cmds on it.  Also,
while using the telnet interface, use only hard breakpoints (which means
you can only have one set at a time).

> Currently, I have a problem of enabling
>mmu.
>After the initial boot part of the Linux finishes setting up BATs and
>enables the mmu,
>the address translation is not done properly. So, when the kernel jumps to
>0xC0000000, it jumps to physical address 0xC0000000.
>It crashes there. I suspect BDI2000 with Codewarrior does not support mmu.
>
>
You shouldn't be having problems like that.  Are you sure you used a
valid .config when you built the kernel?  What address did you download
the zImage to?  Did you try building/running the non-initrd image
(zImage.sandpoint)?

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
