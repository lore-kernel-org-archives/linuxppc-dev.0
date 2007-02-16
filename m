Return-Path: <tmorrison@empirix.com>
Received: from empbedex1.empirix.com (empbedex1.empirix.com [12.38.203.54])
	by ozlabs.org (Postfix) with ESMTP id 07094DDDFF
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 09:02:51 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: MPC85xx git branch - problem with Marvel SATA driver...
Date: Fri, 16 Feb 2007 17:02:50 -0500
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D9010685DCFC@EMPBEDEX.empirix.com>
In-Reply-To: <BE415006-0D71-4D2F-8699-3BD2A513D9C0@freescale.com>
References: <BD261180E6D35F4D9D32F3E44FD3D9010685DAA6@EMPBEDEX.empirix.com>
	<BE415006-0D71-4D2F-8699-3BD2A513D9C0@freescale.com>
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

Andy,

CDS is in slot #2, marvel sata card is in Slot #5

I am using the new u-boot git branch from freescale for=20
the MPC85xx_cds. I was told to use this with the new=20
software - which is also using the device tree as well...

Can't tell what version of Arcadia board - where is this located?

All switches on all boards (mother/carrier/cds) are believed
to be in default position as referenced in the cds manual:

    mpc8548_cds_reference.pdf

We haven't done any rocket science here!

Tom


-----Original Message-----
From: Andy Fleming [mailto:afleming@freescale.com]=20
Sent: Friday, February 16, 2007 3:43 PM
To: Morrison, Tom
Cc: linuxppc-dev@ozlabs.org; Geary Sean-R60898; Zhang Wei-r63237
Subject: Re: MPC85xx git branch - problem with Marvel SATA driver...


On Feb 16, 2007, at 14:25, Morrison, Tom wrote:


> It smells that there is some type of interrupt / configuration =20
> mismatch for the PCI bus for the
>
> CDS that is executed upon this probe sequence of a valid SATA/ATA =20
> Port?

Which slot is the CDS carrier card in, and which slot is the SATA =20
card in.  And what interrupt is it trying to register for?

More importantly, what version of u-boot are you running on the =20
board, and what versions of the Carrier Card and Arcadia are you =20
using?  U-Boot rearranges the interrupt-map for PCI based on the slot =20
the CDS Carrier Card is in (which has to be set by a switch on the =20
card).

The code in the tree on opensource.freescale.com only works on the =20
3.1 Arcadia (assuming you also used the DTS that came with it).

Andy
