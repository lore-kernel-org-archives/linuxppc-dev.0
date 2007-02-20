Return-Path: <tmorrison@empirix.com>
Received: from empbedex1.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 9433FDDDF7
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 07:59:07 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MPC85xx git branch - problem with Marvel SATA driver...
Date: Tue, 20 Feb 2007 15:58:57 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D901068DC5D8@EMPBEDEX.empirix.com>
In-Reply-To: <8B9F6546-0D85-4AD0-A196-25F0F9C1A5A0@freescale.com>
References: <BD261180E6D35F4D9D32F3E44FD3D9010685DAA6@EMPBEDEX.empirix.com>
	<BE415006-0D71-4D2F-8699-3BD2A513D9C0@freescale.com>
	<BD261180E6D35F4D9D32F3E44FD3D9010685DCFC@EMPBEDEX.empirix.com>
	<8B9F6546-0D85-4AD0-A196-25F0F9C1A5A0@freescale.com>
From: "Morrison, Tom" <tmorrison@empirix.com>
To: "Andy Fleming" <afleming@freescale.com>
Cc: Geary Sean-R60898 <sean.geary@freescale.com>, linuxppc-dev@ozlabs.org,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Will try this out and let you know!

t

-----Original Message-----
From: Andy Fleming [mailto:afleming@freescale.com]=20
Sent: Tuesday, February 20, 2007 2:41 PM
To: Morrison, Tom
Cc: linuxppc-dev@ozlabs.org; Geary Sean-R60898; Zhang Wei-r63237
Subject: Re: MPC85xx git branch - problem with Marvel SATA driver...


On Feb 16, 2007, at 16:02, Morrison, Tom wrote:

> Andy,
>
> CDS is in slot #2, marvel sata card is in Slot #5
>
> I am using the new u-boot git branch from freescale for
> the MPC85xx_cds. I was told to use this with the new
> software - which is also using the device tree as well...
>
> Can't tell what version of Arcadia board - where is this located?


Sorry for the delay.  I wasn't quite sure how to find that =20
information.  However, back channels have indicated you may be using =20
a 3.0 Arcadia.  In that case, you need to use the dts in arch/powerpc/=20
boot/dts/mpc8548cds_legacy.dts.  It's not a very useful name (sorry), =20
but that's what it's called internally right now.  The interrupt maps =20
for 3.0 and 3.1 PCI are different, and that would explain your =20
problem, I hope.


Andy
