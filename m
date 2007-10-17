Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F1E69DE177
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 01:32:09 +1000 (EST)
Message-ID: <47162AE7.80305@freescale.com>
Date: Wed, 17 Oct 2007 10:31:51 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddedalley.com>
Subject: Re: mpc 860 boot linux2.6.23 problem
References: <20071015233839.959F4247BB@gemini.denx.de>
	<4714E44F.7030909@freescale.com>
	<85100356-D95B-4343-98BE-66080EA9887D@embeddedalley.com>
In-Reply-To: <85100356-D95B-4343-98BE-66080EA9887D@embeddedalley.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:
> 
> On Oct 16, 2007, at 12:18 PM, Scott Wood wrote:
> 
>> Upgrading to the latest u-boot certainly shouldn't hurt, but I don't
>> think there's any device tree support for 8xx yet,
> 
> Have you tried it?  Works for me.  In fact, most
> of the development you see today was done
> by Pantelis on the 8xx.

I just pulled Wolfgang's latest u-boot tree, and I don't see any fdt or 
ft_ calls in cpu/mpc8xx, nor in any 8xx board that I recognize.

I may have been unclear in that I was talking about device tree support 
in u-boot, not the kernel.  Obviously there's device tree support in the 
kernel, as evidenced by my reference to using cuImage.

-Scott
