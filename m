Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5C850474C1
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 05:23:57 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m9LINjTo003895
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 11:23:51 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m9LINikM006201
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 13:23:45 -0500 (CDT)
Date: Tue, 21 Oct 2008 13:23:44 -0500
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/2] powerpc/83xx: add DS1339 RTC support for
	MPC8349E-mITX boards
Message-ID: <20081021182344.GA22232@ld0162-tx32.am.freescale.net>
References: <20081017185659.GA30008@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081017185659.GA30008@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 17, 2008 at 10:56:59PM +0400, Anton Vorontsov wrote:
> diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
> index 5cedf37..7fc5414 100644
> --- a/arch/powerpc/boot/dts/mpc8349emitx.dts
> +++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
> @@ -83,6 +83,14 @@
>  			interrupts = <15 0x8>;
>  			interrupt-parent = <&ipic>;
>  			dfsrr;
> +
> +			rtc@68 {
> +				device_type = "rtc";
> +				compatible = "dallas,ds1339";
> +				reg = <0x68>;
> +				interrupts = <18 0x8>;
> +				interrupt-parent = <&ipic>;
> +			};

Why are we adding more device_types?

-Scott
