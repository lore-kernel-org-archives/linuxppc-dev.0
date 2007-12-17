Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 206A0DDE1E
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 04:10:23 +1100 (EST)
Date: Mon, 17 Dec 2007 11:10:04 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [POWERPC][RFC] MPC8360E-RDK: Device tree and board file
Message-Id: <20071217111004.506f3563.kim.phillips@freescale.com>
In-Reply-To: <20071217170303.GA4303@loki.buserror.net>
References: <20071210202934.GA32046@localhost.localdomain>
	<10D5CABD-442B-44DF-83D7-7FED5CD150E3@kernel.crashing.org>
	<20071215162331.GA24999@localhost.localdomain>
	<20071217051403.GB3477@localhost.localdomain>
	<20071217170303.GA4303@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 17 Dec 2007 11:03:04 -0600
Scott Wood <scottwood@freescale.com> wrote:

> On Mon, Dec 17, 2007 at 04:14:03PM +1100, David Gibson wrote:
> > > +		crypto@30000 {
> > > +			device_type = "crypto";
> > > +			model = "SEC2";
> > > +			compatible = "talitos";
> > 
> > This device_type/compatible/model stuff is also crap, although I
> > suspect it needs to be fixed in the driver, as gianfar (finally) was.
> 
> The driver doesn't seem to be in-tree... Kim, what do(es) the external
> driver(s) look like?  Do they use OF at all yet?

yes, it uses OF ifdef CONFIG_PPC_MERGE.

Kim
