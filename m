Return-Path: <andi@firstfloor.org>
Received: from one.firstfloor.org (one.firstfloor.org [193.170.194.197])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B9A211A0279
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2015 11:42:06 +1100 (AEDT)
Date: Sat, 28 Mar 2015 01:32:18 +0100
From: Andi Kleen <andi@firstfloor.org>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 1/3] perf/e6500: Make event translations available in sysfs
Message-ID: <20150328003217.GB2366@two.firstfloor.org>
References: <1423262636-12053-1-git-send-email-tom.huynh@freescale.com>
 <1423262636-12053-2-git-send-email-tom.huynh@freescale.com>
 <20150209100242.GM23123@twins.programming.kicks-ass.net>
 <20150209100738.GA5461@gmail.com>
 <20150209121132.GB3952@krava.redhat.com>
 <20150209132557.GA8099@gmail.com>
 <20150209204019.GA13991@two.firstfloor.org>
 <20150216161045.GA32564@rivendell>
 <20150327163424.92d22b2e685a1f0bc4a7c651@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150327163424.92d22b2e685a1f0bc4a7c651@freescale.com>
Cc: Tom Huynh <tom.huynh@freescale.com>, mingo@redhat.com,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 Tom Huynh <tommy.xhuynh@gmail.com>, acme@kernel.org,
 linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>,
 paulus@samba.org, Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Thanks for supporting the JSON format too.

> (c) If not, given we don't know how to get us out of the current
> status quo, can this patchseries still be applied, given the
> original complaint was the size of our events-list.h (whereas

The Intel core event lists are far larger even
(and will grow even more when uncore gets added)

> power7-events-list.h is almost twice the size)?  If not, patch 3/3
> in this series is still valid, no matter what, and it should still
> be applied (let us know if we need to resubmit).

Could also just leave out the downloader for now, so that you have
to get your own event file and set it up with export EVENTMAP=...

That's basically the patchkit, minus one patch.

-Andi
