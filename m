Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7259CDE0BE
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 11:36:26 +1100 (EST)
Message-Id: <0A7AE75B-7D27-4396-9708-824F834322D3@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Reynes Philippe <philippe.reynes@isismpp.fr>
In-Reply-To: <761F451C5F17F74DAEE4661DA5ABBC1616C446@factorix.ISISTHIBAUD.local>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] add i2c eeprom to dts for mpc 837x rdb
Date: Tue, 27 Jan 2009 18:35:49 -0600
References: <761F451C5F17F74DAEE4661DA5ABBC160181BE95@factorix.ISISTHIBAUD.local>
	<761F451C5F17F74DAEE4661DA5ABBC16215158@factorix.ISISTHIBAUD.local>
	<761F451C5F17F74DAEE4661DA5ABBC1621515A@factorix.ISISTHIBAUD.local>
	<7FAC732F-383E-4228-9770-3F791EA215FC@freescale.com>
	<761F451C5F17F74DAEE4661DA5ABBC1616C446@factorix.ISISTHIBAUD.local>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

what kernel tree are these against?  I still have issues applying this.

Also, you are using spaces instead of tabs.

- k

On Jan 27, 2009, at 11:55 AM, Reynes Philippe wrote:

> Signed-off-by: Philippe Reynes <philippe.reynes@isismpp.fr>
> ---
> diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts
> b/arch/powerpc/boot/dts/mpc8377_rdb.dts
> index 9413af3..a8276d4 100644
> --- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
> @@ -116,6 +116,12 @@
>                        interrupts = <14 0x8>;
>                        interrupt-parent = <&ipic>;
>                        dfsrr;
> +
> +                       at24@50 {
> +                               compatible = "at24,24c256";
> +                               reg = <0x50>;
> +                       };
> +
>                        rtc@68 {
>                                compatible = "dallas,ds1339";
>                                reg = <0x68>;
> diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts
> b/arch/powerpc/boot/dts/mpc8378_rdb.dts
> index 23c10ce..4ee2639 100644
> --- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
> @@ -116,6 +116,12 @@
>                        interrupts = <14 0x8>;
>                        interrupt-parent = <&ipic>;
>                        dfsrr;
> +
> +                       at24@50 {
> +                               compatible = "at24,24c256";
> +                               reg = <0x50>;
> +                       };
> +
>                        rtc@68 {
>                                compatible = "dallas,ds1339";
>                                reg = <0x68>;
> diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts
> b/arch/powerpc/boot/dts/mpc8379_rdb.dts
> index 72cdc3c..2c06d39 100644
> --- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
> @@ -116,6 +116,12 @@
>                        interrupts = <14 0x8>;
>                        interrupt-parent = <&ipic>;
>                        dfsrr;
> +
> +                       at24@50 {
> +                               compatible = "at24,24c256";
> +                               reg = <0x50>;
> +                       };
> +
>                        rtc@68 {
>                                compatible = "dallas,ds1339";
>                                reg = <0x68>;
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
