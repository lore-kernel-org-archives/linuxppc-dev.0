Return-Path: <wd@denx.de>
Received: from mailout02.sul.t-online.com (mailout02.sul.t-online.com
	[194.25.134.17]) by ozlabs.org (Postfix) with ESMTP id 39FD367A70
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Apr 2005 06:55:45 +1000 (EST)
To: Peter Asemann <peter.asemann@web.de>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 29 Apr 2005 17:47:01 +0200."
	<427256F5.8080903@web.de>
Date: Fri, 29 Apr 2005 22:55:24 +0200
Sender: wd@denx.de
Message-Id: <20050429205529.4631BC1510@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: problem compiling linux with ELDK: `bd_t' undeclared 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <427256F5.8080903@web.de> you wrote:
> 
> I'm having a problem compiling Linux 2.4.25 as included in ELDK version 
> 3.1 / Build 2004-11-10.
> 
> When trying to compile ppc_8xx/usr/src/linux-2.4.25/drivers/char/flash.c 
> it throws an error:

You are using an inappropriate configuration of the Linux kernel.

> It looks like it misses ppcboot.h or something. Is there something I 
> need to select in the kernel configuration to get rid of that error?

Not to select, but to unselect: don't try enabling  the  CONFIG_FLASH
option  if (1) you don't know exactly what you're doing *and* (2) you
are really using on of the boards supported by this driver (which  is
obsolete und unsupported, btw.).

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A failure will not appear until a unit has passed final inspection.
