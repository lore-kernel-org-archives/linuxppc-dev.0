Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D24C667B5A
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Aug 2006 23:05:25 +1000 (EST)
In-Reply-To: <20060809122904.GE3918@igloo.df.lth.se>
References: <20060808135020.GG26606@igloo.df.lth.se>
	<5C1C19D6-8FC8-46AF-9C4B-B9989B1A997B@kernel.crashing.org>
	<20060809122904.GE3918@igloo.df.lth.se>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0100B07F-70D3-4A35-8D1B-3452B2157027@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: PowerPC Local Bus
Date: Wed, 9 Aug 2006 08:05:16 -0500
To: Fredrik Roubert <roubert@df.lth.se>
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


On Aug 9, 2006, at 7:29 AM, Fredrik Roubert wrote:

> On Tue 08 Aug 17:03 CEST 2006, Kumar Gala wrote:
>
>> The reason you haven't seen any code is due to several reasons.  One,
>> FPGA/localbus implementations can be very specific and thus reuse is
>> difficult.  Two, some of this code tends to end up it boot loaders to
>> setup the UPM (take a look at U-boot for possible UPM config code).
>
> OK, so you do all the setup in the boot loader and then the driver  
> just
> needs to ioremap() the FPGA? That sounds reasonable and explains why I
> haven't found any kernel source code relating to this ...
>
> I just didn't expect the kernel to rely on the boot loader to  
> configure
> this. Is that the recommended way to to it?

I don't think there is any recommendation one way or the other.  Its  
just that the boards that are currently supported in the kernel doing  
have FGPAs needing UPM config and thus there isn't any code one way  
or the other.

- kumar
