Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B1251A0C4B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 21:38:30 +1100 (AEDT)
Date: Wed, 28 Jan 2015 11:37:53 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v7 0/4] Add support for parametrized events
Message-ID: <20150128103753.GA4584@krava.brq.redhat.com>
References: <1422322990-9030-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150127100213.GC7810@krava.brq.redhat.com>
 <1422406478.32234.0.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422406478.32234.0.camel@ellerman.id.au>
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

On Wed, Jan 28, 2015 at 11:54:38AM +1100, Michael Ellerman wrote:
> On Tue, 2015-01-27 at 11:02 +0100, Jiri Olsa wrote:
> > On Mon, Jan 26, 2015 at 05:43:03PM -0800, Sukadev Bhattiprolu wrote:
> > 
> > SNIP
> > 
> > > 
> > > 
> > > Cody P Schafer (6):
> > >   perf: provide sysfs_show for struct perf_pmu_events_attr
> > >   perf: add PMU_EVENT_ATTR_STRING() helper
> > >   powerpc/perf/hv-24x7: parse catalog and populate sysfs with events
> > >   powerpc/perf/{hv-gpci, hv-common}: generate requests with counters
> > >     annotated
> > >   powerpc/perf/hv-gpci: add the remaining gpci requests
> > >   powerpc/perf/hv-24x7: Document sysfs event description entries
> > > 
> > > Sukadev Bhattiprolu (1):
> > >   perf: define EVENT_DEFINE_RANGE_FORMAT_LITE helper
> > 
> > generic 'perf: *' patches look good to me.. cant say much about
> > the rest of the patchset though
> 
> Is that an ACK ?

ah right, sry ;-)

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> 
> I'm happy to merge the rest through the powerpc tree, but I'd like an ACK on
> the first two from someone in perf land.
> 
> cheers
> 
> 
