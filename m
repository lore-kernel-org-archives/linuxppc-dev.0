Message-ID: <386C6B4F.FB124BC0@huawei.com.cn>
Date: Fri, 31 Dec 1999 16:37:35 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: Jeff Millar <jeff@wa1hco.mv.com>,
        linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Please help me...
References: <386C150F.22B1A3D0@huawei.com.cn> <000401bf5016$4757c420$0201a8c0@home>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> The zImage contains an uncompress program at the start.  This program then
> copies and uncompresses the kernel to another location in ram.

> If your
> using the kernel from Dan at
>
>     ftp://linuxppc.cs.nmt.edu/pub/linuxppc/embedded/
>
> Then use the debugger to start it at 0x00200000.  Refer to the code in
> arch/ppc/mbxboot/misc.c

Yes, I use the mpc8xx.2.2.13.tgz to compile the kernel "zImage".
Do you mean that when I download the kernel "zImage" to RAM address 0x100000
on our own board (but not mbxboard) , and jump to 0x100000, It will
automatically run the uncompress program to copy and decompress the kernel to
0x200000, then  jump to 0x200000, the decompressed kernel will boot,  right  ?



>
>
> I'm not the expert, Dan is, but he's been teaching me.
>
> jeff
> ----- Original Message -----
> From: "dony" <dony.he@huawei.com.cn>
> To: "Raphael Bossek" <raphael.bossek@solutions4linux.de>; "Brendan Simon"
> <bsimon@ctam.com.au>; "Dan Malek" <dan@netx4.com>; "linuxppc-embed"
> <linuxppc-embedded@lists.linuxppc.org>
> Sent: Thursday, December 30, 1999 9:29 PM
> Subject: Please help me...
>
> >
> > Hi,
> >       Now I am trying to embed linux onto our MPC860-based board. I have
> > some questions which may be solved by you embed-linux gurus....
> >      What I want to do  is the following:
> >     1     Initialize the MPC860 CPU , memory, serial port, enet port .
> >     2    Download  the linux powerpc kernel (which I have cross-compiled
> > on my X86 box)
> >            from the TFTP server to RAM on board.
> >     3    run the kernel.
> > Now the 1 and 2 step work well, but when I download the kernel to RAM on
> > board, It just cannot run.Do you know why? How can I programme to make
> > it run? Since the kernel is a compressed image (zvmlinux), need I make
> > some codes to decompress it and then run it? if so, how to do it?
> >  Thank you very much :-))
> >  Merry christmas & happy year.
> >
> > dony
> >
> >

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
