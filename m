Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 8641567BE7
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 06:40:45 +1000 (EST)
Subject: Re: [PATCH] Add MPC8641 HPCN Device Tree Source file.
From: Jon Loeliger <jdl@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <BFD18279-7617-4F50-BB22-21A46C65FD50@kernel.crashing.org>
References: <1154544503.19994.42.camel@cashmere.sps.mot.com>
	<9C1B15CC-6984-433D-8A1E-F856567B1AD2@kernel.crashing.org>
	<1154549483.19994.46.camel@cashmere.sps.mot.com>
	<BFD18279-7617-4F50-BB22-21A46C65FD50@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1154550970.19994.57.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Wed, 02 Aug 2006 15:36:10 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-08-02 at 15:30, Kumar Gala wrote:

> > Yeah, we have lined up Matt to make a comprehensive
> > update for this.  Can we take my patch as-is?  Matt will
> > follow up with a clean sweep, including fsl_socl.c, to
> > fix it all in one swell foop.
> 
> I think this is one that is clearly something that should be fixed  
> before acceptance.  Since we are talking about a dozen lines of  
> modifications.  Especially since at this point having the .dts in the  
> tree doesn't really effect anything inside the kernel tree.
> 
> - kumar

On the other hand, this matches what the kernel implements
today, and is already in use by several people around the
world.  It _does_ have an affect and is based on things
inside the kernel tree today as it is.

Thanks,
jdl
