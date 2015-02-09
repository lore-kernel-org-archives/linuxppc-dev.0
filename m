Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 73AEB1A0408
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 21:02:56 +1100 (AEDT)
Date: Mon, 9 Feb 2015 11:02:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tom Huynh <tom.huynh@freescale.com>
Subject: Re: [PATCH 1/3] perf/e6500: Make event translations available in sysfs
Message-ID: <20150209100242.GM23123@twins.programming.kicks-ass.net>
References: <1423262636-12053-1-git-send-email-tom.huynh@freescale.com>
 <1423262636-12053-2-git-send-email-tom.huynh@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423262636-12053-2-git-send-email-tom.huynh@freescale.com>
Cc: jolsa@redhat.com, linux-kernel@vger.kernel.org, acme@kernel.org,
 mingo@redhat.com, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 06, 2015 at 04:43:54PM -0600, Tom Huynh wrote:
>  arch/powerpc/perf/e6500-events-list.h         | 289 ++++++++++++++++++++++++++

That's a lot of events to stuff in the kernel, would a userspace list
not be more convenient?

ISTR there being various discussions on providing support for that in
tools/perf, Jiri?
