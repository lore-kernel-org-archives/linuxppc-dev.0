Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Sat, 24 Aug 2002 08:07:28 +0800
From: leeyang <leeyang@ycig.com>
Subject: Re: linux booting
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <002301c24b03$038024f0$fc4bb73d@leeyang>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
References: <20020823142319.BFD6111822@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > When I "bootm 0x10000"in ppcboot,it runs to
> > "Transferring control to linux kernel",then hangs
> > there,and I see nothing in the console.:(
>
> This will never work. I bet it  didn't  work  with  your  old  kernel
> either.  0x10000  is  just  64  kB  -  this  is _never_ enough for an
> uncompressed Linux kernel.  You  will  overwrite  your  kernel  while
> uncompressing it, which crashes the system. Use a higher load address,
somthing like 0x200000.

Sorry! I lost a zero here,I mean 0x100000,so old kernel can boot there.
>
> > In the PPCBoot guide(FAQ section),it mentioned
> > 2 possible causes,wrong bdinfo and clocks_in_mhz
> > I do check it and feel nothing wrong,however
> > nothing yet.
>
> You have to _unset_ clocks_in_mhz for a 2.4.20-pre2 kernel.
>
> > I have a BDI2000,but I think I should debug the bootm
> > part of ppcboot,however someone says it is quite
> > difficult to do so( at least for me).
>
> Well, it's not _that_ difficult. Try it out, so you get used to is ;-)

I wish it is not that hard,however I can not debug the kernel or
ppcboot according the  brief introduction in BDI manual.:(

I want to watch r3,r4,r5,r6,r7 register when ppcboot transferring
to kernel.Could you tell me how to get that? thanks a lot!
>
> > so I am seeking errors in blind.
>
> Just open your eyes, and thou shalt see :-)
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> Always leave room to add an explanation if it doesn't work out.
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
