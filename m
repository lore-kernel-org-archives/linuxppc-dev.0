Return-Path: <jangiels@speakeasy.net>
Received: from mail5.sea5.speakeasy.net (mail5.sea5.speakeasy.net
	[69.17.117.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.speakeasy.net", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1AFEC679F0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Mar 2006 08:24:39 +1100 (EST)
Subject: Re: Linux kernel reboot issue
From: Jeff Angielski <jangiels@speakeasy.net>
To: jimmy liu <jimmyzhmliu@yahoo.com>
In-Reply-To: <20060317153550.19366.qmail@web53111.mail.yahoo.com>
References: <20060317153550.19366.qmail@web53111.mail.yahoo.com>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 16:19:16 -0500
Message-Id: <1142630356.8934.42.camel@sumo-jaa.nrl.navy.mil>
Mime-Version: 1.0
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

On Fri, 2006-03-17 at 07:35 -0800, jimmy liu wrote:
> Our custom board is similar as EST8260. We use Linux
> Kernel 2.4.25 from ftp://ftp.denx.de/pub/linux/. When
> we type the reboot command or shutdown -r, we got the
> following error messages. Does anybody has idea? 

Check your m8260_setup.c file for m8260_restart() and make sure the code
matches your flash configuration.  Specifically, the startaddr.

Other than that, did you look in your system map to check the PC against
the exception to find our which piece of code is causing this?

HTH,
Jeff Angielski
The PTR Group

> 
> The system is going down NOW !!
> Sending SIGTERM to all processeTerminated
> Sending SIGKILL to all processes.
> Please stand by while rebooting the system.
> Restarting systemsteOops: Exception in kernel mode,
> sig: 4
> NIP: FFF00100 XER: 00000000 LR: FFF00100 SP: C0EDDDF0
> REGS: c0eddd40 TRAP: 0700    Not tainted
> MSR: 00081002 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
> TASK = c0edc000[34] 'init' Last syscall: 2
> last math 00000000 last altivec 00000000
> GPR00: 00001032 C0EDDDF0 C0EDC000 001EDA88 FFF00100
> 00001002 000037D0 00000000
> GPR08: C0374060 C000C024 0000C000 00100088 0000000D
> 10064B24 00000000 00000000
> GPR16: 00000000 00000000 00000000 00000000 00009032
> 00EDDF40 00000000 C0003EA8
> GPR24: C0003C00 100034DC 7FFFFF38 00000001 7FFFFF24
> 00000000 FFF00100 00000000
> Call backtrace:
> 00000000
> 
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
