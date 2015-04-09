Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (unknown [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9E3C51A04E0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 17:08:35 +1000 (AEST)
Date: Thu, 9 Apr 2015 09:08:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/3] jump_label: Allow asm/jump_label.h to be included in
 assembly
Message-ID: <20150409070813.GM27490@worktop.programming.kicks-ass.net>
References: <1428551492-21977-1-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428551492-21977-1-git-send-email-anton@samba.org>
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

On Thu, Apr 09, 2015 at 01:51:30PM +1000, Anton Blanchard wrote:
> Wrap asm/jump_label.h for all archs with #ifndef __ASSEMBLY__.
> Since these are kernel only headers, we don't need #ifdef __KERNEL__
> so can simplify things a bit.
> 
> If an architecture wants to use jump labels in assembly, it
> will still need to define a macro to create the __jump_table
> entries (see ARCH_STATIC_BRANCH in the powerpc asm/jump_label.h
> for an example).
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
