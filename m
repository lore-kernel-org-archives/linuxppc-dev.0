Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8DAD6DE476
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 06:46:24 +1100 (EST)
Date: Fri, 28 Mar 2008 14:46:12 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3] mpc83xx: fix usb phy_type in mpc837x rdb device trees
Message-Id: <20080328144612.36ae5b14.kim.phillips@freescale.com>
In-Reply-To: <163986FE-1FE0-4FAB-AACA-6E2605CF4094@kernel.crashing.org>
References: <20080328105125.6a072ff7.kim.phillips@freescale.com>
	<20080328164441.GA7146@localhost.localdomain>
	<163986FE-1FE0-4FAB-AACA-6E2605CF4094@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 28 Mar 2008 14:37:51 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Mar 28, 2008, at 11:44 AM, Anton Vorontsov wrote:
> > On Fri, Mar 28, 2008 at 10:51:25AM -0500, Kim Phillips wrote:
> >> the mpc837x rdb board uses low pin count interfaces (ULPI) to connect
> >> to the USB PHY.
> >
> > I've sent this fix two weeks ago...
> >
> > http://ozlabs.org/pipermail/linuxppc-dev/2008-March/052926.html
> >
> >> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> 
> I'll apply Anton's version and add a signed-off-by Kim.

agreed, thanks!

Kim
