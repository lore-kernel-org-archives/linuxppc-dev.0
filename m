Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 13273DDEE7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 05:00:36 +1000 (EST)
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8EA1809A@aquib01a>
References: <F1F6EC0C8B75034F9E3A79FC85122E8EA1809A@aquib01a>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B999A34D-92BD-41D1-852A-45C4E2258712@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: Only one phy can be accessed through ioctls to a socket (patch
	available)
Date: Wed, 22 Aug 2007 14:00:22 -0500
To: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
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


On Aug 22, 2007, at 03:56, DI BACCO ANTONIO - technolabs wrote:

> In file fs_enet-main.c in function fs_ioctl the phy_mii_ioctl can be
> issued only to the phydev associated with the FEC. If I have several
> PHYs and only one associated to the FEC I cannot access all the   
> PHYs. I
> have a patch to overcome this limitation, is it interesting or not
> useful?
>
> I need this patch because I have instantiated a virtual "Fixed PHY"  
> and
> I have associated it to my FEC,  anyway I would like to access  
> registers
> of my physical PHY.


I'd certainly be interested in seeing it.

Andy
