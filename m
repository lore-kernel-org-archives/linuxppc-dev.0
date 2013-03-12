Return-Path: <paulus@ozlabs.org>
Date: Tue, 12 Mar 2013 20:27:40 +1100
From: Paul Mackerras <paulus@samba.org>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/6][v4]: perf: Create a sysfs entry for Power event format
Message-ID: <20130312092740.GC30591@iris.ozlabs.ibm.com>
References: <20130123062201.GA13720@us.ibm.com>
 <20130123062613.GF13720@us.ibm.com>
 <20130226052646.GB21553@concordia>
 <20130226200343.GA21543@us.ibm.com>
 <20130227011725.GA5819@concordia>
 <20130306054826.GA14627@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130306054826.GA14627@us.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 robert.richter@amd.com, Anton Blanchard <anton@au1.ibm.com>,
 linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>,
 linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@redhat.com>,
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

On Tue, Mar 05, 2013 at 09:48:26PM -0800, Sukadev Bhattiprolu wrote:
> Michael Ellerman [michael@ellerman.id.au] wrote:
> | I suspect Arnaldo was either waiting for an ACK from Ben, or was
> | expecting Ben to take it?
> 
> Arnaldo, here is an updated patch. If it is acked by Paul Mackerras,
> Michael Ellerman or Ben, will you add it to your tree so the whole
> patchset comes from one place ?
> 
> Sukadev
> 
> ---
> >From 50c7a46f14083c0ed10d66b7aed66ba76e798550 Mon Sep 17 00:00:00 2001
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Tue, 5 Mar 2013 21:20:56 -0800
> Subject: [PATCH] [PATCH 5/6][v4]: perf Create a sysfs format entry for Power7 events
> 
> Create a sysfs entry, '/sys/bus/event_source/devices/cpu/format/event'
> which describes the format of the POWER7 PMU events.
> 
> This code is based on corresponding code in x86.
> 
> Changelog[v4]:  [Michael Ellerman, Paul Mckerras] The event format is different
> 		for other POWER cpus. So move the code to POWER7-specific,
> 		power7-pmu.c Also, the POWER7 format uses bits 0-19 not 0-20.
> 
> Changelog[v2]: [Jiri Osla] Use PMU_FORMAT_ATTR rather than duplicating code.
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Acked-by: Paul Mackerras <paulus@samba.org>
