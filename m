Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id B95BE2BF0A
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Nov 2004 02:05:12 +1100 (EST)
Date: Fri, 19 Nov 2004 08:05:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Milton Miller <miltonm@bga.com>
Message-ID: <20041119150510.GA16043@smtp.west.cox.net>
References: <200411151021.iAFAL0ds070897@sullivan.realtime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200411151021.iAFAL0ds070897@sullivan.realtime.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH][PPC] update_process_times simplification
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 15, 2004 at 04:21:00AM -0600, Milton Miller wrote:

> When the update_process_times call was moved out of do_timer for the UP case,
> the replicator didn't track down the hiding and just added ifndef SMP.
> 
> This removes the ifdefs and the indirection of calling another file for
> one function in a third file.
> 
> I also removed the per-cpu multipler and counter.  On some architectures
> (x86 and sparc64) these are set via /proc/profile setup_profiling_timer
> to increase the timer interrupt by a factor over HZ.   However, this was
> not not implemented for ppc (like several other architectures), so it
> was just decrementing, testing, and setting per-cpu variables back to 1.
> 
> Untested.
> Signed-off-by: Milton Miller <miltonm@bga.com>

Since this is untested, and Linus said he wants bugfixes only until
2.6.10 actually comes out, I'd like to hold this until the 2.6.10
release.

-- 
Tom Rini
http://gate.crashing.org/~trini/
