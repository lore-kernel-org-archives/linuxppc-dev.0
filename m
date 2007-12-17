Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A03FFDDE2D
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Dec 2007 04:42:38 +1100 (EST)
Date: Mon, 17 Dec 2007 11:42:18 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] [POWERPC][RFC] MPC8360E-RDK: Device tree and board file
Message-Id: <20071217114218.a7562362.kim.phillips@freescale.com>
In-Reply-To: <4766AFEE.1040701@freescale.com>
References: <20071210202934.GA32046@localhost.localdomain>
	<10D5CABD-442B-44DF-83D7-7FED5CD150E3@kernel.crashing.org>
	<20071215162331.GA24999@localhost.localdomain>
	<20071217051403.GB3477@localhost.localdomain>
	<20071217170303.GA4303@loki.buserror.net>
	<20071217111004.506f3563.kim.phillips@freescale.com>
	<4766AFEE.1040701@freescale.com>
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

On Mon, 17 Dec 2007 11:20:46 -0600
Scott Wood <scottwood@freescale.com> wrote:

> Kim Phillips wrote:
> > On Mon, 17 Dec 2007 11:03:04 -0600
> > Scott Wood <scottwood@freescale.com> wrote:
> >> The driver doesn't seem to be in-tree... Kim, what do(es) the external
> >> driver(s) look like?  Do they use OF at all yet?
> > 
> > yes, it uses OF ifdef CONFIG_PPC_MERGE.
> 
> Can we change it to look for something like a compatible of 
> "fsl,sec2-crypto", with a fallback match on talitos for old device trees?

yep, that looks good, I'll update the driver according to these changes.

Kim
