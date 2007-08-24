Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2E394DDF44
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 25 Aug 2007 04:38:45 +1000 (EST)
In-Reply-To: <5c9cd53b0708240900y6537e42cn5ee59b2a2a707768@mail.gmail.com>
References: <5c9cd53b0708240900y6537e42cn5ee59b2a2a707768@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <59B03E9A-3FE0-4F11-AEB5-CEAE6AB38F92@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: 8555CDS BSP on 8548CDS board
Date: Fri, 24 Aug 2007 13:38:43 -0500
To: mike zheng <mail4mz@gmail.com>
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


On Aug 24, 2007, at 11:00, mike zheng wrote:

> Hi,
>
> I was told Freescale's 8555CDS board is very similar to 8548CDS  
> board. I just wonder what exactly the differences are. can I just  
> put the 8555CDS BSP onto the 8548CDS board?
>
> Thanks  in advance,


The 8555 u-boot is different from the 8548 u-boot.  There are also  
differences in the device-tree (I'm not sure what version of the  
kernel is in the BSP, so I can't say for sure).  Recent versions of  
the Linux kernel merged all of the CDS systems into one kernel.

As for the differences, off the top of my head:

* 8555 vs 8548 chip
* PCI slot on the carrier card is PCI on 8555, PCIe on 8548.
* 8548 has 4 eTSECs, 8555 has 2 TSECs (and the # of ethernet ports  
reflects this).

Andy
