Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wg0-x235.google.com (mail-wg0-x235.google.com
 [IPv6:2a00:1450:400c:c00::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C1AB51A0415
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 21:07:45 +1100 (AEDT)
Received: by mail-wg0-f53.google.com with SMTP id x13so5726693wgg.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Feb 2015 02:07:42 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 9 Feb 2015 11:07:38 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] perf/e6500: Make event translations available in sysfs
Message-ID: <20150209100738.GA5461@gmail.com>
References: <1423262636-12053-1-git-send-email-tom.huynh@freescale.com>
 <1423262636-12053-2-git-send-email-tom.huynh@freescale.com>
 <20150209100242.GM23123@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150209100242.GM23123@twins.programming.kicks-ass.net>
Cc: Tom Huynh <tom.huynh@freescale.com>, jolsa@redhat.com,
 linux-kernel@vger.kernel.org, acme@kernel.org, mingo@redhat.com,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Feb 06, 2015 at 04:43:54PM -0600, Tom Huynh wrote:
> >  arch/powerpc/perf/e6500-events-list.h         | 289 ++++++++++++++++++++++++++
> 
> That's a lot of events to stuff in the kernel, would a 
> userspace list not be more convenient?
> 
> ISTR there being various discussions on providing support 
> for that in tools/perf, Jiri?

As long as it's in a single well organized place in tools/, 
I'd be fine with that solution as well.

What doesn't work very well is disjunct, disorganized, 
inconsistent event descriptions all across the tooling and 
platform landscape - putting static tables into sysfs is a 
marked improvement over that, despite its memory usage.

Thanks,

	Ingo
