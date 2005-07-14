Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id F39BF67C69
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 23:25:40 +1000 (EST)
In-Reply-To: <5a4792c0050713235574522cfb@mail.gmail.com>
References: <5a4792c0050713235574522cfb@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <E65A8A95-7352-40A3-9A86-EF437F0132D0@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 14 Jul 2005 08:25:43 -0500
To: "SIP COP 009" <sipcop009@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 8272ADS and Linux 2.6.12
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

You may need to check the bootargs to insure that console=ttyCPM0

- kumar

On Jul 14, 2005, at 1:55 AM, SIP COP 009 wrote:

> Hello,
>
> We have a MPC8272 Eval Board which came with Linux 2.4 and U-boot. We
> wanted to move to 2.6. I downloaded the latest 2.6.12 sources and
> compiled the sources for this platform. The kernel is built, have run
> the mkimage tool, but the kernel wont boot.  It just hangs after
> decompressing the image.
>
> Any ideas  ? Anything different that needs to be done for 2.6 ? Or any
> known issues ?
>
> Thanks!
> ashutosh
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
