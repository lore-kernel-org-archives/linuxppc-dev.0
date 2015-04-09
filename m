Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C6CCC1A0BD7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 17:09:16 +1000 (AEST)
Date: Thu, 9 Apr 2015 09:08:53 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 3/3] powerpc: Include linux/jump_label.h to get
 HAVE_JUMP_LABEL define
Message-ID: <20150409070853.GO27490@worktop.programming.kicks-ass.net>
References: <1428551492-21977-1-git-send-email-anton@samba.org>
 <1428551492-21977-3-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428551492-21977-3-git-send-email-anton@samba.org>
Cc: heiko.carstens@de.ibm.com, paulus@samba.org, hpa@zytor.com,
 mingo@kernel.org, linux@arm.linux.org.uk, mingo@redhat.com, mgorman@suse.de,
 catalin.marinas@arm.com, liuj97@gmail.com, linux-kbuild@vger.kernel.org,
 will.deacon@arm.com, rostedt@goodmis.org, jbaron@akamai.com,
 tglx@linutronix.de, mmarek@suse.cz, linux-kernel@vger.kernel.org,
 ralf@linux-mips.org, schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 09, 2015 at 01:51:32PM +1000, Anton Blanchard wrote:
> Commit 1bc9e47aa8e4 ("powerpc/jump_label: Use HAVE_JUMP_LABEL")
> converted uses of CONFIG_JUMP_LABEL to HAVE_JUMP_LABEL in
> some assembly files.
> 
> HAVE_JUMP_LABEL is defined in linux/jump_label.h, so we need to
> include this or we always get the non jump label fallback code.
> 
> Fixes: 1bc9e47aa8e4 ("powerpc/jump_label: Use HAVE_JUMP_LABEL")
> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
