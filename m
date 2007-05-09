Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 188A6DDEC6
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 04:26:45 +1000 (EST)
Date: Wed, 9 May 2007 13:26:30 -0500
From: Scott Wood <scottwood@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 05/13] Document the fsl,
	magic-packet property in gianfar nodes.
Message-ID: <20070509182630.GA19495@ld0162-tx32.am.freescale.net>
References: <20070507182947.GD26920@ld0162-tx32.am.freescale.net>
	<B7081C3F-C551-42D8-BB5D-6FE5DC311C99@freescale.com>
	<463F9A38.6080408@freescale.com>
	<AC7B08C0-E41A-458F-8E9F-59901443600A@freescale.com>
	<3FE06AFA-BEE6-46CF-B12C-29D979AE50D7@kernel.crashing.org>
	<20070508001808.GD7449@localhost.localdomain>
	<baf8c79aa13de543816d62162d4f9928@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <baf8c79aa13de543816d62162d4f9928@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 09, 2007 at 04:33:12PM +0200, Segher Boessenkool wrote:
> >>>> As I previously wrote internally, it's only needed because some
> >>>> versions of the device have it and some don't; what it really means
> >>>> is that certain bits in certain registers are valid.
> 
> So have the driver detect this based on "compatible"
> or "model".

Thus requiring the driver to maintain a list of models/compatibles for
every possible combination of features, rather than letting the device
tree specify them individually.  What would be the advantage in that?

-Scott
