Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id C7F3767B17
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Apr 2005 00:42:10 +1000 (EST)
In-Reply-To: <1114609634.30649.14.camel@ad.doubleclick.net>
References: <1114609634.30649.14.camel@ad.doubleclick.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <609724aa0424d00c851e3d085ce6d56f@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 27 Apr 2005 09:42:04 -0500
To: "Jason McMullan" <jason.mcmullan@timesys.com>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC8xx Platformization
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

Two comments:
1. put mpc8xx_devices.c & mpc8xx_sys.c in arch/ppc/syslib (I moved the 
85xx ones here and its where 83xx & 52xx are)
2. can we just use hard coded offsets for start & end values.  I really 
hate assuming that the global immap_t structure is always correct.  I'm 
assuming on 8xx these values really aren't changing, take a look at 
mpc83xx_devices.c

thanks

- kumar

On Apr 27, 2005, at 8:47 AM, Jason McMullan wrote:

> _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> Date: April 27, 2005 8:48:03 AM CDT
> Subject:
>
>
>
> Date: April 27, 2005 8:48:03 AM CDT
> Subject:
>
>
> <ATT520952.txt><mpc8xx-platformize.patch>
>
> <signature.asc>
>
