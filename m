Return-Path: <pnasrat@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [66.187.233.31])
	by ozlabs.org (Postfix) with ESMTP id D444C679FD
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 08:23:46 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add FSL SEC node to documentation
From: Paul Nasrat <pnasrat@redhat.com>
To: Hollis Blanchard <hollis@penguinppc.org>
In-Reply-To: <1142969335.395.6.camel@basalt>
References: <20060320195945.004fdf26.kim.phillips@freescale.com>
	<200603202014.44879.hollis@penguinppc.org>
	<1DBAE58F-2152-4074-B9BA-ADB1FA63DD1B@kernel.crashing.org>
	<1142969335.395.6.camel@basalt>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 16:23:41 -0500
Message-Id: <1142976221.2751.22.camel@enki.eridu>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-03-21 at 13:28 -0600, Hollis Blanchard wrote:
> On Tue, 2006-03-21 at 12:25 -0600, Kumar Gala wrote:
> > On Mar 20, 2006, at 8:14 PM, Hollis Blanchard wrote:

> > > Have you consulted with any other vendors regarding these  
> > > properties? I know
> > > there is no IEEE1275 binding for these sorts of devices, but we can  
> > > at least
> > > attempt to standardize it (even in the absence of the Open Firmware  
> > > Working
> > > Group)...
> > 
> > Beyond the device_type, I'm not sure if there is much more one could  
> > standardize one.  The other fields that Kim spec'd are either generic  
> > OF fields (reg, interrupts, etc.) or specific to the Freescale devices.
> 
> The device_type and compatible properties are exactly what I'm talking
> about.

The Working Group lists still exist but are pretty dead.  I agree we
really want to ensure that both OF based and dtc based new hardware is
consistent.  I'm not sure how we want to do this, but we can document in
Documentation and then use eg SLOF to mock out the OF interfaces and
create proposals and kick some life into the OF working group.  



Paul
