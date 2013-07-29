Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AD3582C0106
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 08:11:06 +1000 (EST)
Date: Mon, 29 Jul 2013 17:10:52 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v7 2/3] DMA: Freescale: Add new 8-channel DMA engine
 device tree nodes
To: <hongbo.zhang@freescale.com>
References: <1375094944-3343-1-git-send-email-hongbo.zhang@freescale.com>
 <1375094944-3343-3-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1375094944-3343-3-git-send-email-hongbo.zhang@freescale.com>
 (from hongbo.zhang@freescale.com on Mon Jul 29 05:49:03 2013)
Message-ID: <1375135852.30721.60@snotra>
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

On 07/29/2013 05:49:03 AM, hongbo.zhang@freescale.com wrote:
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

ACK

-Scott=
