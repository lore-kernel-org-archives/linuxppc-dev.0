Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 669E41A0118
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 00:25:49 +1100 (AEDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3 3/3] rheap: move rheap.c from arch/powerpc/lib/ to lib/
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1414654264-2596-3-git-send-email-B45475@freescale.com>
Date: Thu, 30 Oct 2014 08:25:36 -0500
Message-Id: <F09BF3A4-A194-4120-ACA0-155077690131@kernel.crashing.org>
References: <1414654264-2596-1-git-send-email-B45475@freescale.com>
 <1414654264-2596-3-git-send-email-B45475@freescale.com>
To: Zhao Qiang <B45475@freescale.com>
Cc: B07421@freescale.com, R63061@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 30, 2014, at 2:31 AM, Zhao Qiang <B45475@freescale.com> wrote:

> qe need to use the rheap, so move it to public directory.
> 
> Signed-off-by: Zhao Qiang <B45475@freescale.com>
> ---
> arch/powerpc/Kconfig                                    | 3 ---
> arch/powerpc/include/asm/fsl_85xx_cache_sram.h          | 2 +-
> arch/powerpc/lib/Makefile                               | 2 --
> arch/powerpc/platforms/44x/Kconfig                      | 2 +-
> arch/powerpc/platforms/85xx/Kconfig                     | 2 +-
> arch/powerpc/platforms/Kconfig                          | 2 +-
> arch/powerpc/platforms/Kconfig.cputype                  | 2 +-
> arch/powerpc/sysdev/cpm1.c                              | 2 +-
> arch/powerpc/sysdev/cpm2.c                              | 2 +-
> arch/powerpc/sysdev/cpm_common.c                        | 2 +-
> arch/powerpc/sysdev/ppc4xx_ocm.c                        | 2 +-
> drivers/dma/bestcomm/Kconfig                            | 2 +-
> drivers/soc/fsl-qe/Kconfig                              | 2 +-
> drivers/soc/fsl-qe/qe.c                                 | 2 +-
> drivers/soc/fsl-qe/qe_common.c                          | 2 +-
> include/linux/fsl/bestcomm/sram.h                       | 2 +-
> {arch/powerpc/include/asm => include/linux/fsl}/rheap.h | 0
> lib/Kconfig                                             | 3 +++
> lib/Makefile                                            | 2 ++
> {arch/powerpc/lib => lib}/rheap.c                       | 2 +-
> 20 files changed, 20 insertions(+), 20 deletions(-)
> rename {arch/powerpc/include/asm => include/linux/fsl}/rheap.h (100%)
> rename {arch/powerpc/lib => lib}/rheap.c (99%)

NAK.  As I stated before you need to convert rheap users to lib/genalloc.c

- k
