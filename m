Return-Path: <B35336@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B05032C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2013 10:38:31 +1000 (EST)
Date: Mon, 15 Apr 2013 16:38:21 +0800
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 03/17] powerpc/85xx: cache operations for Freescale SoCs
 based on BOOK3E
Message-ID: <20130415083254.GA3596@localhost.localdomain>
References: <1364994565-16010-1-git-send-email-chenhui.zhao@freescale.com>
 <1364994565-16010-3-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1364994565-16010-3-git-send-email-chenhui.zhao@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 03, 2013 at 09:09:11PM +0800, Zhao Chenhui wrote:
> These cache operations support Freescale SoCs based on BOOK3E.
> Move L1 cache operations to fsl_booke_cache.S in order to maintain
> easily. And, add cache operations for backside L2 cache and platform cache.
> 
> The backside L2 cache appears on e500mc and e5500 core. The platform cache
> supported by this patch is L2 Look-Aside Cache, which appears on SoCs
> with e500v1/e500v2 core, such as MPC8572, P1020, etc.
> 
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  arch/powerpc/include/asm/cacheflush.h |    8 ++
>  arch/powerpc/kernel/Makefile          |    1 +
>  arch/powerpc/kernel/fsl_booke_cache.S |  210 +++++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/head_fsl_booke.S  |   74 ------------
>  4 files changed, 219 insertions(+), 74 deletions(-)
>  create mode 100644 arch/powerpc/kernel/fsl_booke_cache.S

Are there any comments about the set of patches?

-Chenhui
