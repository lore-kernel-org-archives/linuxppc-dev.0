Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id D22FADDEE3
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 11:18:37 +1100 (EST)
Message-ID: <45E22753.2020809@freescale.com>
Date: Sun, 25 Feb 2007 18:18:27 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: "Morrison, Tom" <tmorrison@empirix.com>
Subject: Re: Update on: MPC85xx git/MPC8548cds - PCI/PCIE problemS with	Marvel
	SATA driver...
References: <BD261180E6D35F4D9D32F3E44FD3D9010685DAA6@EMPBEDEX.empirix.com>	<BE415006-0D71-4D2F-8699-3BD2A513D9C0@freescale.com>	<BD261180E6D35F4D9D32F3E44FD3D9010685DCFC@EMPBEDEX.empirix.com>	<8B9F6546-0D85-4AD0-A196-25F0F9C1A5A0@freescale.com>	<BD261180E6D35F4D9D32F3E44FD3D901069D9CA4@EMPBEDEX.empirix.com>
	<1172305505.1902.27.camel@localhost.localdomain>
In-Reply-To: <1172305505.1902.27.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

> The above looks like it's working and you don't have a proper partition
> table on the disk or you haven't compiled in support for the right type
> of partition map (this is different from the filesystem type)....
> 
> Make sure you enable MS-DOS partition type support in addition to file
> system type.

Yeah, I made the same mistake once too.

The trick is not to confuse a file system with a partition type. 
They're completely separate options.  You can select any combination of 
file systems and partition types, even combinations that can never exist 
in the real world.  So if you turn on MS-DOS file system support, you 
also need to turn on MS-DOS partition support.
