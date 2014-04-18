Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2984614007A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Apr 2014 07:33:53 +1000 (EST)
Message-ID: <1397856821.1694.126.camel@snotra.buserror.net>
Subject: Re: [PATCH v2] powerpc/fsl: Added binding for Freescale CoreNet
 coherency fabric (CCF)
From: Scott Wood <scottwood@freescale.com>
To: Diana Craciun <diana.craciun@freescale.com>
Date: Fri, 18 Apr 2014 16:33:41 -0500
In-Reply-To: <1397833917-12611-1-git-send-email-diana.craciun@freescale.com>
References: <1397833917-12611-1-git-send-email-diana.craciun@freescale.com>
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

On Fri, 2014-04-18 at 18:11 +0300, Diana Craciun wrote:
> From: Diana Craciun <Diana.Craciun@freescale.com>
> 
> The CoreNet coherency fabric is a fabric-oriented, conectivity
> infrastructure that enables the implementation of coherent, multicore
> systems. The CCF acts as a central interconnect for cores,
> platform-level caches, memory subsystem, peripheral devices and I/O host
> bridges in the system.
> 
> Signed-off-by: Diana Craciun <Diana.Craciun@freescale.com>
> ---
>  .../devicetree/bindings/powerpc/fsl/ccf.txt        | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/ccf.txt
> 
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/ccf.txt b/Documentation/devicetree/bindings/powerpc/fsl/ccf.txt
> new file mode 100644
> index 0000000..f0b7143
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/ccf.txt
> @@ -0,0 +1,36 @@
> +Freescale CoreNet Coherency Fabric(CCF) Device Tree Binding
> +
> +DESCRIPTION
> +
> +The CoreNet coherency fabric is a fabric-oriented, connectivity infrastructure
> +that enables the implementation of coherent, multicore systems.
> +
> +Required properties:
> +
> +- compatible : <string>
> +		Must include "fsl,corenetX-cf", "fsl,corenet-cf" - CoreNet coherency 
> +		fabric version X

Specify "fsl,corenet1-cf" and "fsl,corenet2-cf" rather than
"fsl,corenetX-cf" (given there's nothing in a chip manual that you can
correlate with the value of X), and provide example chips for each.

Also specify that "fsl,corenet-cf" represents the registers that are
common between the two versions (not arbitrary "fsl,corenetX-cf" -- if
there's ever an "fsl,corenet3-cf" it may not be compatible with this),
and is retained for compatibility reasons.

-Scott
