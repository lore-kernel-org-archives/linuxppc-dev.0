Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id D75BE68AAD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jan 2006 22:42:50 +1100 (EST)
To: "IGOR LURI" <iluri@fagorautomation.es>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Linux kernel and u-boot debugging with Eclipse IDE 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 24 Jan 2006 08:59:46 +0100."
	<918EB199DDDFFA42BEA2EB3A1C6021F399AFAD@correo.fagorautomation.net>
Date: Wed, 25 Jan 2006 12:42:47 +0100
Sender: wd@denx.de
Message-Id: <20060125114247.C9D6E352584@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <918EB199DDDFFA42BEA2EB3A1C6021F399AFAD@correo.fagorautomation.net> you wrote:
> 
> We have a MPC5200Lite board running Linux 2.4.25 and u-boot 1.1.4. We
> are able to debug Linux kernel and U-boot using DDD/GDB and BDI2000, and
> we are trying to use Eclipse IDE (with CDT plugin) / BDI2000 to develop
> and debug software.

Are you sure that U-Boot and Kernel debugging works fine with GDB? So
is this a rev. B CPU then? If not, please read the errata!

> Eclipse works well to remote debugging aplications over ethernet,
> however, we are not able to debug Linux kernel or u-boot using Eclipse.
> When it stops in the first breakpoint, I can´t view some variables and
> stepping into a function, it shows another. It  seems that Eclipse has
> problems with Linux kernel and u-boot symbols.

My guess is that what you see is the effects of  the  chip  errata  -
please read the errata sheet.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Perfection is reached, not when there is no longer anything  to  add,
but when there is no longer anything to take away.
                                           - Antoine de Saint-Exupery
