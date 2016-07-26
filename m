Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryz4Z3xv5zDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 10:09:02 +1000 (AEST)
Date: Mon, 25 Jul 2016 17:08:59 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: chengang@emindsoft.com.cn, benh@kernel.crashing.org, paulus@samba.org,
 dave.hansen@linux.intel.com, tglx@linutronix.de, mingo@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Chen Gang
 <gang.chen.5i5j@gmail.com>
Subject: Re: [PATCH v2] include: mman: Use bool instead of int for the
 return value of arch_validate_prot
Message-Id: <20160725170859.1be58d7f19b72a0340ee65c7@linux-foundation.org>
In-Reply-To: <8737my1exd.fsf@concordia.ellerman.id.au>
References: <1469331815-2026-1-git-send-email-chengang@emindsoft.com.cn>
 <8737my1exd.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 25 Jul 2016 15:10:06 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:

> chengang@emindsoft.com.cn writes:
> 
> > From: Chen Gang <chengang@emindsoft.com.cn>
> >
> > For pure bool function's return value, bool is a little better more or
> > less than int.
> >
> > Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> > ---
> >  arch/powerpc/include/asm/mman.h | 8 ++++----
> >  include/linux/mman.h            | 2 +-
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> LGTM.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> Andrew do you want to take this or should I?

I grabbed it, thanks.
