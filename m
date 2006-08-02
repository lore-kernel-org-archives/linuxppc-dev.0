Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id C51C567C04
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 04:48:09 +1000 (EST)
Date: Wed, 2 Aug 2006 11:51:53 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Brent Cook <bcook@bpointsys.com>
Subject: Re: RFC: Location for Device Tree Sources?
Message-ID: <20060802185153.GO17652@mag.az.mvista.com>
References: <1154464346.19994.4.camel@cashmere.sps.mot.com>
	<1154481150.2676.3.camel@vader.jdub.homelinux.org>
	<20060802182226.GH17652@mag.az.mvista.com>
	<200608021341.52084.bcook@bpointsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200608021341.52084.bcook@bpointsys.com>
Cc: linuxppc-dev@ozlabs.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 02, 2006 at 01:41:51PM -0500, Brent Cook wrote:
> On Wednesday 02 August 2006 13:22, Mark A. Greer wrote:
> >
> > Well, if you're going to keep prebuilt dtb files there, why wouldn't you
> > want the dts that makes that dtb to be in the same place?
> >
> > Mark
> 
> There is precedence for this. Look at drivers/net/ixp2000/, it includes both 
> the microengine source code, and the precompiled binary blob files (in case 
> you do not have the required assembler.)

Interesting, but in our case everyone does have the compiler
(or at least with little effort they do).

Mark
