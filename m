Return-Path: <hollis@penguinppc.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by ozlabs.org (Postfix) with ESMTP id 9C98867A58
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 06:31:41 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add FSL SEC node to documentation
From: Hollis Blanchard <hollis@penguinppc.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1DBAE58F-2152-4074-B9BA-ADB1FA63DD1B@kernel.crashing.org>
References: <20060320195945.004fdf26.kim.phillips@freescale.com>
	<200603202014.44879.hollis@penguinppc.org>
	<1DBAE58F-2152-4074-B9BA-ADB1FA63DD1B@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 13:28:55 -0600
Message-Id: <1142969335.395.6.camel@basalt>
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

On Tue, 2006-03-21 at 12:25 -0600, Kumar Gala wrote:
> On Mar 20, 2006, at 8:14 PM, Hollis Blanchard wrote:
> 
> > On Monday 20 March 2006 19:59, Kim Phillips wrote:
> >> diff --git a/Documentation/powerpc/booting-without-of.txt
> > b/Documentation/powerpc/booting-without-of.txt
> >> index d02c649..72f3241 100644
> >> --- a/Documentation/powerpc/booting-without-of.txt
> >> +++ b/Documentation/powerpc/booting-without-of.txt
> >> @@ -1365,6 +1365,79 @@ platforms are moved over to use the flat
> >>       };
> >>
> >>
> >> +   g) Freescale SOC SEC Security Engines
> >> +
> >> +   Required properties:
> >> +
> >> +    - device_type : Should be "crypto"
> >> +    - model : Model of the device.  Should be "SEC1" or "SEC2"
> >> +    - compatible : Should be "talitos"
> > [snip]
> >
> > Have you consulted with any other vendors regarding these  
> > properties? I know
> > there is no IEEE1275 binding for these sorts of devices, but we can  
> > at least
> > attempt to standardize it (even in the absence of the Open Firmware  
> > Working
> > Group)...
> 
> Beyond the device_type, I'm not sure if there is much more one could  
> standardize one.  The other fields that Kim spec'd are either generic  
> OF fields (reg, interrupts, etc.) or specific to the Freescale devices.

The device_type and compatible properties are exactly what I'm talking
about.

-Hollis
