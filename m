Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2A8E7DDEC0
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2007 00:24:26 +1000 (EST)
Date: Fri, 7 Sep 2007 09:24:17 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 06/10] bootwrapper: Move strncmp() from flatdevtree_env.h
	to string.S/string.h.
Message-ID: <20070907142417.GB14768@ld0162-tx32.am.freescale.net>
References: <20070905192001.GA32049@ld0162-tx32.am.freescale.net>
	<20070905192114.GF32113@ld0162-tx32.am.freescale.net>
	<20070907005131.GF26079@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070907005131.GF26079@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 07, 2007 at 10:51:31AM +1000, David Gibson wrote:
> On Wed, Sep 05, 2007 at 02:21:14PM -0500, Scott Wood wrote:
> > It will be needed for PlanetCore firmware support.
> > 
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> 
> I still have a patch that already does this, plus strchr() as well,
> pending...

Sure, and I noted last time that this patch should be dropped if yours is
merged.  I kept it in the patchset because it's needed to make later
patches build and work.

-Scott
