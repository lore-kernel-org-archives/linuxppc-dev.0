Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0117.outbound.protection.outlook.com [157.56.110.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B9221A0014
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 09:58:59 +1000 (AEST)
Date: Mon, 28 Sep 2015 18:58:46 -0500
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 11/25] powerpc/8xx: map 16M RAM at startup
Message-ID: <20150928235846.GF6161@home.buserror.net>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <cb26118572adb9976f6870b22a0e5ef4c67f50db.1442939410.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cb26118572adb9976f6870b22a0e5ef4c67f50db.1442939410.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 22, 2015 at 06:50:50PM +0200, Christophe Leroy wrote:
> On recent kernels, with some debug options like for instance
> CONFIG_LOCKDEP, the BSS requires more than 8M memory, allthough
> the kernel code fits in the first 8M.
> Today, it is necessary to activate CONFIG_PIN_TLB to get more than 8M
> at startup, allthough pinning TLB is not necessary for that.
> 
> This patch adds a second 8M page to the initial mapping in order to
> have 16M mapped regardless of CONFIG_PIN_TLB, like several other
> 32 bits PPC (40x, 601, ...)
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---

Is the assumption that nobody is still running 8xx systems with only 8
MiB RAM on current kernels?

-Scott
