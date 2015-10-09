Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AA48D1A0567
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Oct 2015 04:44:21 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 9 Oct 2015 11:44:19 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 805E619D8051
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 11:32:28 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t99HgxGd45088776
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2015 10:42:59 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t99HiFfM018231
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Oct 2015 11:44:16 -0600
Date: Fri, 9 Oct 2015 10:44:18 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>, Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Message-ID: <20151009174418.GW3910@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008125937.GH16807@arm.com>
 <20151008221716.GF3910@linux.vnet.ibm.com>
 <20151009095129.GF26278@arm.com>
 <20151009112554.GB3816@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151009112554.GB3816@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 09, 2015 at 01:25:54PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 09, 2015 at 10:51:29AM +0100, Will Deacon wrote:
> > > The corresponding litmus tests are below.
> > 
> > How do people feel about including these in memory-barriers.txt? I find
> > them considerably easier to read than our current kernel code + list of
> > possible orderings + wall of text, but there's a good chance that my
> > brain has been corrupted from staring at this stuff for too long.
> 
> Your brain is corrupt (but then, so probably is mine, just differently
> so).
> 
> I've not yet mastered the knack of reading those things; then again, I
> suspect its not too hard, just not something I've had the time to play
> with.

It does take a bit of practice, but is worth the effort.  Of course,
I -would- say that.  ;-)

							Thanx, Paul
