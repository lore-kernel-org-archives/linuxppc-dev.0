Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id DDD4B679EA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Mar 2006 07:10:05 +1100 (EST)
To: =?iso-8859-1?B?Qmr2cm4g1nN0Ynk=?= <Bjorn.Ostby@combitech.se>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: 8xx SMC1 problem 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 16 Mar 2006 18:23:46 +0100."
	<004B1D7A5257174C9044A1B7BD0E60ED0178CC68@ratatosk.combitechsystems.com>
Date: Thu, 16 Mar 2006 21:10:03 +0100
Sender: wd@denx.de
Message-Id: <20060316201003.9522F353B16@atlas.denx.de>
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

In message <004B1D7A5257174C9044A1B7BD0E60ED0178CC68@ratatosk.combitechsystems.com> you wrote:
>
> First of, I have three serial ports (SMC1, SMC2 and SCC3) and they all work
>  fine when the console is on SMC1. I have gadgets connected to SMC2 and SCC
> 3 and now I need SMC1 for yet another device. So I have undefined CONFIG_SE
> RIAL_CONSOLE in the kernel config and I jump out of u-boot (which have the
> console on SMC1) with the argument "console=none".

And did you make sure that no other process is accessing ttyS0 ?

> When logging in (via telnet) ttyS0 works no more (but S1 and S2 does). At r
> andom bootups, it is possible to open the port but it is no good for read o
> r write.
> 
> Can anybody give me some advise on how to enable SMC1 but at the same time
> don't have a console on it?

We did the same (passing console=null) in a couple of  configurations
and  had  no  problems  using SMC1 as standard serial port. Try *not*
undefining CONFIG_SERIAL_CONSOLE.

And please keep your line length < 72 characters or so.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A committee is a life form with six or more legs and no brain.
                              -- Lazarus Long, "Time Enough For Love"
