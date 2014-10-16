Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0148.outbound.protection.outlook.com [157.56.110.148])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 145C11A02B0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Oct 2014 08:55:15 +1100 (AEDT)
Message-ID: <1413496486.7417.11.camel@aoeu.buserror.net>
Subject: Re: [PATCH 1/2] powerpc: move ppc_init() to common place
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Thu, 16 Oct 2014 23:54:46 +0200
In-Reply-To: <1413458321-23880-2-git-send-email-haokexin@gmail.com>
References: <1413458321-23880-1-git-send-email-haokexin@gmail.com>
 <1413458321-23880-2-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Jingchang Lu <jingchang.lu@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Mike Turquette <mturquette@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-10-16 at 19:18 +0800, Kevin Hao wrote:
> So they can be used by ppc64 board. Also remove the unneeded {} to
> make checkpatch happy.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  arch/powerpc/include/asm/machdep.h |  2 +-
>  arch/powerpc/kernel/setup-common.c | 15 +++++++++++++++
>  arch/powerpc/kernel/setup_32.c     | 15 ---------------
>  3 files changed, 16 insertions(+), 16 deletions(-)

This is unnecessary -- why not just use machine_arch_initcall?

-Scott
