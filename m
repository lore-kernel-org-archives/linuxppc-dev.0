Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao07.cox.net (fed1rmmtao07.cox.net [68.230.241.32])
	by ozlabs.org (Postfix) with ESMTP id D3EC4679E1
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 10:35:06 +1000 (EST)
Date: Wed, 2 Aug 2006 17:35:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: RFC: Location for Device Tree Sources?
Message-ID: <20060803003504.GY3075@smtp.west.cox.net>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<1154481150.2676.3.camel@vader.jdub.homelinux.org>
	<20060802182226.GH17652@mag.az.mvista.com>
	<200608021341.52084.bcook@bpointsys.com>
	<20060802185153.GO17652@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060802185153.GO17652@mag.az.mvista.com>
Cc: linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 02, 2006 at 11:51:53AM -0700, Mark A. Greer wrote:
> On Wed, Aug 02, 2006 at 01:41:51PM -0500, Brent Cook wrote:
> > On Wednesday 02 August 2006 13:22, Mark A. Greer wrote:
> > >
> > > Well, if you're going to keep prebuilt dtb files there, why wouldn't you
> > > want the dts that makes that dtb to be in the same place?
> > >
> > > Mark
> > 
> > There is precedence for this. Look at drivers/net/ixp2000/, it includes both 
> > the microengine source code, and the precompiled binary blob files (in case 
> > you do not have the required assembler.)
> 
> Interesting, but in our case everyone does have the compiler
> (or at least with little effort they do).

There are a few other cases of this, with the intention that if you're
mucking with these files you can regenerate.  But we're just talking
about the blob in this part of the thread..

-- 
Tom Rini
