Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 32607DDD09
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 03:32:58 +1000 (EST)
Date: Wed, 12 Sep 2007 12:32:50 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v4] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Message-ID: <20070912173249.GA16828@ld0162-tx32.am.freescale.net>
References: <Pine.LNX.4.64.0709121119160.19430@blarg.am.freescale.net>
	<20070912163638.GA16326@ld0162-tx32.am.freescale.net>
	<AE69C5D1-3910-40F0-80E5-283FDB5199F5@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AE69C5D1-3910-40F0-80E5-283FDB5199F5@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 12, 2007 at 12:04:20PM -0500, Kumar Gala wrote:
> I'm leaving them for now to match the others, we can clean them all  
> up at the same time.

OK.

> Technically built-in is spec'd by the CHRP spec for ISA/PCI.

I looked in the CHRP I/O Device Reference and didn't see it, though I may
have been looking at the wrong document.

> As for clock-frequency, not sure where that came from.

I'm guessing copy-and-paste from mpic.

-Scott
