Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3F32ADE35A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 Jul 2007 01:46:43 +1000 (EST)
Message-ID: <469B92DC.50609@freescale.com>
Date: Mon, 16 Jul 2007 10:46:36 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: suresh suresh <sureshtang@gmail.com>
Subject: Re: Kmalloc returns which address
References: <e5eb93010707160659m6a7d0b02p623542739d28ab29@mail.gmail.com>
In-Reply-To: <e5eb93010707160659m6a7d0b02p623542739d28ab29@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

suresh suresh wrote:
> I want know the address return by kmalloc function? is it physical address
> or kernel virtual address.

Kernel virtual.

> For Tx and Rx, hardware uses buffers, so I have to allocate buffers and 
> pass
> the pointer to hardware. Can I pass the pointer returned kmalloc?  or  I
> should convert it into physical address?

You need to convert it; read Documentation/DMA-mapping.txt.

-Scott
