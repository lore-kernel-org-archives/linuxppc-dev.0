Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRmXg0lVbzDqLJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 15:41:39 +1000 (AEST)
Message-ID: <1494913288.29095.7.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: roy.pledge@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 robin.murphy@arm.com
Cc: madalin.bucur@nxp.com
Date: Tue, 16 May 2017 00:41:28 -0500
In-Reply-To: <1493674213-963-1-git-send-email-roy.pledge@nxp.com>
References: <1493674213-963-1-git-send-email-roy.pledge@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH v3 00/11] soc/fsl/qbman: Enable QBMan on ARM Platforms
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-05-01 at 17:30 -0400, Roy Pledge wrote:
> This patch series enables DPAA1 QBMan devices for ARM and
> ARM64 architectures. This allows the LS1043A and LS1046A to use
> QBMan functionality.
> 
> Changes since v2:
> Fixed some misspellings
> Added 'no-map' constraint to device tree bindings
> Described ordering contraint on regions in the device tree
> Removed confusing comment regarding non-shareable mappings
> Added warning if old reserved-memory technique is used on ARM
> 
> Changes since v1:
> Reworked private memory allocations to use shared-dma-pool on ARM platforms
> 
> Claudiu Manoil (2):
>   soc/fsl/qbman: Drop L1_CACHE_BYTES compile time check
>   soc/fsl/qbman: Add missing headers on ARM
> 
> Madalin Bucur (4):
>   soc/fsl/qbman: Drop set/clear_bits usage
>   soc/fsl/qbman: add QMAN_REV32
>   soc/fsl/qbman: different register offsets on ARM
>   fsl/soc/qbman: Enable FSL_LAYERSCAPE config on ARM
> 
> Roy Pledge (4):
>   soc/fsl/qbman: Use shared-dma-pool for BMan private memory allocations
>   soc/fsl/qbman: Use shared-dma-pool for QMan private memory allocations
>   dt-bindings: soc/fsl: Update reserved memory binding for QBMan
>   soc/fsl/qbman: Rework ioremap() calls for ARM/PPC
> 
> Valentin Rothberg (1):
>   soc/fsl/qbman: Fix ARM32 typo

Acked-by: Scott Wood <oss@buserror.net>

-Scott
