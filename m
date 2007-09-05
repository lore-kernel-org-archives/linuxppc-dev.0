Return-Path: <rwoodworth@securics.com>
Received: from securics.com (dns2.securics.com [128.198.58.14])
	by ozlabs.org (Postfix) with ESMTP id 533E7DEE46
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Sep 2007 05:30:41 +1000 (EST)
Subject: RE: Xilinx FX60
From: Robert Woodworth <rwoodworth@securics.com>
To: "Wood, Robert (GE Indust, GE Fanuc)" <robert.wood@gefanuc.com>
In-Reply-To: <0F3B2CB6574F1A488E62523706BF8A770226B07D@LOUMLVEM03.e2k.ad.ge.com>
References: <1189017748.6185.49.camel@PisteOff>
	<0F3B2CB6574F1A488E62523706BF8A770226B07D@LOUMLVEM03.e2k.ad.ge.com>
Content-Type: text/plain
Date: Wed, 05 Sep 2007 13:30:39 -0600
Message-Id: <1189020639.6185.51.camel@PisteOff>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2007-09-05 at 14:56 -0400, Wood, Robert (GE Indust, GE Fanuc)
wrote:
> We've been using Virtex 2 PRO with dual cores. We found it necessary to
> very tightly constrain clocks and resets. Also, constrain the reset
> block to adjacent to the ports on the PPC.

What constraints did you tighten?? EDK or ISE?


> Another lightly documented feature is that the core clock must be an
> integer multiple of the PLB clock, say 300MHz/100MHz.
> 
> Robert Wood
> GEFanuc Sensor Processing
> 5430 Canotek Road
> Ottawa, Ontario
> Canada K1J 9G2
> 613-749-9241 x270
>  
> 
> -----Original Message-----
> From: linuxppc-embedded-bounces+rwood=ics-ltd.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+rwood=ics-ltd.com@ozlabs.org] On
> Behalf Of Robert Woodworth
> Sent: Wednesday, September 05, 2007 2:42 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: Xilinx FX60
> 
> After achieving complete success with my Linux kernel on the ML403, I've
> now started to build a kernel for my real target board with a
> Virtex4-FX60 (dual PPC cores)
> 
> Has anyone built a kernel for a dual core PPC Virtex?  I have found very
> little docs on how to architect software for the dual-core PPC's.  
> Will SMP Linux work on this platform?  What would the bus setup be?
> 
> 
> 
> My kernel is partially booting, some of the time... I'm mystified by the
> situation.  One time, I get all the happy boot messages through the
> UARTLite port, then the next reboot it stops at "Now booting the kernel"
> I'm only getting about 10% successful boots......
> 
> 
> My EDK setup is as follows;  I've disconnected the second PPC from the
> PLB to have a single PPC system, 32MB DDR on PLB, TEMAC on PLB, UARTLite
> on OPB.
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
