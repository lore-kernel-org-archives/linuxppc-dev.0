Return-Path: <Laurentiu.Tudor@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 603BC1A0058
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 23:30:01 +1100 (AEDT)
Message-ID: <551D2E32.1080008@freescale.com>
Date: Thu, 2 Apr 2015 14:55:30 +0300
From: Laurentiu Tudor <b10716@freescale.com>
MIME-Version: 1.0
To: <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [1/3][PATCH][v2] Device Tree bindings for Freescale TDM controller
References: <1427971677-32395-1-git-send-email-sandeep@freescale.com>
In-Reply-To: <1427971677-32395-1-git-send-email-sandeep@freescale.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sandeep,

Small nit inside.

On 04/02/2015 01:47 PM, sandeep@freescale.com wrote:
> From: Sandeep Singh <sandeep@freescale.com>
> 
> This controller is available on many Freescale SOCs like MPC8315, P1020, P1010,
> P1022 and P1024
> 
> Signed-off-by: Sandeep Singh <Sandeep@freescale.com>
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> ---
>  Documentation/devicetree/bindings/tdm/fsl-tdm.txt |   65 +++++++++++++++++++++
>  1 files changed, 65 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/tdm/fsl-tdm.txt
> 
> diff --git a/Documentation/devicetree/bindings/tdm/fsl-tdm.txt b/Documentation/devicetree/bindings/tdm/fsl-tdm.txt
> new file mode 100644
> index 0000000..1258b89
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/tdm/fsl-tdm.txt
> @@ -0,0 +1,65 @@
> +=====================================================================
> +TDM Device Tree Binding
> +Copyright (C) 2012 Freescale Semiconductor Inc.
> +
> +NOTE: The bindings described in this document are preliminary
> +and subject to change.
> +
> +=====================================================================
> +TDM (Time Division Multiplexing)
> +
> +DESCRIPTION
> +
> +The TDM is full duplex serial port designed to allow various devices including
> +digital signal processors (DSPs) to communicate with a variety of serial devices
> +including industry standard framers, codecs, other DSPs and microprocessors.
> +
> +The below properties describe the device tree bindings for Freescale TDM
> +controller.
> +This TDM controller is available on various Freescale Processors like
> +MPC8313, P1020, P1022 and P1010.
> +
> +PROPERTIES
> +
> +  - compatible
> +      Usage: required
> +      Value type: <string>
> +      Definition: Should contain "fsl,tdm1.0".
> +
> +  - reg
> +      Usage: required
> +      Definition: A standard property. The first reg specifier describes the
> +          TDM registers, and the second describes the TDM DMAC registers.
> +
> +  - clock-frequency
> +      Usage: optional
> +      Value type: <u32 or u64>
> +      Definition: The frequency at which the TDM block is operating.
> +
> +  - interrupts
> +      Usage: required
> +      Definition: Definition: Two interrupt specifiers.  The first is TDM

Extra "Definition:" here.

---
Best Regards, Laurentiu
