Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 4B3D667B35
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 01:06:14 +1000 (EST)
In-Reply-To: <1118845450.7564.111.camel@jmcmullan.timesys>
References: <42eb0bacadb197b42502ac1828450843@onz.com>
	<a38c1fefe53947c6b80ec3d6b4ffd09e@freescale.com>
	<c2628642aad8b8107d0e9db84535ea0c@onz.com>
	<1118845450.7564.111.camel@jmcmullan.timesys>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e7e59bf0180e5958169a0f7fc0196098@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 15 Jun 2005 10:06:05 -0500
To: "Jason McMullan" <jason.mcmullan@gmail.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: cpm2_devices.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 15, 2005, at 9:24 AM, Jason McMullan wrote:

> My personal opinions:
>
> 	* Use macro-offsets into a cpm2_map_t struct

Not going to happen.  Sorry.

> 	* Put fcc_c regs back in

Can you explain this.  I'm not 100% sure what regs you are referring to.

> 	* dpram[PROFF_*] should be in the resources list

The patch I posted seems to do that.  I'm guessing these comments may 
be against Allen's initial patch.

> 	* cpm2_* is a better name than MPC82xx_* or MPC85xx_*
> 	* Keep CPM2_DMA, etc, as these *should* be showing up in
> 	  /proc/iomem, since, IIRC, the platform layer does
> 	  reserve them upon registration. (And I *do* have a DMA
> 	  layer then uses CPM2_DMA as a driver-ish thing)

I'll agree on DMA, do you see value in CPM, SI1 and SI2 being here?  
And if so for what?

- kumar
