Return-Path: <sven@powerlinux.fr>
Received: from archon.plz.fr (archon.plz.fr [194.50.78.210])
	by ozlabs.org (Postfix) with ESMTP id 62BAADE313
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 04:18:51 +1100 (EST)
Date: Wed, 9 Jan 2008 18:18:49 +0100
From: Sven Luther <sven@genesi-usa.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [RFC] add phy-handle property for fec_mpc52xx
Message-ID: <20080109171849.GC6789@powerlinux.fr>
References: <20080109163058.21643.30876.stgit@trillian.secretlab.ca>
	<4784FCB1.3010509@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4784FCB1.3010509@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, olaf@aepfle.de, sven@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 09, 2008 at 04:56:17PM +0000, Matt Sealey wrote:
> Okay I have a better suggestion.
> 
> Apply all the prom_init fixes you like. But, instead of swizzling on the
> individual nodes, do it blanket for the firmware version.
> 
> For instance, wrap the entire efika fixups stuff with a check for the
> openprom property "built-on" - this is the date the firmware was built.
> efika.forth will change this!

This is crazy, and not future proof. The way Grant did it, checking for
the existence of the node before creating is enough for any reasonable
upgrade to the firmware.

If future firmware will break with this, then they will break other
stuff anyway, and a new patch is needed.

> Just make sure it's less than.. let's say, a certain version of efika.forth,
> and I will roll a version which has a higher version and some extra features
> like CAN/I2C exposure.
> 
> If you run efika.forth it will not touch the device tree. If you don't, it
> will add the small amount of patches. Add a huge comment that this hunk of
> code should be scheduled for deletion at some later date. Put a Kconfig
> around it so it can be taken out, even, at distro option.

Have you not read Grant's code ? It create the nodes only if they are
not existent already.

Friendly,

Sven Luther
