Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0185.outbound.protection.outlook.com [207.46.163.185])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F4361A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 09:24:13 +1000 (EST)
Date: Wed, 25 Jun 2014 18:23:58 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: Re: [2/3,v4] powerpc/fsl-booke: Add initial T208x QDS board support
Message-ID: <20140625232358.GA12402@home.buserror.net>
References: <1402481406-10830-2-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1402481406-10830-2-git-send-email-Shengzhou.Liu@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 11, 2014 at 06:10:05PM +0800, Shengzhou Liu wrote:
> +			flash@2 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "eon,en25s64";
> +				reg = <2>;
> +				spi-max-frequency = <35000000>;
> +			};

I won't hold up this patch due to this, but you should send a patch to
add eon to Documentation/devicetree/bindings/vendor-prefixes.txt.

-Scott
