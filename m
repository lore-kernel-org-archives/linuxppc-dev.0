Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B916F1A0176
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 17:33:19 +1000 (AEST)
Message-ID: <1428564799.26637.4.camel@ellerman.id.au>
Subject: Re: [PATCH 3/3] powerpc: Include linux/jump_label.h to get
 HAVE_JUMP_LABEL define
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
Date: Thu, 09 Apr 2015 17:33:19 +1000
In-Reply-To: <1428551492-21977-3-git-send-email-anton@samba.org>
References: <1428551492-21977-1-git-send-email-anton@samba.org>
 <1428551492-21977-3-git-send-email-anton@samba.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: peterz@infradead.org, heiko.carstens@de.ibm.com, paulus@samba.org,
 hpa@zytor.com, mingo@kernel.org, linux@arm.linux.org.uk, mingo@redhat.com,
 mgorman@suse.de, catalin.marinas@arm.com, liuj97@gmail.com,
 linux-kbuild@vger.kernel.org, will.deacon@arm.com, rostedt@goodmis.org,
 jbaron@akamai.com, tglx@linutronix.de, mmarek@suse.cz,
 linux-kernel@vger.kernel.org, ralf@linux-mips.org, schwidefsky@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-09 at 13:51 +1000, Anton Blanchard wrote:
> Commit 1bc9e47aa8e4 ("powerpc/jump_label: Use HAVE_JUMP_LABEL")
> converted uses of CONFIG_JUMP_LABEL to HAVE_JUMP_LABEL in
> some assembly files.
> 
> HAVE_JUMP_LABEL is defined in linux/jump_label.h, so we need to
> include this or we always get the non jump label fallback code.
> 
> Fixes: 1bc9e47aa8e4 ("powerpc/jump_label: Use HAVE_JUMP_LABEL")
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/platforms/powernv/opal-wrappers.S | 2 +-
>  arch/powerpc/platforms/pseries/hvCall.S        | 2 +-
>  arch/powerpc/platforms/pseries/lpar.c          | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


I assume it's best for Andrew to take this series with all the cross-archness?

cheers
