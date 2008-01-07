Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1D4DEDDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 04:25:26 +1100 (EST)
Date: Mon, 7 Jan 2008 11:25:03 -0600
From: Scott Wood <scottwood@freescale.com>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH 1/3] Add support for binary includes.
Message-ID: <20080107172503.GA12954@ld0162-tx32.am.freescale.net>
References: <20080104211043.GA28991@ld0162-tx32.am.freescale.net>
	<20080105122043.GG4326@localhost.localdomain>
	<E1JBtq4-0005DJ-7o@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1JBtq4-0005DJ-7o@jdl.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 07, 2008 at 09:24:32AM -0600, Jon Loeliger wrote:
> So, like, the other day David Gibson mumbled:
> > 
> > 
> > Hrm.  Can we leave this one until after 1.1?   Since it adds new
> > syntax, I think it would be worth cogitating a bit longer.
> 
> Double hrm.
> 
> Scott, can you remind us why this feature was requested
> off the U-Boot list, please?  I'm trying to decide if we
> really do want to get it into the 1.1 release.

U-boot wants it because they're planning on using device trees as their
new multi-image format.

I implemented it for a similar, but different reason -- passing guest
device trees to a hypervisor within a hypervisor config tree.

-Scott
