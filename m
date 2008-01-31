Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BB9BEDDE47
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Feb 2008 03:00:55 +1100 (EST)
Date: Thu, 31 Jan 2008 10:00:42 -0600
From: Scott Wood <scottwood@freescale.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC] [POWERPC] bootwrapper: build multiple cuImages
Message-ID: <20080131160042.GA24370@ld0162-tx32.am.freescale.net>
References: <20080131003347.5779.96112.stgit@trillian.secretlab.ca>
	<20080131014952.83827290071@mail95-dub.bigfish.com>
	<fa686aa40801301840k3d9a9ba2n251d2cdb9e659748@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40801301840k3d9a9ba2n251d2cdb9e659748@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 30, 2008 at 07:40:28PM -0700, Grant Likely wrote:
> mpc866ads, mpc885ads and ep88xc are oddities in that they build
> zImages with embedded device tree blobs.  

What about ep8248e?  And the mpc8xxads boards use cuImage, not zImage.

> One option would be to add two new targets: zImage.dtb.% and
> zImage.initrd.dtb.%, but I'm not sure if it is a good idea.

I'd much prefer that over having several lines per board in the makefile.

-Scott
