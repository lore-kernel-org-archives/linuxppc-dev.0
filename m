Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 70266DDF58
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 02:12:19 +1100 (EST)
Date: Tue, 18 Mar 2008 10:11:32 -0500
From: Scott Wood <scottwood@freescale.com>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2] 8xx: Add support for the MPC852 based board from
	keymile.
Message-ID: <20080318151132.GA17402@ld0162-tx32.am.freescale.net>
References: <47DA444E.9050507@denx.de>
	<20080315102508.bc698a90.sfr@canb.auug.org.au>
	<47DF6B82.4030404@denx.de>
	<20080318183320.49c98183.sfr@canb.auug.org.au>
	<47DF777E.2030103@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47DF777E.2030103@denx.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 18, 2008 at 09:04:14AM +0100, Heiko Schocher wrote:
> OK. Another thought about this. Shouldnt this table go in the dts?
> A device node like
> 
> cpm_pin {
> 	pins = <port pin flags>;
> };
> 
> would be nice, or?

Well, the device tree is a mechanism for communicating from the firmware
to the kernel, and if we could control the firmware better we'd just make
it set the pins properly to begin with. :-)

-Scott
