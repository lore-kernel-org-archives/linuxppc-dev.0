Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v3gWy6XnqzDqVM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jan 2017 08:46:06 +1100 (AEDT)
Received: by mail-oi0-f68.google.com with SMTP id u143so1846853oif.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jan 2017 13:46:06 -0800 (PST)
Date: Wed, 18 Jan 2017 15:46:03 -0600
From: Rob Herring <robh@kernel.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@axis.com, linux-arm-msm@vger.kernel.org, nsekhar@ti.com
Subject: Re: [PATCH 30/37] dt-bindings: PCI: dra7xx: Add dt bindings to
 enable legacy mode
Message-ID: <20170118214603.qnewy3sm6sgw7lbg@rob-hp-laptop>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <1484216786-17292-31-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484216786-17292-31-git-send-email-kishon@ti.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 12, 2017 at 03:56:19PM +0530, Kishon Vijay Abraham I wrote:
> Update device tree binding documentation of TI's dra7xx PCI
> controller to include property for enabling legacy mode.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/ti-pci.txt |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/ti-pci.txt b/Documentation/devicetree/bindings/pci/ti-pci.txt
> index 62f5f59..ed85e8e 100644
> --- a/Documentation/devicetree/bindings/pci/ti-pci.txt
> +++ b/Documentation/devicetree/bindings/pci/ti-pci.txt
> @@ -39,6 +39,10 @@ DEVICE MODE
>   - interrupts : one interrupt entries must be specified for main interrupt.
>   - num-ib-windows : number of inbound address translation windows
>   - num-ob-windows : number of outbound address translation windows
> + - syscon-legacy-mode: phandle to the syscon dt node. The 1st argument should
> +		       contain the register offset within syscon and the 2nd
> +		       argument should contain the bit field for setting the
> +		       legacy mode

What's legacy mode?

>  
>  Optional Property:
>   - gpios : Should be added if a gpio line is required to drive PERST# line
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
