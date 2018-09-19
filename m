Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Ffsw46xKzDqNG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 22:53:08 +1000 (AEST)
Date: Wed, 19 Sep 2018 14:52:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Ingo Molnar <mingo@redhat.com>, segher@kernel.crashing.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 1/2] sched: move stack_canary field at the top of
 task_struct
Message-ID: <20180919125259.GG24124@hirez.programming.kicks-ass.net>
References: <d60ce7dd74704b0ca0a857186f30de4006b63534.1537355312.git.christophe.leroy@c-s.fr>
 <20180919115836.GE24124@hirez.programming.kicks-ass.net>
 <f6a36d25-ce19-5d56-69d9-198215a7b9e1@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f6a36d25-ce19-5d56-69d9-198215a7b9e1@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 19, 2018 at 02:25:00PM +0200, Christophe LEROY wrote:
> I have not been able to find a way to define the compilation flags AFTER
> building asm-offsets.h, see https://patchwork.ozlabs.org/patch/971521/
> 
> If you have a suggestion, it is welcomed.

Not really; I always get lost in that stuff :/

> > Might as well put it before state, right after the task_info thing.
> > 
> 
> Yes, it doesn't make much difference, don't any arch expect state at offset
> 0 ?

Uhmm.. dunno. I would not expect so, but then I didn't check.
