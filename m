To: byf <byfmail@yeah.net>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Can I use RiscWatch to load ppcboot? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 19 Apr 2001 09:51:18 +0800."
             <20010419015349.90F841CA867CB@smtp.yeah.net>
Date: Thu, 19 Apr 2001 08:37:31 +0200
Message-Id: <20010419063736.B20172792B@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20010419015349.90F841CA867CB@smtp.yeah.net> you wrote:
>
> I am working for walnut 405GP, it has a ROM Monitor and RiscWatch.
> now I want to use PPCBoot to overwrite ROM Monitor,

You better ask such questions on the PPCBoot mailing list!

> Can I use RiscWatch to load PPCBoot to flash or to ram and run it?

I have no idea.

> or can I use a kernel with mtd support to finish this?

You _can_ do it, but I don't recommend it.

> I have no BDI2000.

In this situation  any  minor  error  will  render  your  board  non-
functioning without any other way of recovery but getting cccess to a
BDM/JTAG debugger.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Backed up the system lately?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
