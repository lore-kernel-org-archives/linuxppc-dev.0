Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 426JXy5PQYzF3BX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2018 23:42:58 +1000 (AEST)
Date: Fri, 7 Sep 2018 15:42:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] perf: enum overflow in uapi/linux/perf_event.h
Message-ID: <20180907134246.GC24106@hirez.programming.kicks-ass.net>
References: <a70172863fa7d3c138f788b18d36524bd45b0a73.1536326078.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a70172863fa7d3c138f788b18d36524bd45b0a73.1536326078.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 07, 2018 at 01:27:19PM +0000, Christophe Leroy wrote:
> On PPC32, enums are 32 bits, so __PERF_SAMPLE_CALLCHAIN_EARLY is
> out of scope. The following sparse warning is encountered:
> 
>   CHECK   arch/powerpc/kernel/process.c
> ./include/uapi/linux/perf_event.h:147:56: warning: cast truncates bits from constant value (8000000000000000 becomes 0)

Urgh... what compiler is that? I've not seen anything like that from the
build bots.
