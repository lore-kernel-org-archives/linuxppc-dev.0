To: leeyang <leeyang@ycig.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux booting 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 24 Aug 2002 08:07:28 +0800."
             <002301c24b03$038024f0$fc4bb73d@leeyang>
Date: Sun, 25 Aug 2002 20:35:12 +0200
Message-Id: <20020825183517.4C07711822@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

in message <002301c24b03$038024f0$fc4bb73d@leeyang> you wrote:
>
> > > I have a BDI2000,but I think I should debug the bootm
> > > part of ppcboot,however someone says it is quite
> > > difficult to do so( at least for me).
> >
> > Well, it's not _that_ difficult. Try it out, so you get used to is ;-)
>
> I wish it is not that hard,however I can not debug the kernel or
> ppcboot according the  brief introduction in BDI manual.:(

There are some more hints at
http://www.denx.de/doc/TQM8xxL/debugging.html

> I want to watch r3,r4,r5,r6,r7 register when ppcboot transferring
> to kernel.Could you tell me how to get that? thanks a lot!

Start PPCBoot, setup bootargs etc., load  the  kernel  image.  Before
finally typing the "bootm" command set a (hardware) breakpoint at the
kernel entry point (= physical address 0x0000).

When hitting the breakpoint, print the registers...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You don't have to worry about me. I might have been born yesterday...
but I stayed up all night.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
