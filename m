Return-Path: <vinod.koul@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by ozlabs.org (Postfix) with ESMTP id A42F52C0105
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jul 2013 21:38:09 +1000 (EST)
Date: Mon, 29 Jul 2013 16:29:01 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: hongbo.zhang@freescale.com
Subject: Re: [PATCH v7 0/3] DMA: Freescale: Add support for 8-channel DMA
 engine
Message-ID: <20130729105901.GI29095@intel.com>
References: <1375094944-3343-1-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375094944-3343-1-git-send-email-hongbo.zhang@freescale.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, djbw@fb.com,
 scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 29, 2013 at 06:49:01PM +0800, hongbo.zhang@freescale.com wrote:
> From: Hongbo Zhang <hongbo.zhang@freescale.com>
> 
> Hi Vinod, Dan, Scott and Leo, please have a look at these V7 patches.
The dma relates changes look okay to me.

I need someone to review and ACK the DT bindings.

~Vinod
> 
> Freescale QorIQ T4 and B4 introduce new 8-channel DMA engines, this patch set
> adds support this DMA engine.
> 
> V6->V7 changes:
> - only remove unnecessary "CHIP-dma" explanations in [1/3]
> 
> V5->V6 changes:
> - minor updates of descriptions in binding document and Kconfig
> - remove [4/4], that should be another patch in future
> 
> V4->V5 changes:
> - update description in the dt binding document, to make it more resonable
> - add new patch [4/4] to eliminate a compiling warning which already exists
>   for a long time
> 
> V3->V4 changes:
> - introduce new patch [1/3] to revise the legacy dma binding document
> - and then add new paragraph to describe new dt node binding in [2/3]
> - rebase to latest kernel v3.11-rc1
> 
> V2->V3 changes:
> - edit Documentation/devicetree/bindings/powerpc/fsl/dma.txt
> - edit text string in Kconfig and the driver files, using "elo series" to
>   mention all the current "elo*"
> 
> V1->V2 changes:
> - removed the codes handling the register dgsr1, since it isn't used currently
> - renamed the DMA DT compatible to "fsl,elo3-dma"
> - renamed the new dts files to "elo3-dma-<n>.dtsi"
> 
> Hongbo Zhang (3):
>   DMA: Freescale: revise device tree binding document
>   DMA: Freescale: Add new 8-channel DMA engine device tree nodes
>   DMA: Freescale: update driver to support 8-channel DMA engine
> 
>  .../devicetree/bindings/powerpc/fsl/dma.txt        |  114 +++++++++++++++-----
>  arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |    4 +-
>  arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi          |   81 ++++++++++++++
>  arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi          |   81 ++++++++++++++
>  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |    4 +-
>  drivers/dma/Kconfig                                |    9 +-
>  drivers/dma/fsldma.c                               |    9 +-
>  drivers/dma/fsldma.h                               |    2 +-
>  8 files changed, 264 insertions(+), 40 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-0.dtsi
>  create mode 100644 arch/powerpc/boot/dts/fsl/elo3-dma-1.dtsi
> 
> -- 
> 1.7.9.5
> 
> 
> 

-- 
