To: "Rolf Liu" <rolfl@sc.mcel.mot.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: what device and software are needed to download the monitor(ppc-boot) into FLASH for FADS 823 ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 20 Feb 2001 16:43:37 +0800."
             <042d01c09b19$37ea6610$bf0102c8@sc.mcel.mot.com>
Date: Tue, 20 Feb 2001 11:59:15 +0100
Message-Id: <20010220105920.4FA72281D9@denx.denx.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dear Rolf,

in message <042d01c09b19$37ea6610$bf0102c8@sc.mcel.mot.com> wrote:
>
> Currently I have a Wiggler BDM device, and want to know what software can
> support it for downloading ppcboot into FLASH.
> I hope the wiggler will be enough, not to buy new device.

Technically speaking, the Wiggler should do  just  fine.  However,  I
don't  know  what  sort of software comes with it. I think I remember
it's pretty expensive (some 400 $ ?) and for Windoze only.

> Can you recommend some flash program ?

For the Wiggler? Sorry, I have no idea.

The cheapest solution is probably the BDM4GDB parallel port  adapter,
see   bdm4gdb.sourceforge.net   (if  you  cannot  build  the  adapter
yourself, we sell adapters at production cost - less than $ 50 [which
includes a CD-ROM with pre-build GDB]). But  please  be  aware  that,
depending  on the type of flash chips and the interface (8/16/32 bit)
used, there is a certain risk that you may have to modify  the  flash
programming  code a bit to make it work with your board. See also the
mailing list at bdm4gdb-users@lists.sourceforge.net .

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
In C we had to code our own bugs, in C++ we can inherit them.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
