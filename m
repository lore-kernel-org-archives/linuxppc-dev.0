Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0134.outbound.protection.outlook.com [157.56.110.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A86471A024B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 09:27:59 +1000 (AEST)
Date: Thu, 28 May 2015 18:27:44 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [1/4, v4] powerpc/fsl-booke: Add device tree support for
 T1024/T1023 SoC
Message-ID: <20150528232744.GA1810@home.buserror.net>
References: <1429069688-10287-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1429069688-10287-1-git-send-email-Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 15, 2015 at 11:48:08AM +0800, Shengzhou Liu wrote:
> +	};
> +/include/ "qoriq-i2c-0.dtsi"
> +/include/ "qoriq-i2c-1.dtsi"
> +/include/ "qoriq-duart-0.dtsi"
> +/include/ "qoriq-duart-1.dtsi"
> +/include/ "qoriq-gpio-0.dtsi"
> +/include/ "qoriq-gpio-1.dtsi"
> +/include/ "qoriq-gpio-2.dtsi"
> +/include/ "qoriq-gpio-3.dtsi"
> +/include/ "qoriq-usb2-mph-0.dtsi"
> +		usb0: usb@210000 {
> +			compatible = "fsl-usb2-mph-v2.5", "fsl-usb2-mph";
> +			fsl,iommu-parent = <&pamu0>;
> +			fsl,liodn-reg = <&guts 0x520>; /* USB1LIODNR */
> +			phy_type = "utmi";
> +			port0;
> +		};
> +/include/ "qoriq-usb2-dr-0.dtsi"
> +		usb1: usb@211000 {
> +			compatible = "fsl-usb2-dr-v2.5", "fsl-usb2-dr";
> +			fsl,iommu-parent = <&pamu0>;
> +			fsl,liodn-reg = <&guts 0x524>; /* USB2LIODNR */
> +			dr_mode = "host";
> +			phy_type = "utmi";
> +		};
> +/include/ "qoriq-sata2-0.dtsi"
> +sata@220000 {
> +			fsl,iommu-parent = <&pamu0>;
> +			fsl,liodn-reg = <&guts 0x550>; /* SATA1LIODNR */
> +};
> +
> +/include/ "qoriq-sec5.0-0.dtsi"
> +};

Whitespace here is a mess -- fixed while applying.

-Scott
