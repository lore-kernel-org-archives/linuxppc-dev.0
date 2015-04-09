Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0112.outbound.protection.outlook.com [157.56.110.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ADEFC1A04E0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 03:00:39 +1000 (AEST)
Message-ID: <1428598825.22867.532.camel@freescale.com>
Subject: Re: [PATCH] dt/bindings: fsl/guts: Added global-utilities compatibles
From: Scott Wood <scottwood@freescale.com>
To: Igal.Liberman <igal.liberman@freescale.com>
Date: Thu, 9 Apr 2015 12:00:25 -0500
In-Reply-To: <1428560392-30903-1-git-send-email-igal.liberman@freescale.com>
References: <1428560392-30903-1-git-send-email-igal.liberman@freescale.com>
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

On Thu, 2015-04-09 at 09:19 +0300, Igal.Liberman wrote:
> From: Igal Liberman <Igal.Liberman@freescale.com>
> 
> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> ---
>  .../devicetree/bindings/powerpc/fsl/guts.txt       |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt b/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> index 7f150b5..e4f0ac2 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> @@ -9,6 +9,20 @@ Required properties:
>  
>   - compatible : Should define the compatible device type for
>     global-utilities.
> +   Possible compatibles:
> +	"fsl,qoriq-device-config-1.0"
> +	"fsl,p2041-device-config"
> +	"fsl,p3041-device-config"
> +	"fsl,p4080-device-config"
> +	"fsl,p5020-device-config"
> +	"fsl,p5040-device-config"
> +	"fsl,qoriq-device-config-2.0"
> +	"fsl,b4860-device-config"
> +	"fsl,b4420-device-config"
> +	"fsl,b4-device-config"
> +	"fsl,t1040-device-config"
> +	"fsl,t2080-device-config"
> +	"fsl,t4240-device-config"

There's no need to list every chip here.  Just list the ones that aren't
chips, plus "fsl,<chip>-device-config".

As for fsl,b4-device-config, does that exist in any final dtb (as
opposed to b4si-post.dtsi)?  The b4420 and b4860 dtsi files both
overwrite that compatible.

-Scott
