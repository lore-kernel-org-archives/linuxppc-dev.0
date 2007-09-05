Return-Path: <robert.wood@gefanuc.com>
Received: from ext-nj2ut-12.online-age.net (ext-nj2ut-12.online-age.net
	[64.14.54.245])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 27076DDEA2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Sep 2007 05:03:47 +1000 (EST)
Received: from int-nj2ut-1.online-age.net (int-nj2ut-1.online-age.net
	[3.159.237.70])
	by ext-nj2ut-12.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id l85IuMNe015366
	for <linuxppc-embedded@ozlabs.org>; Wed, 5 Sep 2007 14:56:22 -0400
Received: from cinmlef10.e2k.ad.ge.com (int-nj2ut-1.online-age.net
	[3.159.237.70])
	by int-nj2ut-1.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id l85IuLQ6009730
	for <linuxppc-embedded@ozlabs.org>; Wed, 5 Sep 2007 14:56:22 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Xilinx FX60
Date: Wed, 5 Sep 2007 14:56:21 -0400
Message-ID: <0F3B2CB6574F1A488E62523706BF8A770226B07D@LOUMLVEM03.e2k.ad.ge.com>
In-Reply-To: <1189017748.6185.49.camel@PisteOff>
References: <1189017748.6185.49.camel@PisteOff>
From: "Wood, Robert (GE Indust, GE Fanuc)" <robert.wood@gefanuc.com>
To: "Robert Woodworth" <rwoodworth@securics.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We've been using Virtex 2 PRO with dual cores. We found it necessary to
very tightly constrain clocks and resets. Also, constrain the reset
block to adjacent to the ports on the PPC.

Another lightly documented feature is that the core clock must be an
integer multiple of the PLB clock, say 300MHz/100MHz.

Robert Wood
GEFanuc Sensor Processing
5430 Canotek Road
Ottawa, Ontario
Canada K1J 9G2
613-749-9241 x270
=20

-----Original Message-----
From: linuxppc-embedded-bounces+rwood=3Dics-ltd.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+rwood=3Dics-ltd.com@ozlabs.org] On
Behalf Of Robert Woodworth
Sent: Wednesday, September 05, 2007 2:42 PM
To: linuxppc-embedded@ozlabs.org
Subject: Xilinx FX60

After achieving complete success with my Linux kernel on the ML403, I've
now started to build a kernel for my real target board with a
Virtex4-FX60 (dual PPC cores)

Has anyone built a kernel for a dual core PPC Virtex?  I have found very
little docs on how to architect software for the dual-core PPC's. =20
Will SMP Linux work on this platform?  What would the bus setup be?



My kernel is partially booting, some of the time... I'm mystified by the
situation.  One time, I get all the happy boot messages through the
UARTLite port, then the next reboot it stops at "Now booting the kernel"
I'm only getting about 10% successful boots......


My EDK setup is as follows;  I've disconnected the second PPC from the
PLB to have a single PPC system, 32MB DDR on PLB, TEMAC on PLB, UARTLite
on OPB.

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
