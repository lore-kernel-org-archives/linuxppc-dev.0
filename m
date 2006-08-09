Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 50977679FC
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 02:34:47 +1000 (EST)
Date: Wed, 9 Aug 2006 09:38:39 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Josh Boyer <jwboyer@jdub.homelinux.org>
Subject: Re: RFC: Location for Device Tree Sources?
Message-ID: <20060809163839.GB17759@mag.az.mvista.com>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<1155122309.4040.94.camel@localhost.localdomain>
	<1155128205.3944.1.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1155128205.3944.1.camel@zod.rchland.ibm.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 09, 2006 at 07:56:45AM -0500, Josh Boyer wrote:
> On Wed, 2006-08-09 at 13:18 +0200, Benjamin Herrenschmidt wrote:
> > On Tue, 2006-08-01 at 15:32 -0500, Jon Loeliger wrote:
> > > Folks,
> > > 
> > > Where should we place the sources for the OF Flat Device
> > > Tree source files?  They used to be in U-Boot, but that
> > > isn't happening any more.
> > 
> > Why ? While having device-tree's in zImages is good to handle firmwares
> > that can't pass them, I still think that the proper thing to do is to
> > have the firmware provide the DT to the kernel. Did Denk decide once for
> > all against having DTs passed by uboot at all ? In which case, it's
> > probably time to consider a fork...
> 
> We're only talking about the _source_ files.  The .dts files.  Not the
> binary trees themselves.
> 
> The basic summary is that having a .dts in the kernel for every
> defconfig would be good.  (I think that was the summary anyway.)

That's my understanding too.  A 1-1 matching of default config files
and dts files kept in the kernel src trees.  Any extra dts files would
be kept whereever dtc src is stored (i.e., jdl.com).  I haven't heard
jdl agree to this, though.  :)

Mark
