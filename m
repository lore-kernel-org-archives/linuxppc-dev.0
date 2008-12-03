Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AEC6BDDE0A
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Dec 2008 04:45:43 +1100 (EST)
Message-ID: <4936C547.6060409@freescale.com>
Date: Wed, 03 Dec 2008 11:43:35 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Joe Shmo <spamreceptor@yahoo.com>
Subject: Re: Help with DTS file on MPC8313e-rdb board
References: <193995.57491.qm@web30107.mail.mud.yahoo.com>
In-Reply-To: <193995.57491.qm@web30107.mail.mud.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Joe Shmo wrote:
> What I don't know is what reg = <4> means.  Is that
> the phy address or the interrupt? 

It's the PHY address.

> My phy is the National semi dp83848.  It does not use
> an IRQ.  Should I replace this with zero?  Should I
> take that line out of the DTS file?

You should remove the interrupts and interrupt-parent properties.

-Scott
