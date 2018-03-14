Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RGh6rJvzDqhg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:28:12 +1100 (AEDT)
In-Reply-To: <20180225172236.29650-17-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [16/21] powerpc: Add missing prototype for init_IRQ
Message-Id: <401RGc5Lx5z9sVl@ozlabs.org>
Date: Wed, 14 Mar 2018 20:28:00 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-02-25 at 17:22:31 UTC, Mathieu Malaterre wrote:
> A function init_IRQ was added without a prototype declared in header irq.h.
> Fix the following warning (treated as error in W=1):
> 
>   CC      arch/powerpc/kernel/irq.o
> arch/powerpc/kernel/irq.c:662:13: error: no previous prototype for ‘init_IRQ’ [-Werror=missing-prototypes]
>  void __init init_IRQ(void)
>              ^~~~~~~~
> cc1: all warnings being treated as errors
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/23a6d8b9634897add6ebff32372f34

cheers
