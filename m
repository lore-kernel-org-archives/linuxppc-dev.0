Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 6A1B067C3B
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 04:27:39 +1000 (EST)
Subject: Re: RFC: Location for Device Tree Sources?
From: Jon Loeliger <jdl@freescale.com>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20060802182143.GP3075@smtp.west.cox.net>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<Pine.LNX.4.60.0608012258040.4041@poirot.grange>
	<1154466094.11069.6.camel@localhost>
	<20060802003504.GA20439@mag.az.mvista.com>
	<1154481150.2676.3.camel@vader.jdub.homelinux.org>
	<528646bc0608012020l11690cf7wbb7d93e6ba6eae90@mail.gmail.com>
	<33AC4A3A-876A-4AF9-B851-928EE80A9D80@kernel.crashing.org>
	<20060802163822.GK3075@smtp.west.cox.net>
	<1154542161.5550.25.camel@localhost>
	<20060802182143.GP3075@smtp.west.cox.net>
Content-Type: text/plain
Message-Id: <1154542988.19994.36.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Wed, 02 Aug 2006 13:23:08 -0500
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-02 at 13:21, Tom Rini wrote:

> Yes, as I said, I'm not totally sure we're at the stable point right
> now, but I think that we are.  I'll add that maybe we need to think
> about API changes and DTS format versions.  To quote from my post..
> 
> > > X bugs) or a change that requires a dts version bump.
> 
> Now it sounds like the IRQ thing was an "Oops, we should have changed
> the dts version" and bailed, noting what is wrong with the dts.

This confuses me.  There hasn't been a change in the DTS
format at all.  I've even updated the 8641HPCN DTS file
across the IRQ updates and all is fine.  Same (DTS) format
both before and after the IRQ changes.

What have I missed here?

And yes, I'm trying to figure out where to _put_ the
8641 DTS file now too... :-)

jdl
