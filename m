To: "Stuart Vivian" <stuartvivian@domo.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2_4_devel kernel hangs after control transferred from u-boot 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 02 Oct 2003 14:29:18 BST."
             <A4EB77D93A60F347A518AC05291647D9032E5E@domosvr1.domo.local>
Date: Thu, 02 Oct 2003 15:43:40 +0200
Message-Id: <20031002134345.71B61C59E4@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <A4EB77D93A60F347A518AC05291647D9032E5E@domosvr1.domo.local> you wrote:
>
> I am trying to get a linux kernel to build and run on a Cogent CSB272
> (IBM PPC 405GP processor) running a U-boot 0.4.0 bootloader. I can tftp
> a uImage into ram and it passes check, but when I run bootm it
> uncompresses the kernel and hangs after it starts executing the kernel
> at address 0x00000000.

This is a FAQ. See
http://www.denx.de/twiki/bin/view/DULG/LinuxHangsAfterUncompressingKernel

> I was given a hardhat vmlinux elf file that I can package to a uImage
> and run (although it stops at the Calibrating Delay loop... Stage, but

Probably the same problem - bad parameters (clock frequencies) passed
to the kernel.

> that's another issue). I need to be able to recompile a kernel for the
> board and downloaded linuxppc_2_4_devel from mvista. This compiles fine
> and produces a new vmlinux. I've started off by using the walnut 405
> config file to build the kernel, since they're pretty similar.

Ummm... you better make sure it really matches your board. Similar is
not enough.

> Any ideas where to start debugging this? I'm relatively new in embedded
> stuff and linux in general, so it might be something simple, but don't
> know where to start. Have a BDI2000 but no gdb driver yet, so can't put
> in breakpoints etc.

??? Can't parse that.

You can use the BDI's telnet interface to set breakpoints,  too.  And
you  don;t know any special "gdb driver", as any plain GDB will allow
you to connect to the BDI which "speaks" GDB remote protocol over the
network.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Why should we subsidize intellectual curiosity?" - Ronald Reagan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
