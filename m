Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 3264567A71
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 08:09:51 +1100 (EST)
In-Reply-To: <1110915063.5937.93.camel@ad.doubleclick.net>
References: <1110907039.24673.12.camel@rhino.az.mvista.com>
	<1110915063.5937.93.camel@ad.doubleclick.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <583185c11becaca3ce73e4010c18154d@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 15 Mar 2005 15:09:39 -0600
To: "McMullan, Jason" <jason.mcmullan@timesys.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: 440EP FPU patch
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jason,

A few comments:

1. Change config option to CONFIG_PPC_FPU
2. split out altivec support into a separate file, most likely just 
move it into vector.S
3. Get ride of the C++ comments

- kumar

On Mar 15, 2005, at 1:27 PM, McMullan, Jason wrote:

> _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> Date: March 15, 2005 1:43:37 PM CST
> Subject:
>
>
>
> Date: March 15, 2005 1:43:37 PM CST
> Subject:
>
>
> <ATT110571.txt><cpu-ppc-fpu.patch>
>
> <signature.asc>
>
