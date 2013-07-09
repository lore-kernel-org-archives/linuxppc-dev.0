Return-Path: <B07421@freescale.com>
Date: Tue, 9 Jul 2013 11:48:46 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V2 1/2] DMA: Freescale: Add new 8-channel DMA engine
 device tree nodes
To: <hongbo.zhang@freescale.com>
References: <1373005626-20726-1-git-send-email-hongbo.zhang@freescale.com>
 <1373005626-20726-2-git-send-email-hongbo.zhang@freescale.com>
In-Reply-To: <1373005626-20726-2-git-send-email-hongbo.zhang@freescale.com>
 (from hongbo.zhang@freescale.com on Fri Jul  5 01:27:05 2013)
Message-ID: <1373388526.8183.191@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: vinod.koul@intel.com, devicetree-discuss@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, vakul@freescale.com,
 Hongbo Zhang <hongbo.zhang@freescale.com>, djbw@fb.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/05/2013 01:27:05 AM, hongbo.zhang@freescale.com wrote:
> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>=20
> Freescale QorIQ T4 and B4 introduce new 8-channel DMA engines, this =20
> patch add
> the device tree nodes for them.
>=20
> Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
> ---
>  arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi   |   90 =20
> +++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi   |   90 =20
> +++++++++++++++++++++++++++
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi |    4 +-
>  3 files changed, 182 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi
>  create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi

Please update Documentation/devicetree/bindings/powerpc/fsl/dma.txt for =20
the new compatible and dgsr1.

-Scott=
