Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 932C4DDF09
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Jun 2007 05:33:07 +1000 (EST)
In-Reply-To: <OF7929EEAE.73E06DAF-ON48257306.0036AB63-48257306.0039FAD3@coship.com>
References: <OF7929EEAE.73E06DAF-ON48257306.0036AB63-48257306.0039FAD3@coship.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6AEDE2FF-D54A-46A2-AACC-EFEA59861D1D@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: booting linux-2.6.15 hang on custom mpc8555 board
Date: Wed, 27 Jun 2007 14:32:52 -0500
To: huangyun@coship.com
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


On Jun 26, 2007, at 05:33, huangyun@coship.com wrote:

>
> hi,everyone
>    I have porting linux2.6.15 of eldk4.0 to my mpc8555 board, my  
> bootloader
> is u-boot1.1.6, the uboot running is ok,but it hang at booting  
> kernel.no
> any print message.
> I have check the CCSRBAR(0xe0000000) and bd_t struct is the  same  
> as linux
> kernel,  my serial port use uart1. somebody help me! i'm a linux  
> kernel
> newer.

What's your boot command line?

Andy
