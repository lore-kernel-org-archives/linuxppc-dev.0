Return-Path: <afleming@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id B8675DDD0D
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 07:43:25 +1100 (EST)
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D9010685DAA6@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D9010685DAA6@EMPBEDEX.empirix.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BE415006-0D71-4D2F-8699-3BD2A513D9C0@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: MPC85xx git branch - problem with Marvel SATA driver...
Date: Fri, 16 Feb 2007 14:43:16 -0600
To: "Morrison, Tom" <tmorrison@empirix.com>
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


On Feb 16, 2007, at 14:25, Morrison, Tom wrote:


> It smells that there is some type of interrupt / configuration  
> mismatch for the PCI bus for the
>
> CDS that is executed upon this probe sequence of a valid SATA/ATA  
> Port?

Which slot is the CDS carrier card in, and which slot is the SATA  
card in.  And what interrupt is it trying to register for?

More importantly, what version of u-boot are you running on the  
board, and what versions of the Carrier Card and Arcadia are you  
using?  U-Boot rearranges the interrupt-map for PCI based on the slot  
the CDS Carrier Card is in (which has to be set by a switch on the  
card).

The code in the tree on opensource.freescale.com only works on the  
3.1 Arcadia (assuming you also used the DTS that came with it).

Andy
