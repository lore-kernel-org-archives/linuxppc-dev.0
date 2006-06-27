Return-Path: <white@from-b.org>
Received: from aphrodite.net-build.de (aphrodite.net-build.de [212.88.135.60])
	by ozlabs.org (Postfix) with ESMTP id 8B51A67A3F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Jun 2006 06:25:46 +1000 (EST)
Received: from White64 (p54B4B863.dip0.t-ipconnect.de [84.180.184.99])
	(authenticated)
	by aphrodite.net-build.de (8.11.6/8.11.2) with ESMTP id k5RJajG22696
	for <linuxppc-embedded@ozlabs.org>; Tue, 27 Jun 2006 21:36:45 +0200
Date: Tue, 27 Jun 2006 21:24:48 +0200
From: White <white@from-b.org>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Lite5200 MTD partitions in 2.6 build
Message-ID: <20060627212448.7d048b7a@White64>
In-Reply-To: <86EC6E02268B3D4BA41C1B0C61FB14E60AFCD219@mdcexc01.na.ops.local>
References: <86EC6E02268B3D4BA41C1B0C61FB14E60AFCD219@mdcexc01.na.ops.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Am Tue, 27 Jun 2006 13:38:25 -0500 schrieb "Rowan, Chad"
<Chad.Rowan@thyssenkrupp.com> :

> In the 2.4 build I had to modify icecube.c in /linux/drivers/mtd/maps/ to
> specify the u-boot, kernel image, and root fs partitions.  Icecube.c doesn't
> exist in the 2.6 drop.  I got the top of the tree from the denx git
> yesterday.  How do you config the partitions for the 2.6 kernel?
> 
>  
> 
> Thanks,
> Chad
> 

Please throw a look to the Platform Devices MTD memory Mapper.
(drivers/mtd/maps/plat-ram.c)

With this Info you can add the Info to the Plattform Device List. f.e.
in the Board Support File. (lite5200.c ?)


Good Luck,
Gabor
