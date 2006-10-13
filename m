Return-Path: <mgalassi@c-cor.com>
Received: from penguin.ncube.com (penguin.ncube.com [134.242.67.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7331367C2B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Oct 2006 08:26:13 +1000 (EST)
Message-Id: <200610132226.k9DMQ0xg050310@penguin.ncube.com>
To: Robert Corley <rcorley@aegis-inc.net>
Subject: Re: uartlite with 2.6.17 kernel and kernel early text messages 
In-reply-to: <20061013204442.52818.qmail@web56308.mail.re3.yahoo.com> 
References: <20061013204442.52818.qmail@web56308.mail.re3.yahoo.com>
Date: Fri, 13 Oct 2006 15:26:00 -0700
From: Michael Galassi <mgalassi@c-cor.com>
Cc: linux linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>In an effort to get past the "Rebooting to System ACE Configuration
>Address 6..." message, I have selected "support for early boot texts
>over serial port" in kernel debugging.

This will not work.  Unfortunately linux here shows its roots as PS OS,
there is a vast amount of hardcoded NS8250/NS16550 knowledge in there.
I'd started modularizing this so we could use a UART lite but the more I
dug the lower my motivation.  This is really ugly code in an area that
is of virtually no interest.  For now get rid of support for early boot
texts over serial port" and use your JTAG to read the buffers if you
panic before the console is up and running.

-michael
