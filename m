Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19177.352.47019.4942@drongo.ozlabs.ibm.com>
Date: Thu, 29 Oct 2009 13:43:44 +1100
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [GIT PULL] perf_event/tracing/powerpc patches from Anton Blanchard
In-Reply-To: <1256780668.26770.15.camel@pasglop>
References: <19176.59441.523075.445864@drongo.ozlabs.ibm.com>
	<1256780668.26770.15.camel@pasglop>
Cc: Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:

> On Thu, 2009-10-29 at 11:56 +1100, Paul Mackerras wrote:
> > Here is a series of patches from Anton Blanchard that implement some
> > nice tracing and perf_event features on powerpc.  One of them is
> > generic perf_event stuff (adding software events for alignment faults
> > and instruction emulation faults).
> > 
> > Since this touches the perf_event and tracing subsystems as well as the
> > powerpc architecture code, I think the best way forward is for both
> > Ingo and Ben to pull it into their trees.  I have based it on the most
> > recent point in Linus' tree that Ingo had pulled into his perf
> > branches (as of yesterday or so).
> 
> This is -next material right ?

Yes, please pull it into your next branch.

Thanks,
Paul.
