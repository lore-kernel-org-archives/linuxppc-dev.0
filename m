Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 8448667A6C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Apr 2005 04:36:48 +1000 (EST)
In-Reply-To: <F237EFC9919B064C8BF5A44CDA5DA0C212F678@matisse01.matissenetworks.com>
References: <F237EFC9919B064C8BF5A44CDA5DA0C212F678@matisse01.matissenetworks.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <e29792bf3239d4cfb5861e7826300795@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 27 Apr 2005 13:36:42 -0500
To: "Chiradeep Vittal" <chiradeep@matissenetworks.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux Kernel Issue: MPC8540 Errata (CPU29)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Apr 27, 2005, at 12:46 PM, Chiradeep Vittal wrote:

> We're running Linux Kernel 2.4.26 on an 8540 ADS derivative. We're
>  seeing an
> "illegal instruction"=A0 (SIGILL) exception under some circumstances
> (during a pthread_create call). We were wondering if this could be a
> symptom of
> CPU29 and if there is a patch available for CPU29.
>
> "CPU29 L1 instruction cache gets multiple entries for same line after
>  change
> in MSR[IS] bit "
>
> www.freescale.com/files/32bit/doc/errata/MPC8540CE.pdf

The way the Linux kernel manages the MMU on e500 it doesn't actually=20
ever modify MSR[IS] or MSR[DS].  They are always zero so I dont believe=20=

you are hitting this errata.

Are you running with math emulation turned on?  Do you know what the=20
instruction is that causes the SIGILL?

- kumar
