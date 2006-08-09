Return-Path: <roubert@df.lth.se>
Received: from df.lth.se (mail.df.lth.se [194.47.250.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B9BE67B9C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Aug 2006 22:29:25 +1000 (EST)
Date: Wed, 9 Aug 2006 14:29:04 +0200
From: Fredrik Roubert <roubert@df.lth.se>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PowerPC Local Bus
Message-ID: <20060809122904.GE3918@igloo.df.lth.se>
References: <20060808135020.GG26606@igloo.df.lth.se>
	<5C1C19D6-8FC8-46AF-9C4B-B9989B1A997B@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5C1C19D6-8FC8-46AF-9C4B-B9989B1A997B@kernel.crashing.org>
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

On Tue 08 Aug 17:03 CEST 2006, Kumar Gala wrote:

> The reason you haven't seen any code is due to several reasons.  One,
> FPGA/localbus implementations can be very specific and thus reuse is
> difficult.  Two, some of this code tends to end up it boot loaders to
> setup the UPM (take a look at U-boot for possible UPM config code).

OK, so you do all the setup in the boot loader and then the driver just
needs to ioremap() the FPGA? That sounds reasonable and explains why I
haven't found any kernel source code relating to this ...

I just didn't expect the kernel to rely on the boot loader to configure
this. Is that the recommended way to to it?

Cheers // Fredrik Roubert

-- 
Visserij 192  |  +32 473 344527 / +46 708 776974
BE-9000 Gent  |  http://www.df.lth.se/~roubert/
