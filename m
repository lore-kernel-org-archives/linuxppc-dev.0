Return-Path: <Farrukh_Arshad@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "relay1.mentorg.com",
 Issuer "Entrust Certification Authority - L1B" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5989AB6FAF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2012 17:49:51 +1100 (EST)
From: "Arshad, Farrukh" <Farrukh_Arshad@mentor.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: Problem in getting shared memory access on P1022RDK
Date: Wed, 4 Jan 2012 06:49:45 +0000
Message-ID: <93CD5F41FDBC6042A6B449764F3B35CC050CCB2E@EU-MBX-03.mgc.mentorg.com>
References: <93CD5F41FDBC6042A6B449764F3B35CC050CCA22@EU-MBX-03.mgc.mentorg.com>
 <93CD5F41FDBC6042A6B449764F3B35CC050CCA80@EU-MBX-03.mgc.mentorg.com>
 <4F033685.6000509@freescale.com>
In-Reply-To: <4F033685.6000509@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

How can I verify if the memory mapped is coherent on both cores. My memory =
partitioning is given below

Core		Base Address		Size
Core 0		0x0000,0000		0x1000,0000	--> CONFIG_PHYSICAL_START =3D bootm_low =
=3D Base Address
Core 1		0x1000,0000		0x0C00,0000	--> CONFIG_PHYSICAL_START =3D bootm_low =
=3D Base Address
Shared Mem	0x1C00,0000		0x0400,0000

Regards,
Farrukh Arshad

-----Original Message-----
From: Scott Wood [mailto:scottwood@freescale.com]=20
Sent: Tuesday, January 03, 2012 10:10 PM
To: Arshad, Farrukh
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: Problem in getting shared memory access on P1022RDK

On 01/03/2012 03:42 AM, Arshad, Farrukh wrote:
> Adding more to it,
>=20
> =20
>=20
> When I write from Core 1 on the shared memory region it is visible at=20
> Core 0 and it can read what I have written from Core 1 but when I=20
> write from Core 0 on this shared memory it is not visible on Core 1.

Is the memory mapped coherent on both cores?

-Scott
