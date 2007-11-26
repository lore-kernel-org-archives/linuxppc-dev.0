Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A9EAEDDF72
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Nov 2007 03:05:41 +1100 (EST)
Message-ID: <474AE75C.5070405@freescale.com>
Date: Mon, 26 Nov 2007 09:33:48 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: =?windows-1252?Q?=3F=3F?= <guojin02@tsinghua.org.cn>
Subject: Re: The question about the UART on UCC5,UCC6,UCC7,UCC8 for MPC8360?
References: <396048835.09329@tsinghua.org.cn>
In-Reply-To: <396048835.09329@tsinghua.org.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
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

?? wrote:

>   after compiled, I download the linux to MPC8360 board, but I cannot find the
> serial device for UCC5,UCC6,UCC7,UCC8. I just find the ttyS0,ttyS1 is OK.
>   Could you tell me that what's the name for the serial device of UCC5,6,7,8?
>   Whether or not I can use those UART just like the ttyS0,ttyS1?

I don't know why the BSP offers a UART driver for the 8360, because the driver 
isn't available yet.  I'm working on that, though.  I'll post the driver in a 
week or so, and it will be included in 2.6.25.  You'll have to ask the BSP 
support line if they plan on updating the BSP to include the new driver.

-- 
Timur Tabi
Linux kernel developer at Freescale
