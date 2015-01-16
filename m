Return-Path: <bhelgaas@google.com>
Received: from mail-ob0-x230.google.com (mail-ob0-x230.google.com
 [IPv6:2607:f8b0:4003:c01::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B4561A0D72
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jan 2015 11:49:44 +1100 (AEDT)
Received: by mail-ob0-f176.google.com with SMTP id vb8so16665834obc.7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 16:49:41 -0800 (PST)
Date: Thu, 15 Jan 2015 18:49:37 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 13/28] pci: host: drop owner assignment from
 platform_drivers
Message-ID: <20150116004937.GG29776@google.com>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
 <1419196495-9626-14-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1419196495-9626-14-git-send-email-wsa@the-dreams.de>
Cc: Julia Lawall <julia.lawall@lip6.fr>, linux-kernel@vger.kernel.org,
 Minghuan Lian <minghuan.Lian@freescale.com>, linux-pci@vger.kernel.org,
 Mingkai Hu <mingkai.hu@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[+cc Julia]

On Sun, Dec 21, 2014 at 10:14:34PM +0100, Wolfram Sang wrote:
> This platform_driver does not need to set an owner, it will be populated by the
> driver core.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

I already applied the equivalent patch from Julia for v3.20, thanks!
(I know this is my fault because it took me so long to apply Julia's
patch.)

> ---
> Generated with coccinelle. SmPL file is in the introductory msg. The big
> cleanup was pulled in this merge window. This series catches the bits fallen
> through. The patches shall go in via the subsystem trees.
> 
>  drivers/pci/host/pci-layerscape.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-layerscape.c b/drivers/pci/host/pci-layerscape.c
> index 6697b1a4d4fa..68c9e5e9b0a8 100644
> --- a/drivers/pci/host/pci-layerscape.c
> +++ b/drivers/pci/host/pci-layerscape.c
> @@ -167,7 +167,6 @@ MODULE_DEVICE_TABLE(of, ls_pcie_of_match);
>  static struct platform_driver ls_pcie_driver = {
>  	.driver = {
>  		.name = "layerscape-pcie",
> -		.owner = THIS_MODULE,
>  		.of_match_table = ls_pcie_of_match,
>  	},
>  };
> -- 
> 2.1.3
> 
