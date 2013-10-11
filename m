Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 37ADE2C032E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Oct 2013 06:08:21 +1100 (EST)
Message-ID: <1381518492.7979.537.camel@snotra.buserror.net>
Subject: Re: [PATCH v5] powerpc/mpc85xx: Update the clock nodes in device tree
From: Scott Wood <scottwood@freescale.com>
To: <Yuantian.Tang@freescale.com>
Date: Fri, 11 Oct 2013 14:08:12 -0500
In-Reply-To: <1381300704-4238-1-git-send-email-Yuantian.Tang@freescale.com>
References: <1381300704-4238-1-git-send-email-Yuantian.Tang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-10-09 at 14:38 +0800, Yuantian.Tang@freescale.com wrote:
> From: Tang Yuantian <yuantian.tang@frovider:
> +/ {
> +	clockgen: global-utilities@e1000 {
> +		compatible = "fsl,p5020-clockgen", "fsl,qoriq-clockgen-1.0";
> +		reg = <0xe1000 0x1000>;
> +		clock-frequency = <0>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		sysclk: sysclk {
> +			#clock-cells = <0>;
> +			compatible = "fsl,qoriq-sysclk-1.0", "fixed-clock";
> +			clock-output-names = "sysclk";
> +		}
> +
> +		pll0: pll0@800 {
> +			#clock-cells = <1>;
> +			reg = <0x800 0x4>;
> +			compatible = "fsl,qoriq-core-pll-1.0";
> +			clocks = <&sysclk>;
> +			clock-output-names = "pll0", "pll0-div2";
> +		};

Where is "ranges" in the global-utilities node?

-Scott
