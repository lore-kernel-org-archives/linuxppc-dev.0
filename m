To: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: vmlinx and ppcboot 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 13 Jan 2003 10:09:29 PST."
             <3E2300D9.70307@redswitch.com>
Date: Mon, 13 Jan 2003 19:44:54 +0100
Message-Id: <20030113184459.55ED3C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3E2300D9.70307@redswitch.com> you wrote:
>
> After 'make zImage', here comes the error message.

zImage is not the correct build target if you intend to use U-Boot  /
PPCBoot. Try "make pImage" instead.

> misc-embedded.o: In function `decompress_kernel':
> misc-embedded.o(.text+0x28): undefined reference to `embed_config'
> make[2]: *** [zvmlinux] Error 1

This is not appropriate for use with U-Boot / PPCBoot.

> The comments on embed_config.c say that functions in that file are for
> those embedded 8xx boards that do not have boot monitor support for

Right.

> Since I already have ppcboot running, I think I don't need any
> embed_config stuff, or even boot stuff. Right?

Right.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The human mind treats a new idea the way the body  treats  a  strange
protein - it rejects it.                                 - P. Medawar

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
