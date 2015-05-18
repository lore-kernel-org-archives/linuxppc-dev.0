Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0102.outbound.protection.outlook.com [207.46.100.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4AB111A0140
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 07:09:32 +1000 (AEST)
Message-ID: <1431983358.27761.11.camel@freescale.com>
Subject: Re: [PATCH] powerpc/fsl: Add FMan best effort port compatible
From: Scott Wood <scottwood@freescale.com>
To: <igal.liberman@freescale.com>
Date: Mon, 18 May 2015 16:09:18 -0500
In-Reply-To: <1431938519-11343-1-git-send-email-igal.liberman@freescale.com>
References: <1431938519-11343-1-git-send-email-igal.liberman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 madalin.bucur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-05-18 at 11:41 +0300, Igal.Liberman wrote:
> From: Igal Liberman <igal.liberman@freescale.com>
> 
> This patch adds a compatible which represents FMan V3 best effort ports.
> FMan best effort port is configured as 10G ports, however, it uses 1G
> hardware.
> 
> Signed-off-by: Igal Liberman <igal.liberman@freescale.com>
> ---
>  .../devicetree/bindings/powerpc/fsl/fman.txt       |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> index edda55f..c2e3ec3 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/fman.txt
> @@ -166,6 +166,11 @@ PROPERTIES
>  			- "fsl,fman-v3-port-oh" for FManV3 OH ports
>  			- "fsl,fman-v3-port-rx" for FManV3 RX ports
>  			- "fsl,fman-v3-port-tx" for FManV3 TX ports
> +		Optional compatible which can be used in addition to the
> +		compatibles above is:
> +			- "fsl,fman-v3-best-effort-port"
> +		This compatible represents 10G best effort ports:
> +			Port configured as 10G, using 1G hardware.

What does this mean?  If it's using 1G hardware then it's a 1G port,
right?  How can you configure a 1G port to be 10G?

Why is this compatible in addition to others (note that this implies
such ports are 100% backwards compatible with hardware that lacks the
new compatible)?  You'd have the same compatible on rx and tx nodes (I'm
assuming this isn't applicable to oh)?

What are the implications of this that warrant adding a compatible?

-Scott
