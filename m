Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 60235DDE29
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Mar 2007 02:38:49 +1100 (EST)
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D90106A8CAEC@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D9010685DAA6@EMPBEDEX.empirix.com>	<BE415006-0D71-4D2F-8699-3BD2A513D9C0@freescale.com>	<BD261180E6D35F4D9D32F3E44FD3D9010685DCFC@EMPBEDEX.empirix.com>	<8B9F6546-0D85-4AD0-A196-25F0F9C1A5A0@freescale.com>	<BD261180E6D35F4D9D32F3E44FD3D901069D9CA4@EMPBEDEX.empirix.com>
	<1172305505.1902.27.camel@localhost.localdomain>
	<45E22753.2020809@freescale.com>
	<BD261180E6D35F4D9D32F3E44FD3D90106A8CAEC@EMPBEDEX.empirix.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <114EA8BE-428F-4602-A6B1-63C9EF0CB722@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: Another Update (SUCCESS) on: MPC85xx git/MPC8548cds - PCI/PCIE
	problemS w/ Marvel SATA driver...
Date: Wed, 28 Feb 2007 09:38:38 -0600
To: "Morrison, Tom" <tmorrison@empirix.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 27, 2007, at 10:45, Morrison, Tom wrote:

> As indicated before, I got the SATA drive fully
> accessed via the PCI interface (that uses the Marvell
> 6042 chip).
>
> With some help from Freescale and based upon the CDS/Carrier/
> Motherboard combination that I have (2.2/1.2/3.0), I was
> required to merge the PCI Express piece of the Standard
> DTS file into the legacy version. Further, I modified
> the standard sata_mv.c to recognize the Marvell 7042 chip
> as a valid/supportable id.
>
> The question now is:  What do I do with these changes?
>
> I am assuming that someone from Freescale will update the
> DTS changes, but what about the change to sata_mv.c?


Actually, if you could send a patch for this, I'd appreciate it.  I'm  
not completely clear on which changes you made, here.

I want to make sure we get them all.

Andy
