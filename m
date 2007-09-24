Return-Path: <dgibson@ozlabs.org>
Date: Mon, 24 Sep 2007 14:00:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] qemu platform, v2
Message-ID: <20070924040047.GK8058@localhost.localdomain>
References: <boot-8-00.miltonm@bga.com> <qemu-8-01.miltonm@bga.com>
	<20070922095546.GA14185@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070922095546.GA14185@lst.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Rob Landley <rob@landley.net>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Sep 22, 2007 at 11:55:46AM +0200, Christoph Hellwig wrote:
> On Fri, Sep 21, 2007 at 06:08:31PM -0500, Milton Miller wrote:
> > Here is the second rev of patches to boot a arch powerpc kernel on
> > qemu with the prep architecture.
> 
> So if this is supposed to be prep why do you need additional kernel
> support?  And if you really needed why isn't it under
> platforms/prep?

Basically because PReP support doesn't work under arch/powerpc.
Getting it working properly is something that should happen, but will
take a while.  In the meantime, getting something that's sufficient to
get working under just qemu's version of prep, without using the
abominable openhackware is a quicker path to a usable arch/powerpc
kernel under qemu.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
