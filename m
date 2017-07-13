Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7WKC1fSJzDqkt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 19:50:39 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Andi Kleen <andi@firstfloor.org>, ak@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, mikey@neuling.org,
 mpetlan@redhat.com
Subject: Re: [GIT PULL] Please pull JSON files for Power9 PMU events
In-Reply-To: <20170713080919.GA6531@krava>
References: <20170712020827.GB31223@us.ibm.com>
 <87a849luvr.fsf@concordia.ellerman.id.au> <20170712144611.GN27350@kernel.org>
 <20170712164008.GC31223@us.ibm.com> <87y3rtj91u.fsf@concordia.ellerman.id.au>
 <20170713080919.GA6531@krava>
Date: Thu, 13 Jul 2017 19:50:37 +1000
Message-ID: <87vamwk6mq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jiri Olsa <jolsa@redhat.com> writes:

> On Thu, Jul 13, 2017 at 01:43:41PM +1000, Michael Ellerman wrote:
>> Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
>> ...
>> >
>> >  tools/perf/pmu-events/arch/powerpc/mapfile.csv     |   3 +
>> >  .../perf/pmu-events/arch/powerpc/power9/cache.json | 176 +++++
>> >  .../arch/powerpc/power9/floating-point.json        |  44 ++
>> >  .../pmu-events/arch/powerpc/power9/frontend.json   | 446 +++++++++++
>> >  .../pmu-events/arch/powerpc/power9/marked.json     | 782 +++++++++++++++++++
>> >  .../pmu-events/arch/powerpc/power9/memory.json     | 158 ++++
>> 
>> In the map file we have "power9.json", but the files are power9/x.json.
>> How does that work?
>
> hum, we take just the base name from that string and use it
> as a map to the directory/struct with events.. so no harm done

I figured it must be working somehow but it's a bit odd :)

> I guess it's the leftover from when we switched from single file
> to per topic event files.. x86 arch seems to have it right

Yep.

> I'll send the fix

Thanks.

cheers
