Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 39A46DDDF6
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Dec 2007 02:53:23 +1100 (EST)
Date: Sun, 16 Dec 2007 09:48:34 -0600
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] mpc82xx: Embedded Planet EP8248E support
Message-ID: <20071216154833.GA29045@ld0162-tx32.am.freescale.net>
References: <20071211212247.GB3620@loki.buserror.net>
	<20071216063020.GG21311@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071216063020.GG21311@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 16, 2007 at 05:30:20PM +1100, David Gibson wrote:
> This mdio-under-bcsr arrangement is a bit strange.  Can you explain
> what's going on here?

It's pretty much what it looks like; MDIO is connected to a couple pins
that are controlled by some bits in the BCSR.

-Scott
