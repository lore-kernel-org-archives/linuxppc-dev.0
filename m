Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C2571DDE31
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 12:30:46 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l281UhFV015283
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 20:30:43 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l281UhRU486358
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 18:30:43 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l281UgMW024634
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 18:30:43 -0700
Date: Wed, 7 Mar 2007 19:35:44 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 11/15] zImage wrapper for Ebony
Message-ID: <20070308013544.GC27833@crusty.rchland.ibm.com>
References: <20070305032307.GB31417@localhost.localdomain>
	<20070305032452.EDB2BDDF1D@ozlabs.org>
	<20070305171053.GC32672@mag.az.mvista.com>
	<20070306000905.GC4728@localhost.localdomain>
	<20070307194732.GB30721@ld0162-tx32.am.freescale.net>
	<20070308002400.GB3950@localhost.localdomain>
	<20070308005443.GA21039@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070308005443.GA21039@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 07, 2007 at 05:54:43PM -0700, Mark A. Greer wrote:
> > > 
> > > I can see potential benefit in allowing multiple dtbs to be included, to
> > > be chosen at runtime (such as from a board ID passed from the bootloader,
> > > or based on detection of how the board is configured (such as detecting
> > > whether an MDS board is plugged into a PCI backplane, or is acting as a
> > > PCI agent, or is standalone)).  But why all of them?
> > 
> > Simplicity, and a better chance to pick up syntax errors at least for
> > obscure platforms.  Note that they'd be going as separate modules into
> > a .a, so only the relevant ones would be included in the final zImage.
> 
> This seems like overkill to me.  I believe Paul's intention was that
> you could run the wrapper script any time (e.g., well after you built
> the zImage).  I don't really see the benefit of building them all and
> now you have to worry about stale .S' in the .a file when it so easy to
> just run the wrapper script with whatever .dts file you want.

I don't care either way, but it would be nice to decide on a direction
soon so people can start working on patches again.  Right now we have
David's 3 patches, Scott's 18 or so, and I'm looking at adding a few
for new platform support.

josh
