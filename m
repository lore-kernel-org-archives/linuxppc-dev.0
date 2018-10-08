Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E2CC00449
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 07:03:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04BEB20645
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 07:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJA04GC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BEB20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TBC82JbHzF3Dy
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 18:03:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sJA04GC+";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=shawnguo@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="sJA04GC+"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42T8dj46n8zF39X
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 16:52:25 +1100 (AEDT)
Received: from dragon (unknown [45.56.155.247])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C85302085B;
 Mon,  8 Oct 2018 05:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1538977943;
 bh=v1ZfrDQruHnH6RL7RayS9eX9tDT9/ZoJFD4wLUvUrlY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sJA04GC+K6jhrHzsvSx4HOK7CUbZQH89igFvhGxblAbYitGbmWwq27fLyIvMFF+ms
 Hxyd0TTJb/jkcIPRI69Ok9XnBOdhdZJdjsxHtpDBN0Irf4RFV/NmZFApIWq4BdXzqR
 aYua7tMo/mgE2I/cMhKip7c7pzv+YHNNdYvGd2jo=
Date: Mon, 8 Oct 2018 13:52:01 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: Re: [PATCH v4 6/6] arm64: dts: add LX2160ARDB board support
Message-ID: <20181008055159.GH3587@dragon>
References: <1538615031-7507-1-git-send-email-vabhav.sharma@nxp.com>
 <1538615031-7507-7-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538615031-7507-7-git-send-email-vabhav.sharma@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: mark.rutland@arm.com, kstewart@linuxfoundation.org,
 linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com,
 mturquette@baylibre.com, will.deacon@arm.com, yamada.masahiro@socionext.com,
 Sriram Dash <sriram.dash@nxp.com>, linux-clk@vger.kernel.org,
 pankaj.bansal@nxp.com, udit.kumar@nxp.com, linux@armlinux.org.uk,
 Priyanka Jain <priyanka.jain@nxp.com>, viresh.kumar@linaro.org,
 devicetree@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org,
 oss@buserror.net, robh+dt@kernel.org, V.Sethi@nxp.com,
 linux-arm-kernel@lists.infradead.org, sboyd@kernel.org,
 gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 leoyang.li@nxp.com, sudeep.holla@arm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 04, 2018 at 06:33:51AM +0530, Vabhav Sharma wrote:
> LX2160A reference design board (RDB) is a high-performance
> computing, evaluation, and development platform with LX2160A
> SoC.
> 
> Signed-off-by: Priyanka Jain <priyanka.jain@nxp.com>
> Signed-off-by: Sriram Dash <sriram.dash@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile            |   1 +
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 100 ++++++++++++++++++++++
>  2 files changed, 101 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 86e18ad..445b72b 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -13,3 +13,4 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2080a-simu.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2088a-rdb.dtb
> +dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> new file mode 100644
> index 0000000..1483071
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +//
> +// Device Tree file for LX2160ARDB
> +//
> +// Copyright 2018 NXP
> +
> +/dts-v1/;
> +
> +#include "fsl-lx2160a.dtsi"
> +
> +/ {
> +	model = "NXP Layerscape LX2160ARDB";
> +	compatible = "fsl,lx2160a-rdb", "fsl,lx2160a";
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	sb_3v3: regulator-fixed {

The node name should probably be named like regulator-sb3v3 or
something, so that the pattern can be followed when we have another
fixed regulator to be added.

> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-3.3V";

The name should be something we can find on board schematics.

> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	status = "okay";
> +};
> +
> +&i2c0 {

Please keep these labeled nodes sorted alphabetically.

> +	status = "okay";

Have a newline between properties and child node.

> +	i2c-mux@77 {
> +		compatible = "nxp,pca9547";
> +		reg = <0x77>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c@2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x2>;
> +
> +			power-monitor@40 {
> +				compatible = "ti,ina220";
> +				reg = <0x40>;
> +				shunt-resistor = <1000>;
> +			};
> +		};
> +
> +		i2c@3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x3>;
> +
> +			temperature-sensor@4c {
> +				compatible = "nxp,sa56004";
> +				reg = <0x4c>;
> +				vcc-supply = <&sb_3v3>;
> +			};
> +
> +			temperature-sensor@4d {
> +				compatible = "nxp,sa56004";
> +				reg = <0x4d>;
> +				vcc-supply = <&sb_3v3>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c4 {
> +	status = "okay";
> +
> +	rtc@51 {
> +		compatible = "nxp,pcf2129";
> +		reg = <0x51>;
> +		// IRQ10_B
> +		interrupts = <0 150 0x4>;
> +		};

Bad indentation.

Shawn

> +
> +};
> +
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	status = "okay";
> +};
> +
> +&crypto {
> +	status = "okay";
> +};
> -- 
> 2.7.4
> 
