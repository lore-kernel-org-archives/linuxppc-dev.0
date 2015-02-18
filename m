Return-Path: <andi@firstfloor.org>
Received: from one.firstfloor.org (one.firstfloor.org [193.170.194.197])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9354B1A01A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 08:31:40 +1100 (AEDT)
Date: Wed, 18 Feb 2015 22:31:34 +0100
From: Andi Kleen <andi@firstfloor.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/3] perf/e6500: Make event translations available in sysfs
Message-ID: <20150218213134.GA823@two.firstfloor.org>
References: <1423262636-12053-1-git-send-email-tom.huynh@freescale.com>
 <1423262636-12053-2-git-send-email-tom.huynh@freescale.com>
 <20150209100242.GM23123@twins.programming.kicks-ass.net>
 <20150209100738.GA5461@gmail.com>
 <20150209121132.GB3952@krava.redhat.com>
 <20150209132557.GA8099@gmail.com>
 <20150209204019.GA13991@two.firstfloor.org>
 <1423613998.2713.16.camel@aoeu.buserror.net>
 <20150218205603.GA21074@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150218205603.GA21074@gmail.com>
Cc: Tom Huynh <tom.huynh@freescale.com>, Peter Zijlstra <peterz@infradead.org>,
 Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org, acme@kernel.org,
 Andi Kleen <andi@firstfloor.org>, paulus@samba.org,
 Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 mingo@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Well I'm tired of discussing this. I don't think what you
proposed makes sense, putting 3.4MB[1] of changing blob into perf.

I'll resubmit the JSON parser without the downloader. Then users
have the option to get their own events and use that.

If you don't like that, standard perf just has to stay with limited 
events and rXXXX as before, with users having to use external
tools or libraries for names for more events[2][3].

-Andi

[1] Current size of https://download.01.org/perfmon/
[2] ocperf in https://github.com/andikleen/pmu-tools
[3] http://perfmon2.sourceforge.net/
-- 
ak@linux.intel.com -- Speaking for myself only.
