Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0130.outbound.protection.outlook.com [157.56.111.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E28051A0014
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 10:00:54 +1000 (AEST)
Date: Mon, 28 Sep 2015 19:00:39 -0500
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 13/25] powerpc/8xx: also use r3 in the ITLB miss in
 all situations
Message-ID: <20150929000039.GG6161@home.buserror.net>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <94728e239cad2224383db7ddc1c57df7d11561eb.1442939410.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <94728e239cad2224383db7ddc1c57df7d11561eb.1442939410.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 22, 2015 at 06:50:54PM +0200, Christophe Leroy wrote:
> We are spending between 40 and 160 cycles with a mean of 65 cycles
> in the TLB handling routines (measured with mftbl) so make it more
> simple althought it adds one instruction
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> No change in v2
> 
>  arch/powerpc/kernel/head_8xx.S | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)

Why is this a separate patch from 1/25?

Same comments as on that patch.

-Scott
