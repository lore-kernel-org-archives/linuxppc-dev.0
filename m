Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1A780DDE00
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Feb 2008 05:06:21 +1100 (EST)
Date: Mon, 25 Feb 2008 10:58:13 -0600
From: Scott Wood <scottwood@freescale.com>
To: Philippe De Muyter <phdm@macqel.be>
Subject: Re: E500 linux : are the 64-bit GPRs context-switched ?
Message-ID: <20080225165813.GH7958@ld0162-tx32.am.freescale.net>
References: <20080221123534.GA17716@ingate.macqel>
	<20080222095022.GA635@ingate.macqel>
	<20080225144722.GA5011@ingate.macqel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080225144722.GA5011@ingate.macqel>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Feb 25, 2008 at 03:47:22PM +0100, Philippe De Muyter wrote:
> Searching around, I learned that the E500 GPR registers are 64-bits wide,
> and gcc targetted for powerpc-linuxspe uses them sometimes.  In the other
> PPC32 targets, those registers are 32-bits wide.
> 
> The specific E500 64-bit move instructions are `evstdd' and `evldd'.
> I searched in the linux kernel sources (2.6.24) but did not find where
> those GPR registers could be saved in 64-bit mode for context-switch.

giveup_spe and load_up_spe.

-Scott
