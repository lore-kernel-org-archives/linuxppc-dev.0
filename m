Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 31891DEB20
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 01:24:55 +1000 (EST)
Date: Wed, 6 Aug 2008 19:24:54 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 2/6] powerpc: export cpm2_immr symbol for CPM2 drivers
	to compile as module
Message-ID: <20080806152454.GA18655@polina.dev.rtsoft.ru>
References: <1218006285-27138-1-git-send-email-leoli@freescale.com>
	<1218006285-27138-2-git-send-email-leoli@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <1218006285-27138-2-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 06, 2008 at 03:04:41PM +0800, Li Yang wrote:
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  arch/powerpc/sysdev/cpm2.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/cpm2.c b/arch/powerpc/sysdev/cpm2.c
> index f1c3395..021480e 100644
> --- a/arch/powerpc/sysdev/cpm2.c
> +++ b/arch/powerpc/sysdev/cpm2.c
> @@ -52,6 +52,7 @@ cpm_cpm2_t __iomem *cpmp; /* Pointer to comm processor space */
>   * the communication processor devices.
>   */
>  cpm2_map_t __iomem *cpm2_immr;
> +EXPORT_SYMBOL(cpm2_immr);

This is uneeded if you'll start using cpm_muram_* functions
from include/asm-powerpc/cpm.h.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
