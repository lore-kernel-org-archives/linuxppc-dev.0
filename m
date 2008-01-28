Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 02890DDE10
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 14:39:15 +1100 (EST)
Date: Mon, 28 Jan 2008 10:49:15 -0600
From: Scott Wood <scottwood@freescale.com>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCHv3 2.6.25] i2c: adds support for i2c bus on Freescale
	CPM1/CPM2 controllers
Message-ID: <20080128164915.GA3983@loki.buserror.net>
References: <479A185D.6010406@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <479A185D.6010406@scram.de>
Cc: Jean Delvare <khali@linux-fr.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>, "Kernel,
	Linux" <linux-kernel@vger.kernel.org>, Linux I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jan 25, 2008 at 06:11:57PM +0100, Jochen Friedrich wrote:
> diff --git a/arch/powerpc/boot/dts/mpc866ads.dts b/arch/powerpc/boot/dts/mpc866ads.dts
> index daf9433..80c08bf 100644
> --- a/arch/powerpc/boot/dts/mpc866ads.dts
> +++ b/arch/powerpc/boot/dts/mpc866ads.dts
> @@ -169,6 +169,16 @@
>  				fsl,cpm-command = <0000>;
>  				linux,network-index = <1>;
>  			};
> +
> +			i2c@860 {
> +				compatible = "fsl,mpc866-i2c",
> +					     "fsl,cpm1-i2c",
> +					     "fsl,cpm-i2c";
> +				reg = <860 20 3c80 30>;
> +				interrupts = <10 3>;
> +				interrupt-parent = <&Cpm_pic>;

The label is &CPM_PIC in the current mpc866ads.dts.

-Scott
