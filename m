Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0AA0D1A0415
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Feb 2015 23:12:55 +1100 (AEDT)
Date: Mon, 9 Feb 2015 13:11:32 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/3] perf/e6500: Make event translations available in sysfs
Message-ID: <20150209121132.GB3952@krava.redhat.com>
References: <1423262636-12053-1-git-send-email-tom.huynh@freescale.com>
 <1423262636-12053-2-git-send-email-tom.huynh@freescale.com>
 <20150209100242.GM23123@twins.programming.kicks-ass.net>
 <20150209100738.GA5461@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150209100738.GA5461@gmail.com>
Cc: Tom Huynh <tom.huynh@freescale.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, acme@kernel.org,
 Andi Kleen <andi@firstfloor.org>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, mingo@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 09, 2015 at 11:07:38AM +0100, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, Feb 06, 2015 at 04:43:54PM -0600, Tom Huynh wrote:
> > >  arch/powerpc/perf/e6500-events-list.h         | 289 ++++++++++++++++++++++++++
> > 
> > That's a lot of events to stuff in the kernel, would a 
> > userspace list not be more convenient?
> > 
> > ISTR there being various discussions on providing support 
> > for that in tools/perf, Jiri?
> 
> As long as it's in a single well organized place in tools/, 
> I'd be fine with that solution as well.
> 
> What doesn't work very well is disjunct, disorganized, 
> inconsistent event descriptions all across the tooling and 
> platform landscape - putting static tables into sysfs is a 
> marked improvement over that, despite its memory usage.

the last version is in here:
http://marc.info/?l=linux-kernel&m=140676269017820&w=2

AFAIK Andi is setting up the download area as discussed
in the thread and should repost at some point

jirka
