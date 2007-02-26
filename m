Return-Path: <tmorrison@empirix.com>
Received: from empbedex1.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 4DA97DDEC8
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 04:02:52 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Update on: MPC85xx git/MPC8548cds - PCI/PCIE problemS with	Marvel
	SATA driver...
Date: Mon, 26 Feb 2007 12:01:28 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D90106A49495@EMPBEDEX.empirix.com>
In-Reply-To: <45E22753.2020809@freescale.com>
References: <BD261180E6D35F4D9D32F3E44FD3D9010685DAA6@EMPBEDEX.empirix.com>	<BE415006-0D71-4D2F-8699-3BD2A513D9C0@freescale.com>	<BD261180E6D35F4D9D32F3E44FD3D9010685DCFC@EMPBEDEX.empirix.com>	<8B9F6546-0D85-4AD0-A196-25F0F9C1A5A0@freescale.com>	<BD261180E6D35F4D9D32F3E44FD3D901069D9CA4@EMPBEDEX.empirix.com>
	<1172305505.1902.27.camel@localhost.localdomain>
	<45E22753.2020809@freescale.com>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: "Timur Tabi" <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yup, missed that! Thank you=20

-----Original Message-----
From: Timur Tabi [mailto:timur@freescale.com]=20
Sent: Sunday, February 25, 2007 7:18 PM
To: Morrison, Tom
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Update on: MPC85xx git/MPC8548cds - PCI/PCIE problemS with
Marvel SATA driver...

Benjamin Herrenschmidt wrote:

> The above looks like it's working and you don't have a proper
partition
> table on the disk or you haven't compiled in support for the right
type
> of partition map (this is different from the filesystem type)....
>=20
> Make sure you enable MS-DOS partition type support in addition to file
> system type.

Yeah, I made the same mistake once too.

The trick is not to confuse a file system with a partition type.=20
They're completely separate options.  You can select any combination of=20
file systems and partition types, even combinations that can never exist

in the real world.  So if you turn on MS-DOS file system support, you=20
also need to turn on MS-DOS partition support.
