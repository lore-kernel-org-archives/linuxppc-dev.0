Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id CC60867CAF
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 04:38:59 +1000 (EST)
Date: Wed, 2 Aug 2006 11:42:43 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Matthew McClintock <msm@freescale.com>
Subject: Re: RFC: Location for Device Tree Sources?
Message-ID: <20060802184243.GM17652@mag.az.mvista.com>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<Pine.LNX.4.60.0608012258040.4041@poirot.grange>
	<1154466094.11069.6.camel@localhost>
	<20060802003504.GA20439@mag.az.mvista.com>
	<1154481150.2676.3.camel@vader.jdub.homelinux.org>
	<20060802182226.GH17652@mag.az.mvista.com>
	<1154542975.5550.29.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1154542975.5550.29.camel@localhost>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 02, 2006 at 01:22:55PM -0500, Matthew McClintock wrote:
> On Wed, 2006-08-02 at 11:22 -0700, Mark A. Greer wrote:
> > Well, if you're going to keep prebuilt dtb files there, why wouldn't
> > you
> > want the dts that makes that dtb to be in the same place?
> > 
> 
> One option is the *just* include the working tested DTB files in the
> kernel source. That way there is a method to boot the boards. If you end
> user wants to work with a different DTB they can go download the DTS
> from another source (or optionally derive the DTS from the DTB) and make
> changes.

It probably would be handier to have the dtb there but its a source
tree, so let's keep source there.

It'll just be a fact of life for a non-devtree fw platform user that
they need to find and use dtc and an attach tool to stick the dtb
onto the zImage.

> That way we do not have to include 'dtc' in the kernel, and we still

I don't think anyone was actually serious about including dtc in the kernel.

> have a valid DTB for every board included in the kernel. Also, there is
> no reason to include both the DTB and DTS in the kernel considering they
> can be easily derived from one another using 'dtc'

Mark
