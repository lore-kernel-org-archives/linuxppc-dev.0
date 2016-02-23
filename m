Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C63541A05CB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 07:15:26 +1100 (AEDT)
Date: Tue, 23 Feb 2016 14:15:20 -0600
From: Rob Herring <robh@kernel.org>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: oss@buserror.net, leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/7] QE: Add IC, SI and SIRAM document to device tree
 bindings.
Message-ID: <20160223201520.GA3354@rob-hp-laptop>
References: <1455757572-44955-1-git-send-email-qiang.zhao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1455757572-44955-1-git-send-email-qiang.zhao@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 18, 2016 at 09:06:06AM +0800, Zhao Qiang wrote:
> Add IC, SI and SIRAM document of QE to
> Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt
> 
> Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
> ---
> Changes for v2
> 	- Add interrupt-controller in Required properties
> 	- delete address-cells and size-cells for qe-si and qe-siram
> 
>  .../devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt  | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt
> index 4f89302..84052a7 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/cpm_qe/qe.txt
> @@ -69,6 +69,56 @@ Example:
>  	};
>       };
>  
> +* Interrupt Controller (IC)
> +
> +Required properties:
> +- compatible : should be "fsl,qe-ic".

> +- compatible : should be "fsl,qe-si".

> +- compatible : should be "fsl,qe-siram".

These compatible strings are all a bit generic and should have SoC 
specific compatible strings.

Rob
