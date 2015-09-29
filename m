Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0109.outbound.protection.outlook.com [157.56.111.109])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C6FD51A04ED
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 10:25:51 +1000 (AEST)
Date: Mon, 28 Sep 2015 19:25:38 -0500
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 21/25] powerpc: add inline functions for cache related
 instructions
Message-ID: <20150929002538.GJ6161@home.buserror.net>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <cceec6246b12b6639e2fbe2ad5d70d93356196b6.1442939410.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cceec6246b12b6639e2fbe2ad5d70d93356196b6.1442939410.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 22, 2015 at 06:51:11PM +0200, Christophe Leroy wrote:
> This patch adds inline functions to use dcbz, dcbi, dcbf, dcbst
> from C functions
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> New in v2
> 
>  arch/powerpc/include/asm/cache.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

This patch needs to come before patch 20/25, which uses dcbz().

-Scott
