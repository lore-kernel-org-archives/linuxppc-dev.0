Message-Id: <200008290758.JAA02594@denx.local.net>
To: "Hyun-Joon Cha" <tachyon@postech.ac.kr>
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Serial 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 29 Aug 2000 11:28:36 +0900."
             <051301c01160$d5e0b560$1952df8d@SOYANG>
Date: Tue, 29 Aug 2000 09:58:27 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <051301c01160$d5e0b560$1952df8d@SOYANG> you wrote:
>
> I'm using 8xxrom-0.3.0 for boot loader and MVista-2.2.13 for kernel.

Forget 8xxrom. It's dead.

Use the new PPCBoot instead. See http://ppcboot.sourceforge.net/

> I tried to remove serial driver for some reason.

What are these reasons? Do you have  another  interface  to  interact
with the board instead?

> I have 4 questions abou it.

The following answers are for PPCBoot code.

> 0. If I remove it, will board boot correctly?

Yes, it will. But you will still have a lot of dead code (interactive
commands) which you might remove as well.

> 1. Can I expect some performance gain with removal?

What type of "performance" do you mean?

Linux will not run any faster when you remove the serial driver  from
the boot loader.

If you're talking about boot times, the difference is minimal  -  you
can    get   nearly   the   same   with   PPCBoot   configured   with
CONFIG_BOOTCOMMAND  set  to  the  command  you  need  to   boot   and
CONFIG_BOOTDELAY set to 0 so it will boot immediately.

> 2. Are there any easy way to do it?

Just remove the relevant code.

But to be  honest:  I  see  a  lot  of  disadvantages,  and  no  real
advantages.  But you didn't tell us your reasons, so I cannot comment
on this.

Hope this helps.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A day without sunshine is like night.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
