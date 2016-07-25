Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryTpS4kSszDqVF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 15:10:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: chengang@emindsoft.com.cn, akpm@linux-foundation.org,
 benh@kernel.crashing.org, paulus@samba.org
Cc: dave.hansen@linux.intel.com, tglx@linutronix.de, mingo@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Chen Gang <chengang@emindsoft.com.cn>, Chen Gang <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH v2] include: mman: Use bool instead of int for the return
 value of arch_validate_prot
In-Reply-To: <1469331815-2026-1-git-send-email-chengang@emindsoft.com.cn>
References: <1469331815-2026-1-git-send-email-chengang@emindsoft.com.cn>
Date: Mon, 25 Jul 2016 15:10:06 +1000
Message-ID: <8737my1exd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

chengang@emindsoft.com.cn writes:

> From: Chen Gang <chengang@emindsoft.com.cn>
>
> For pure bool function's return value, bool is a little better more or
> less than int.
>
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  arch/powerpc/include/asm/mman.h | 8 ++++----
>  include/linux/mman.h            | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Andrew do you want to take this or should I?

cheers
