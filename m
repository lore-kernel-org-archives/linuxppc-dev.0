Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0240.outbound.protection.outlook.com [207.46.163.240])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7E39F2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 11:29:45 +1100 (EST)
Date: Wed, 19 Mar 2014 19:29:32 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: Re: [1/3] powerpc/fsl-booke: Add support for T2080/T2081 SoC
Message-ID: <20140320002932.GA31768@home.buserror.net>
References: <1393840220-31086-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1393840220-31086-1-git-send-email-Shengzhou.Liu@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, prabhakar@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 03, 2014 at 05:50:18PM +0800, Shengzhou Liu wrote:
> +	corenet-cf@18000 {
> +		compatible = "fsl,corenet-cf";
> +		reg = <0x18000 0x1000>;
> +		interrupts = <16 2 1 31>;
> +		fsl,ccf-num-csdids = <32>;
> +		fsl,ccf-num-snoopids = <32>;
> +	};

As I told Prabhakar in 
https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-March/116093.html
this needs a binding and a new compatible property.

> +	clockgen: global-utilities@e1000 {
> +		compatible = "fsl,t2080-clockgen", "fsl,qoriq-clockgen-2.0";
> +		reg = <0xe1000 0x1000>;
> +	};

See Documentation/devicetree/bindings/clock/corenet-clock.txt

-Scott
