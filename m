Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0136.outbound.protection.outlook.com [65.55.169.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5185E1A0ACC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 06:24:41 +1000 (AEST)
Message-ID: <1429042131.22867.682.camel@freescale.com>
Subject: Re: [v2] dt/bindings: fsl/guts: Added global-utilities compatibles
From: Scott Wood <scottwood@freescale.com>
To: Igal.Liberman <igal.liberman@freescale.com>
Date: Tue, 14 Apr 2015 15:08:51 -0500
In-Reply-To: <1429006329-24597-1-git-send-email-igal.liberman@freescale.com>
References: <1429006329-24597-1-git-send-email-igal.liberman@freescale.com>
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

On Tue, 2015-04-14 at 13:12 +0300, Igal.Liberman wrote:
> From: Igal Liberman <Igal.Liberman@freescale.com>
> 
> v2 - Addressed Scott's feedback
> 
> Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
> ---
>  .../devicetree/bindings/powerpc/fsl/guts.txt       |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt b/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> index 7f150b5..69644e6 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/guts.txt
> @@ -9,6 +9,10 @@ Required properties:
>  
>   - compatible : Should define the compatible device type for
>     global-utilities.
> +   Possible compatibles:
> +	"fsl,qoriq-device-config-1.0"
> +	"fsl,qoriq-device-config-2.0"
> +	"fsl,<chip>-device-config"

fsl,<chip>-guts is also possible on non-corenet chips.

-Scott
