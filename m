Return-Path: <kumar.gala@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 06EF5B6F06
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2010 16:28:26 +1100 (EST)
Subject: Re: [PATCH 2/2] powerpc/85xx: add DIU support to the Freecale P1022DS
	reference board
MIME-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1284057597-17126-2-git-send-email-timur@freescale.com>
Date: Thu, 7 Oct 2010 00:28:19 -0500
Message-ID: <0088605C-957A-4AA8-9E1D-05EE2F1F7115@freescale.com>
References: <1284057597-17126-1-git-send-email-timur@freescale.com>
	<1284057597-17126-2-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org, yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 9, 2010, at 1:39 PM, Timur Tabi wrote:

> +static void p1022ds_set_monitor_port(int monitor_port)
> +{
> +	struct device_node *pixis_node;
> +	u8 __iomem *brdcfg1;
> +
> +	pixis_node = of_find_compatible_node(NULL, NULL, "fsl,fpga-pixis");
> +	if (!pixis_node) {
> +		pr_err("p1022ds: missing ngPIXIS node\n");
> +		return;
> +	}
> +

update based on change to compatible in .dts

- k
