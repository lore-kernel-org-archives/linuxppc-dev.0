Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C8740DDE08
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 06:06:16 +1100 (EST)
Date: Tue, 20 Nov 2007 11:54:16 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Emulate isel (Integer Select) instruction
Message-ID: <20071120175416.GA4389@loki.buserror.net>
References: <Pine.LNX.4.64.0711192135460.24923@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0711192135460.24923@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 19, 2007 at 09:36:57PM -0600, Kumar Gala wrote:
> isel (Integer Select) is a new user space instruction in the
> PowerISA 2.04 spec.  Not all processors implement it so lets emulate
> to ensure code built with isel will run everywhere.

Given that the instruction is meant to be a performance enhancement,
we should probably warn the first few times it's emulated, so the user
knows they should change their toolchain setup if possible.

-Scott
