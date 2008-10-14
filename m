Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 78766DE04E
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 03:16:58 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m9EGAYcJ003267
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 09:16:53 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m9EFRxC9001882
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 10:27:59 -0500 (CDT)
Date: Tue, 14 Oct 2008 10:27:58 -0500
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: MPC8321,
	ethernet and i2c problems after upgrade from 2.6.25 to 2.6.27
Message-ID: <20081014152758.GC12934@ld0162-tx32.am.freescale.net>
References: <1223899315.32141.42.camel@gentoo-jocke.transmode.se>
	<20081013163151.GD19080@ld0162-tx32.am.freescale.net>
	<1223918059.32141.62.camel@gentoo-jocke.transmode.se>
	<48F393EB.6000100@freescale.com> <48F39B97.6030602@freescale.com>
	<1223970931.32141.80.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1223970931.32141.80.camel@gentoo-jocke.transmode.se>
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 14, 2008 at 09:55:31AM +0200, Joakim Tjernlund wrote:
> On Mon, 2008-10-13 at 14:03 -0500, Scott Wood wrote:
> > Joakim Tjernlund wrote:
> > > Because all the kernel comments I can see still implies that this should work
> > 
> > Which kernel comments?
> 
> The one already mentioned and in i2c-boardinfo.c

I already addressed the one already mentioned (it was sloppy terminology
in the comment, written from the perspective of devtree-less arches). 
The latter is even less clear, as it doesn't mention dynamic buses at
all.

Feel free to submit a documentation patch clearing it up. :-)

> > > and because this was the only way in earlier releases to add an i2c device.
> > 
> > We've supported enumerating i2c-mpc devices using the device tree for 
> > almost as long as there's been new-style i2c devices.
> 
> Don't know how long that has been but looking at the mpc832x_mds dts
> file it has been there less than a year.

commit d13ae8620dfdedfa7e9ab6d1eec294adc0516065 added i2c device probing
from the device tree in 7/21/07, less than 3 months after new-style i2c
devices were added to the i2c core.  There were patches floating around
the lists for longer than that.

> > Why not?  U-boot allows you to pass in a device tree dynamically.
> 
> I don't use a dynamic device tree, mine is built in.

So do a fixup in your board code.

I'm not sure how you would even go about building a device tree into
U-boot currently, though.

-Scott
