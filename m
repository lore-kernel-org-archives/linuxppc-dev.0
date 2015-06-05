Return-Path: <ak@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by lists.ozlabs.org (Postfix) with ESMTP id 1C9E31A08B0
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jun 2015 02:19:28 +1000 (AEST)
Date: Fri, 5 Jun 2015 09:19:26 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, mingo@redhat.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 15/19] perf, tools: Support long descriptions with
 perf list
Message-ID: <20150605161926.GU1187@tassilo.jf.intel.com>
References: <1433485647-9314-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1433485647-9314-16-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150605102138.GB29934@krava.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150605102138.GB29934@krava.redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 05, 2015 at 12:21:38PM +0200, Jiri Olsa wrote:
> On Thu, Jun 04, 2015 at 11:27:23PM -0700, Sukadev Bhattiprolu wrote:
> 
> SNIP
> 
> > ---
> >  tools/perf/builtin-list.c |   11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> > index 3f058f7..d0f7a18 100644
> > --- a/tools/perf/builtin-list.c
> > +++ b/tools/perf/builtin-list.c
> > @@ -22,10 +22,13 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
> >  {
> >  	int i;
> >  	bool raw_dump = false;
> > +	bool long_desc_flag = false;
> >  	struct option list_options[] = {
> >  		OPT_BOOLEAN(0, "raw-dump", &raw_dump, "Dump raw events"),
> >  		OPT_BOOLEAN('d', "desc", &desc_flag,
> >  			    "Print extra event descriptions. --no-desc to not print."),
> > +		OPT_BOOLEAN('d', "long-desc", &long_desc_flag,
> > +			    "Print longer event descriptions."),
> 
> hum, it should be 'v' , right?

Yes that's right.

Also BTW need to add the new option to the usage line a few lines below.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
