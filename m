Return-Path: <Rick.Moleres@xilinx.com>
Received: from outbound1-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 1971ADDF14
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Apr 2008 08:16:07 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Ethernet Jumbo Frames
Date: Wed, 2 Apr 2008 15:15:51 -0600
In-Reply-To: <D61182AC8012EA4EBC531B3AF23BE109582F00@tranzeo-mail2.12stewart.tranzeo.com>
References: <D61182AC8012EA4EBC531B3AF23BE109582F00@tranzeo-mail2.12stewart.tranzeo.com>
From: "Rick Moleres" <Rick.Moleres@xilinx.com>
To: "Darcy Watkins" <DWatkins@tranzeo.com>,
	"LinuxPPC-Embedded" <linuxppc-embedded@ozlabs.org>
Message-Id: <20080402211552.729E82B007F@mail93-dub.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Sure, it can be done.  The Xilinx 10/100 Ethernet drivers have jumbo
frame support in MontaVista/WindRiver Linux.  As long as both ends are
talking jumbo frames, works just fine.

-Rick

-----Original Message-----
From: linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+moleres=3Dxilinx.com@ozlabs.org] On
Behalf Of Darcy Watkins
Sent: Monday, March 31, 2008 2:48 PM
To: LinuxPPC-Embedded
Subject: Ethernet Jumbo Frames

Has anyone on this list ever been given a requirement to implement
support for ethernet frames larger than the standard MTU of 1500?  ...

... for normal 10/100 Ethernet?   ... not gigabit.

The application is to support certain encapsulation protocols without
imposing smaller than 1500 byte MTU restrictions on the innermost
protocol.

I have been tasked to investigate this for a system based on PPC405EP.
Can it be done using the IBM EMAC, Linux drivers, etc?

Regards,

Darcy

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
