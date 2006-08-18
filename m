Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 6603A67B6F
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 03:38:46 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k7IHcjDm011526
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 10:38:45 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7IHciAS003594
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 12:38:44 -0500 (CDT)
Subject: Re: [PATCH] Directly reference i8259@4d0 nodes in mpc8641_hpcn.dts.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
In-Reply-To: <1155849609.10054.175.camel@cashmere.sps.mot.com>
References: <1155835482.10054.140.camel@cashmere.sps.mot.com>
	<1155840700.27466.64.camel@basalt.austin.ibm.com>
	<1155849609.10054.175.camel@cashmere.sps.mot.com>
Content-Type: text/plain
Message-Id: <1155922375.10054.201.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Fri, 18 Aug 2006 12:32:56 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-08-17 at 16:20, Jon Loeliger wrote:
> Rather than using some hand-coded linux,phandle
> node references, use DTC's direct node refs ability
> and let it manage the phandle names instead.
> 
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> ---
> 
> On Thu, 2006-08-17 at 13:51, Hollis Blanchard wrote:
> > Doesn't the device tree compiler add linux,phandle properties as needed?
> > In this case that would be when the node is referenced by a
> > "<&/foo/bar/i8259@4d0>" property.
> > 
> > On Thu, 2006-08-17 at 12:24 -0500, Jon Loeliger wrote:
> > > Add 'linux,phandle' entry to i8259@4d0 node.
> > > 
> > > Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> > > Signed-off-by: Jon Loeliger <jdl@freescale.com>
> > > ---
> 
> Paul,
> 
> If you think this is better, please apply this patch
> instead of my previous patch with the subject line:
> 
>     Patch] Fix the mpc8641_hpcn.dts file.
> 
> Thanks,
> jdl

Paul,

I'll take the application of the original patch,

	Fix the mpc8641_hpcn.dts file.

as an indication that this, alternate version should
now be simply dropped!

Thanks,
jdl
