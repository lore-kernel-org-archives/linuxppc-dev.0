Return-Path: <andi@firstfloor.org>
Received: from one.firstfloor.org (one.firstfloor.org [193.170.194.197])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 334521A0281
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Feb 2015 07:47:06 +1100 (AEDT)
Date: Mon, 9 Feb 2015 21:40:19 +0100
From: Andi Kleen <andi@firstfloor.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/3] perf/e6500: Make event translations available in sysfs
Message-ID: <20150209204019.GA13991@two.firstfloor.org>
References: <1423262636-12053-1-git-send-email-tom.huynh@freescale.com>
 <1423262636-12053-2-git-send-email-tom.huynh@freescale.com>
 <20150209100242.GM23123@twins.programming.kicks-ass.net>
 <20150209100738.GA5461@gmail.com>
 <20150209121132.GB3952@krava.redhat.com>
 <20150209132557.GA8099@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150209132557.GA8099@gmail.com>
Cc: Tom Huynh <tom.huynh@freescale.com>, Peter Zijlstra <peterz@infradead.org>,
 linuxppc-dev@lists.ozlabs.org, acme@kernel.org, linux-kernel@vger.kernel.org,
 Andi Kleen <andi@firstfloor.org>, paulus@samba.org,
 Jiri Olsa <jolsa@redhat.com>, mingo@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I'll NAK any external 'download area' (and I told that Andi 
> before): tools/perf/event-tables/ or so is a good enough 
> 'download area' with fast enough update cycles.

The proposal was to put it on kernel.org, similar to how
external firmware blobs are distributed. CPU event lists
are data sheets, so are like firmware. They do not
follow the normal kernel code licenses. They are not 
source code. They cannot be reviewed in the normal way.

> If any 'update' of event descriptions is needed it can 
> happen through the distro package mechanism, or via a 
> simple 'git pull' if it's compiled directly.
> 
> Lets not overengineer this with any dependence on an 
> external site and with a separate update mechanism - lets 
> just get the tables into tools/ and see it from there...

That experiment has been already done for oprofile,
didn't work very well.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
