Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9C5B6DDE1B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 15:28:43 +1000 (EST)
Date: Wed, 19 Sep 2007 00:28:34 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 13/28] 8xx: Infrastructure code cleanup.
Message-ID: <20070919052834.GA5801@ld0162-tx32.am.freescale.net>
References: <20070917165643.GA6545@loki.buserror.net>
	<20070917165742.GM6563@loki.buserror.net>
	<20070919042533.GB30212@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070919042533.GB30212@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 19, 2007 at 02:25:33PM +1000, David Gibson wrote:
> On Mon, Sep 17, 2007 at 11:57:42AM -0500, Scott Wood wrote:
> > 1. Keep a global mpc8xx_immr mapping, rather than constantly
> > creating temporary mappings.
> 
> Nice, but again, it seems a bit pointless to leave in all the
> immr_map() / immr_unmap() pairs now that they do basically nothing.

One step at a time. :-)

Once arch/ppc is gone, I'd like to do some heavier cleanup of the CPM
stuff, including merging with QE.  For now, I want to touch code that's
shared between the architectures as little as possible.

-Scott
