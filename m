Return-Path: <B07421@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0250.outbound.messaging.microsoft.com [213.199.154.250])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A2A852C00F1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jul 2013 08:03:18 +1000 (EST)
Date: Fri, 26 Jul 2013 17:03:01 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v6 2/3] DMA: Freescale: Add new 8-channel DMA engine
 device tree nodes
To: <hongbo.zhang@freescale.com>
References: <1374834436-7149-1-git-send-email-hongbo.zhang@freescale.com>
 <1374834436-7149-3-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1374834436-7149-3-git-send-email-hongbo.zhang@freescale.com>
 (from hongbo.zhang@freescale.com on Fri Jul 26 05:27:15 2013)
Message-ID: <1374876181.30721.28@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: devicetree@vger.kernel.org, vinod.koul@intel.com,
 linux-kernel@vger.kernel.org, Hongbo Zhang <hongbo.zhang@freescale.com>,
 djbw@fb.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/26/2013 05:27:15 AM, hongbo.zhang@freescale.com wrote:
> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>=20
> Freescale QorIQ T4 and B4 introduce new 8-channel DMA engines, this =20
> patch adds
> the device tree nodes for them.
>=20
> Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
> ---
>  .../devicetree/bindings/powerpc/fsl/dma.txt        |   66 =20
> ++++++++++++++++
>  arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |    4 +-
>  arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi          |   81 =20
> ++++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi          |   81 =20
> ++++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |    4 +-
>  5 files changed, 232 insertions(+), 4 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi
>  create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi
>=20
> diff --git a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt =20
> b/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
> index ed703d9..c9f81b9 100644
> --- a/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
> +++ b/Documentation/devicetree/bindings/powerpc/fsl/dma.txt
> @@ -130,6 +130,72 @@ Example:
>  		};
>  	};
>=20
> +** Freescale Elo3 DMA Controller
> +   This is EloPlus controller with 8 channels, used in Freescale =20
> Txxx and Bxxx
> +   series chips, such as t1040, t4240, b4860.
> +
> +Required properties:
> +
> +- compatible        : must include "fsl,elo3-dma"

OK, you fixed it here, but you still have the "fsl,CHIP-dma" language =20
in the rest of the document.  There is no difference between elo3 and =20
previous chips regarding fsl,CHIP-dma as far as the binding is =20
concerned.

-Scott=
