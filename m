Message-ID: <3896CEA3.EBA97957@ctam.com.au>
Date: Tue, 01 Feb 2000 23:16:35 +1100
From: Brendan John Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx-2.2.13 kernel hangs during boot.
References: <200002010035.BAA26304@denx.local.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

> In message <3896BF04.55AD7C4F@ctam.com.au> you write:
> >
> > I based my port on the BSEIP board as it is the simplest.
> > The IMMR is at 0xff000000 and all peripherals are mapped above 0x80000000
> > except for DRAM which is mapped at 0x00000000.
>
> Do youmean you have  any  peripherals  mapped  at  addresses  in  the
> 0x80000000 ... 0xC0000000 range? I don't think this will work...

Sorry about my ignornace but why can't I use the address range
0x80000000-0xBFFFFFFF for my peripherals ?
Is 0xC0000000-0xFFFFFFFF ok ?  What address range would be recommended ?


> > I didn't think so.  The embedded-2.2.5 kernel works fine with the same
> > bootloader.  I forgot to mention the the embedded-2.2.5 kernel is compiled
>
> What does "works fine" mean? Can you  run  any  serious  applications
> which *use* (nearly) all your available memory?

No I haven't tried any serious applications.  I just got a simple test app
working with dynamic linking using the embedded-2.2.5 kernel compiled with
binutils-2.9.5.0.24/gcc-2.95.2.  I would prefer to use mpc8xx-2.2.13.
I now have to put some serious applications together such as telnetd, snmpd,
etc.


> > How can I look at this memory area ?  With a BDM debugger ?  I thought BDM
> > can't be used.
>
> Of course this will work with a BDM debugger. Why should it fail???

There have been many postings to this list stating that BDM will not work after
the kernel is running.  I think it has something to do with the MMU.  The
debugger does not know how to translate VMA to PMA.  Do you believe this
statement is correct ?  Can you confirm that the kernel can be debugged using a
BDM ?


> > Can a serial debugger be used ?
>
> What is a serial debugger? Do you have any type of boot monitor  with
> debugging features, or what?

I was thinking of gdb with a serial connection.  I do not have a boot monitor
with debugging features but I can write some gdb stubs if it is possible.  I
was basically asking whether it is possible or not to debug the kernel and/or
apps via a serial connection.

Thanks,
Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
