Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A16FBDE858
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 01:10:55 +1000 (EST)
Message-ID: <47FF7D9B.4060306@freescale.com>
Date: Fri, 11 Apr 2008 10:02:51 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH7/7] [POWERPC] Add i2c pins to dts and board setup
References: <47FF71B1.9070907@scram.de>
In-Reply-To: <47FF71B1.9070907@scram.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: "Kernel, Linux" <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Jean Delvare <khali@linux-fr.org>, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jochen Friedrich wrote:
> diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
> index 7285ca1..7273996 100644
> --- a/arch/powerpc/boot/dts/mpc8272ads.dts
> +++ b/arch/powerpc/boot/dts/mpc8272ads.dts
> @@ -215,6 +215,16 @@
>  				linux,network-index = <1>;
>  				fsl,cpm-command = <16200300>;
>  			};
> +
> +			i2c@11860 {
> +				compatible = "fsl,mpc8248-i2c",

mpc8272-i2c

-Scott
