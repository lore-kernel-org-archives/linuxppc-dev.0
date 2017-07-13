Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7T4Q0t00zDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 18:09:26 +1000 (AEST)
Date: Thu, 13 Jul 2017 10:09:19 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Andi Kleen <andi@firstfloor.org>, ak@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mikey@neuling.org, mpetlan@redhat.com
Subject: Re: [GIT PULL] Please pull JSON files for Power9 PMU events
Message-ID: <20170713080919.GA6531@krava>
References: <20170712020827.GB31223@us.ibm.com>
 <87a849luvr.fsf@concordia.ellerman.id.au>
 <20170712144611.GN27350@kernel.org>
 <20170712164008.GC31223@us.ibm.com>
 <87y3rtj91u.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87y3rtj91u.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 13, 2017 at 01:43:41PM +1000, Michael Ellerman wrote:
> Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
> ...
> >
> >  tools/perf/pmu-events/arch/powerpc/mapfile.csv     |   3 +
> >  .../perf/pmu-events/arch/powerpc/power9/cache.json | 176 +++++
> >  .../arch/powerpc/power9/floating-point.json        |  44 ++
> >  .../pmu-events/arch/powerpc/power9/frontend.json   | 446 +++++++++++
> >  .../pmu-events/arch/powerpc/power9/marked.json     | 782 +++++++++++++++++++
> >  .../pmu-events/arch/powerpc/power9/memory.json     | 158 ++++
> 
> In the map file we have "power9.json", but the files are power9/x.json.
> How does that work?

hum, we take just the base name from that string and use it
as a map to the directory/struct with events.. so no harm done

I guess it's the leftover from when we switched from single file
to per topic event files.. x86 arch seems to have it right

I'll send the fix

thanks,
jirka
