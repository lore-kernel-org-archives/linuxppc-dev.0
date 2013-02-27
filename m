Return-Path: <michael@ellerman.id.au>
Date: Wed, 27 Feb 2013 12:17:25 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/6][v4]: perf: Create a sysfs entry for Power event format
Message-ID: <20130227011725.GA5819@concordia>
References: <20130123062201.GA13720@us.ibm.com>
 <20130123062613.GF13720@us.ibm.com>
 <20130226052646.GB21553@concordia>
 <20130226200343.GA21543@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130226200343.GA21543@us.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 robert.richter@amd.com, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Jiri Olsa <jolsa@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 26, 2013 at 12:03:43PM -0800, Sukadev Bhattiprolu wrote:
> Michael Ellerman [michael@ellerman.id.au] wrote:
> | On Tue, Jan 22, 2013 at 10:26:13PM -0800, Sukadev Bhattiprolu wrote:
> | > 
> | > [PATCH 5/6][v4]: perf: Create a sysfs entry for Power event format
> | > 
> | > Create a sysfs entry, '/sys/bus/event_source/devices/cpu/format/event'
> | > which describes the format of a POWER cpu.
> | 
> | Did this patch go upstream? I don't see it.
> 
> Hmm, patches 1..4,6 are in linux-tip and Arnaldo's trees but patch 5 is
> in neither.

I suspect Arnaldo was either waiting for an ACK from Ben, or was
expecting Ben to take it?

> | > The format of the event is the same for all POWER cpus at least in
> | > (Power6, Power7), so bulk of this change is common in the code common
> | > to POWER cpus.
> | 
> | No. The event format is different on most POWER cpus, in particular it
> | is different on Power6 and Power7, and will be different again on
> | Power8.
> 
> Sigh.  The port of this patchset to Power6 has not started yet.

It should hardly require a port, it's about five lines. But it doesn't
matter for now.
 
> But this patchset does work on Power7 correct ?

Yes, and without it the rest of the series is essentially useless. So I
guess it's better than nothing and we should get it in, we can fix it up
later to work across different chips.

Ben can you grab it, it's all arch/powerpc.

cheers
