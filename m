Return-Path: <acme@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWNVq4swQzDqwJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 03:52:51 +1000 (AEST)
Date: Mon, 14 Aug 2017 14:52:30 -0300
From: Arnaldo Carvalho de Melo <acme@redhat.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Kim Phillips <kim.phillips@arm.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 Andi Kleen <ak@linux.intel.com>, Anton Blanchard <anton@au1.ibm.com>,
 David Ahern <dsahern@gmail.com>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
 Jiri Olsa <jolsa@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Matt Fleming <matt.fleming@intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Petlan <mpetlan@redhat.com>,
 Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Paul Clarke <pc@us.ibm.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>,
 Wang Nan <wangnan0@huawei.com>, Yao Jin <yao.jin@linux.intel.com>,
 Zvonko Kosic <zvonko.kosic@de.ibm.com>, acme@kernel.org
Subject: Re: [GIT PULL 00/19] perf/core improvements and fixes
Message-ID: <20170814175230.GC2327@redhat.com>
References: <20170814162741.6101-1-acme@kernel.org>
 <20170814173948.pio6tbbkmqwrksmn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170814173948.pio6tbbkmqwrksmn@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Mon, Aug 14, 2017 at 07:39:48PM +0200, Ingo Molnar escreveu:
> * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > Infrastructure:

> > - Add support for shell based tests in 'perf test', add a few that
> >   run 'perf probe', 'perf trace', using kprobes, uprobes to check
> >   the output of those tools and the effects on the system, checking,
> >   for instance, DWARF backtraces from uprobes (Arnaldo Carvalho de Melo)
<SNIP>
> >  create mode 100644 tools/perf/tests/shell/lib/probe_vfs_getname.sh
> >  create mode 100755 tools/perf/tests/shell/probe_vfs_getname.sh
> >  create mode 100755 tools/perf/tests/shell/record+script_probe_vfs_getname.sh
> >  create mode 100755 tools/perf/tests/shell/trace+probe_libc_inet_pton.sh
> >  create mode 100755 tools/perf/tests/shell/trace+probe_vfs_getname.sh
> 
> Pulled, thanks a lot Arnaldo!

Thanks! I'm working with Kim Phillips to fix some issues he noticed
while testing on his ARM systems where 'perf probe' is not available, my
perf/core branch has several fixes to handle this that will be in my
next pull request.

- Arnaldo
