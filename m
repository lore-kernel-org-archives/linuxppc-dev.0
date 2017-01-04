Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttv1463wmzDqMF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jan 2017 01:52:24 +1100 (AEDT)
Received: by mail-oi0-f66.google.com with SMTP id v84so74613787oie.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Jan 2017 06:52:24 -0800 (PST)
Date: Wed, 4 Jan 2017 08:52:21 -0600
From: Rob Herring <robh@kernel.org>
To: Madalin Bucur <madalin.bucur@nxp.com>
Cc: mark.rutland@arm.com, oss@buserror.net, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] dt-bindings: qman: Remove pool channel node
Message-ID: <20170104145221.dl472qqys6bz3jfa@rob-hp-laptop>
References: <1483527829-8369-1-git-send-email-madalin.bucur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1483527829-8369-1-git-send-email-madalin.bucur@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 04, 2017 at 01:03:49PM +0200, Madalin Bucur wrote:
> From: Scott Wood <oss@buserror.net>
> 
> No device tree has these, nor does any driver look for them.
> 
> Signed-off-by: Scott Wood <oss@buserror.net>
> ---
>  .../devicetree/bindings/soc/fsl/qman-portals.txt     | 20 --------------------
>  1 file changed, 20 deletions(-)

Applied, thanks.

Rob

> 
> diff --git a/Documentation/devicetree/bindings/soc/fsl/qman-portals.txt b/Documentation/devicetree/bindings/soc/fsl/qman-portals.txt
> index 47e46cc..5a34f3a 100644
> --- a/Documentation/devicetree/bindings/soc/fsl/qman-portals.txt
> +++ b/Documentation/devicetree/bindings/soc/fsl/qman-portals.txt
> @@ -5,7 +5,6 @@ Copyright (C) 2008 - 2014 Freescale Semiconductor Inc.
>  CONTENTS
>  
>  	- QMan Portal
> -	- QMan Pool Channel
>  	- Example
>  
>  QMan Portal Node
> @@ -82,25 +81,6 @@ These subnodes should have the following properties:
>  	Definition:	The phandle to the particular hardware device that this
>  			portal is connected to.
>  
> -DPAA QMan Pool Channel Nodes
> -
> -Pool Channels are defined with the following properties.
> -
> -PROPERTIES
> -
> -- compatible
> -	Usage:		Required
> -	Value type:	<stringlist>
> -	Definition:	Must include "fsl,qman-pool-channel"
> -			May include "fsl,<SoC>-qman-pool-channel"
> -
> -- fsl,qman-channel-id
> -	Usage:		Required
> -	Value type:	<u32>
> -	Definition:	The hardware index of the channel. This can also be
> -			determined by dividing any of the channel's 8 work queue
> -			IDs by 8
> -
>  EXAMPLE
>  
>  The example below shows a (P4080) QMan portals container/bus node with two portals
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
