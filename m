Message-Id: <200101040850.f048oN918835@denx.local.net>
To: "Rolf Liu" <rolfl@sc.mcel.mot.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: separate kernel as code segment and data segment for linux ppc ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 04 Jan 2001 09:45:55 +0800."
             <017b01c075f0$15265b50$bf0102c8@sc.mcel.mot.com>
Date: Thu, 04 Jan 2001 09:50:23 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <017b01c075f0$15265b50$bf0102c8@sc.mcel.mot.com> you wrote:
>
> As all know, the kernel is resided in flash rom, then upon power-on, kernel
> is copied to RAM.
> I wonder if I can just put data segment to ram and leave code segment to
> FLASH, just as uClinux
> has done. such method will save some ram space, which makes sense on
> embedded solutions.

Does it really make sense? Flash is  more  expensive  than  RAM,  and
sometimes slower (especially if you have just a 8 or 16 bit wide boot
device). For all systems I've seen so far it was more efficient to be
able  to  store  a  compressed  image  in  flash, to reduce the flash
footprint on the expense of some RAM.

This has been discussed several times before on  this  mailing  list;
you might want to search the archives for all the other arguments pro
and contra.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Man is the best computer we can put aboard a spacecraft ...  and  the
only one that can be mass produced with unskilled labor.
                                                  - Wernher von Braun

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
