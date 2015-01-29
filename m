Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 19CD01A0C10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 15:24:50 +1100 (AEDT)
Message-ID: <1422505489.6621.5.camel@ellerman.id.au>
Subject: Re: [PATCH v7 0/4] Add support for parametrized events
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jiri Olsa <jolsa@redhat.com>
Date: Thu, 29 Jan 2015 15:24:49 +1100
In-Reply-To: <20150128103753.GA4584@krava.brq.redhat.com>
References: <1422322990-9030-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150127100213.GC7810@krava.brq.redhat.com>
 <1422406478.32234.0.camel@ellerman.id.au>
 <20150128103753.GA4584@krava.brq.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, dev@codyps.com,
 Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-01-28 at 11:37 +0100, Jiri Olsa wrote:
> On Wed, Jan 28, 2015 at 11:54:38AM +1100, Michael Ellerman wrote:
> > On Tue, 2015-01-27 at 11:02 +0100, Jiri Olsa wrote:
> > > On Mon, Jan 26, 2015 at 05:43:03PM -0800, Sukadev Bhattiprolu wrote:
> > > 
> > > SNIP
> > > 
> > > > 
> > > > 
> > > > Cody P Schafer (6):
> > > >   perf: provide sysfs_show for struct perf_pmu_events_attr
> > > >   perf: add PMU_EVENT_ATTR_STRING() helper
> > > >   powerpc/perf/hv-24x7: parse catalog and populate sysfs with events
> > > >   powerpc/perf/{hv-gpci, hv-common}: generate requests with counters
> > > >     annotated
> > > >   powerpc/perf/hv-gpci: add the remaining gpci requests
> > > >   powerpc/perf/hv-24x7: Document sysfs event description entries
> > > > 
> > > > Sukadev Bhattiprolu (1):
> > > >   perf: define EVENT_DEFINE_RANGE_FORMAT_LITE helper
> > > 
> > > generic 'perf: *' patches look good to me.. cant say much about
> > > the rest of the patchset though
> > 
> > Is that an ACK ?
> 
> ah right, sry ;-)
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks. I'll add it to the first two patches.

cheers
