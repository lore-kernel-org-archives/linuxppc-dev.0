Return-Path: <mpe@ellerman.id.au>
Message-ID: <1393982366.13402.0.camel@concordia>
Subject: Re: [PATCH v3 03/11] perf: provide a common perf_event_nop_0() for
 use with .event_idx
From: Michael Ellerman <mpe@ellerman.id.au>
To: Cody P Schafer <cody@linux.vnet.ibm.com>
Date: Wed, 05 Mar 2014 12:19:26 +1100
In-Reply-To: <53157A45.4080600@linux.vnet.ibm.com>
References: <20140304051936.97CBF2C020A@ozlabs.org>
 <53157A45.4080600@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>, scottwood@freescale.com,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-03-03 at 23:01 -0800, Cody P Schafer wrote:
> On 03/03/2014 09:19 PM, Michael Ellerman wrote:
> > On Thu, 2014-27-02 at 21:04:56 UTC, Cody P Schafer wrote:
> >> Rather an having every pmu that needs a function that just returns 0 for
> >> .event_idx define their own copy, reuse the one in kernel/events/core.c.
> >>
> >> Rename from perf_swevent_event_idx() because we're no longer using it
> >> for just software events. Naming is based on the perf_pmu_nop_*()
> >> functions.
> >
> > You could just use perf_pmu_nop_int() directly.
> 
> No, .event_idx needs something that takes a (struct perf_event *), 
> perf_pmu_nop_int() takes a (struct pmu *).

Yeah, duh.

cheers
