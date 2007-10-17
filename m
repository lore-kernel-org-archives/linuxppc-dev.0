Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CBB1ADDE9C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 04:54:49 +1000 (EST)
Message-ID: <47165A7E.1070206@scram.de>
Date: Wed, 17 Oct 2007 20:54:54 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: mpc 860 boot linux2.6.23 problem
References: <20071015233839.959F4247BB@gemini.denx.de>	<4714E44F.7030909@freescale.com>	<85100356-D95B-4343-98BE-66080EA9887D@embeddedalley.com>
	<47162AE7.80305@freescale.com>
In-Reply-To: <47162AE7.80305@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi Scott,

> I just pulled Wolfgang's latest u-boot tree, and I don't see any fdt or 
> ft_ calls in cpu/mpc8xx, nor in any 8xx board that I recognize.
>
> I may have been unclear in that I was talking about device tree support 
> in u-boot, not the kernel.  Obviously there's device tree support in the 
> kernel, as evidenced by my reference to using cuImage.
>   

Can u-boot work on dtb trees embedded in an cuImage, at all?
How would command line arguments work without a chosen
node?

I tried to boot a mpc823 using the 3 argument mboot command.
u-boot processed the dtb and added the chosen node correctly,
however the kernel immediately oopsed with unable to access
virtual memory when accessing the dtb memory as this memory
was not contained in the kernel MMU space.

Thanks,
Jochen
