Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wg0-x233.google.com (mail-wg0-x233.google.com
 [IPv6:2a00:1450:400c:c00::233])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3F79D2C0367
 for <linuxppc-dev@ozlabs.org>; Fri, 31 May 2013 21:04:30 +1000 (EST)
Received: by mail-wg0-f51.google.com with SMTP id b13so1086559wgh.18
 for <linuxppc-dev@ozlabs.org>; Fri, 31 May 2013 04:04:26 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 31 May 2013 13:04:21 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@infradead.org>
Subject: Re: [GIT PULL 00/66] perf/core improvements and fixes
Message-ID: <20130531110421.GA32107@gmail.com>
References: <1369929699-8724-1-git-send-email-acme@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369929699-8724-1-git-send-email-acme@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Andi Kleen <andi@firstfloor.org>, Paul Mackerras <paulus@samba.org>,
 Sam Ravnborg <sam@ravnborg.org>, Rabin Vincent <rabin@rab.in>,
 Jiri Olsa <jolsa@redhat.com>,
 Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Corey Ashford <cjashfor@linux.vnet.ibm.com>, Namhyung Kim <namhyung@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Runzhen Wang <runzhen@linux.vnet.ibm.com>,
 William Cohen <wcohen@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org,
 Pekka Enberg <penberg@kernel.org>, Minchan Kim <minchan@kernel.org>,
 David Ahern <dsahern@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Arnaldo Carvalho de Melo <acme@infradead.org> wrote:

> From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
> 
> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> The following changes since commit c0ffaf3655fab1909a920c8f30ba1722932d01bb:
> 
>   watchdog: Remove softlockup_thresh from Documentation (2013-05-28 11:28:20 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux tags/perf-core-for-mingo
> 
> for you to fetch changes up to c3c44709b5095091216c06b8df83feddc01ba6b0:
> 
>   perf tools: Add missing liblk.a dependency for python/perf.so (2013-05-30 17:36:16 +0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes:
> 
> . Reset SIGTERM handler in workload child process, fix from David Ahern.
> 
> . Handle death by SIGTERM in 'perf record', fix from David Ahern.
> 
> . Fix printing of perf_event_paranoid message, from David Ahern.
> 
> . Handle realloc failures in 'perf kvm', from David Ahern.
> 
> . Fix divide by 0 in variance, from David Ahern.
> 
> . Save parent pid in thread struct, from David Ahern.
> 
> . Handle JITed code in shared memory, from Andi Kleen.
> 
> . Makefile reorganization, prep work for Kconfig patches, from Jiri Olsa.
> 
> . Fixes for 'perf diff', from Jiri Olsa.
> 
> . Add automated make test suite, from Jiri Olsa.
> 
> . 'perf tests' fixes from Jiri Olsa.
> 
> . Remove some unused struct members, from Jiri Olsa.
> 
> . Add missing liblk.a dependency for python/perf.so, fix from Jiri Olsa.
> 
> . Respect CROSS_COMPILE in liblk.a, from Rabin Vincent.
> 
> . Expand definition of sysfs format attribute, from Michael Ellerman.
> 
> . No need to do locking when adding hists in perf report, only 'top'
>   needs that, from Namhyung Kim.
> 
> . Sorting improvements, from Namhyung Kim.
> 
> . Fix alignment of symbol column in in the hists browser (top, report)
>   when -v is given, from NAmhyung Kim.
> 
> . Add --percent-limit option to 'top' and 'report', from Namhyung Kim.
> 
> . Fix 'perf top' -E option behavior, from Namhyung Kim.
> 
> . Fix bug in isupper() and islower(), from Sukadev Bhattiprolu.
> 
> . Fix compile errors in bp_signal 'perf test', from Sukadev Bhattiprolu.
> 
> . Make Power7 CPI stack events available in sysfs, from Sukadev Bhattiprolu.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Andi Kleen (1):
>       perf tools: Handle JITed code in shared memory
> 
> Arnaldo Carvalho de Melo (3):
>       perf archive: Fix typo on Documentation
>       perf hists browser: Use sort__has_sym
>       perf test: Fix typo
> 
> David Ahern (6):
>       perf record: handle death by SIGTERM
>       perf evsel: Fix printing of perf_event_paranoid message
>       perf kvm: Handle realloc failures
>       perf stats: Fix divide by 0 in variance
>       perf  tools: Save parent pid in thread struct
>       perf evlist: Reset SIGTERM handler in workload child process
> 
> Jiri Olsa (32):
>       perf tools: Fix tab vs spaces issue in Makefile ifdef/endif
>       perf diff: Use internal rb tree for hists__precompute
>       perf hists: Rename hist_entry__add_pair arguments
>       perf tools: Add automated make test suite
>       perf tools: Move arch check into config/Makefile
>       perf tools: Move programs check into config/Makefile
>       perf tools: Move compiler and linker flags check into config/Makefile
>       perf tools: Move libelf check config into config/Makefile
>       perf tools: Move libdw check config into config/Makefile
>       perf tools: Move libunwind check config into config/Makefile
>       perf tools: Move libaudit check config into config/Makefile
>       perf tools: Move slang check config into config/Makefile
>       perf tools: Move gtk2 check config into config/Makefile
>       perf tools: Move libperl check config into config/Makefile
>       perf tools: Move libpython check config into config/Makefile
>       perf tools: Move libbfd check config into config/Makefile
>       perf tools: Move stdlib check config into config/Makefile
>       perf tools: Move libnuma check config into config/Makefile
>       perf tools: Move paths config into config/Makefile
>       perf tools: Final touches for CHK config move
>       perf tests: Fix attr test for record -d option
>       perf tests: Fix exclude_guest|exclude_host checking for attr tests
>       perf tools: Remove frozen from perf_header struct
>       perf tools: Remove cwdlen from struct perf_session
>       perf tools: Merge all *CFLAGS* make variable into CFLAGS
>       perf tools: Merge all *LDFLAGS* make variable into LDFLAGS
>       perf tools: Switch to full path C include directories
>       perf tools: Add NO_BIONIC variable to confiure bionic setup
>       perf tools: Replace tabs with spaces for all non-commands statements
>       perf tools: Replace multiple line assignment with multiple statements
>       perf tools: Remove '?=' Makefile STRIP assignment
>       perf tools: Add missing liblk.a dependency for python/perf.so
> 
> Michael Ellerman (1):
>       perf: Expand definition of sysfs format attribute
> 
> Namhyung Kim (18):
>       perf hists: Fix an invalid memory free on he->branch_info
>       perf hists: Free unused mem info of a matched hist entry
>       perf report: Fix alignment of symbol column when -v is given
>       perf sort: Introduce sort__mode variable
>       perf sort: Factor out common code in sort_dimension__add()
>       perf sort: Separate out memory-specific sort keys
>       perf sort: Consolidate sort_entry__setup_elide()
>       perf sort: Reorder HISTC_SRCLINE index
>       perf sort: Cleanup sort__has_sym setting
>       perf top: Use sort__has_sym
>       perf top: Fix -E option behavior
>       perf top: Fix percent output when no samples collected
>       perf top: Get rid of *_threaded() functions
>       perf hists: Move locking to its call-sites
>       perf report: Don't bother locking when adding hist entries
>       perf report: Add --percent-limit option
>       perf top: Add --percent-limit option
>       perf report: Add report.percent-limit config variable
> 
> Rabin Vincent (1):
>       tools lib lk: Respect CROSS_COMPILE
> 
> Sukadev Bhattiprolu (4):
>       perf tools: Fix bug in isupper() and islower()
>       perf tests: Fix compile errors in bp_signal files
>       perf: Power7: Make CPI stack events available in sysfs
>       perf: Power7 Update testing ABI to list CPI-stack events
> 
>  .../testing/sysfs-bus-event_source-devices-events  |  32 +-
>  .../testing/sysfs-bus-event_source-devices-format  |   6 +
>  arch/powerpc/perf/power7-pmu.c                     |  73 +++
>  tools/lib/lk/Makefile                              |   3 +
>  tools/perf/Documentation/perf-archive.txt          |   2 +-
>  tools/perf/Documentation/perf-report.txt           |   4 +
>  tools/perf/Documentation/perf-top.txt              |   4 +
>  tools/perf/Makefile                                | 630 ++++-----------------
>  tools/perf/builtin-diff.c                          |  19 +-
>  tools/perf/builtin-kvm.c                           |   3 +
>  tools/perf/builtin-record.c                        |   2 +-
>  tools/perf/builtin-report.c                        | 102 ++--
>  tools/perf/builtin-top.c                           |  74 +--
>  tools/perf/config/Makefile                         | 477 ++++++++++++++++
>  tools/perf/tests/attr/base-record                  |   4 +-
>  tools/perf/tests/attr/base-stat                    |   4 +-
>  tools/perf/tests/attr/test-record-data             |   5 +-
>  tools/perf/tests/bp_signal.c                       |   6 +
>  tools/perf/tests/bp_signal_overflow.c              |   6 +
>  tools/perf/tests/builtin-test.c                    |   2 +-
>  tools/perf/tests/make                              | 138 +++++
>  tools/perf/ui/browsers/hists.c                     | 106 +++-
>  tools/perf/ui/gtk/hists.c                          |  13 +-
>  tools/perf/ui/stdio/hist.c                         |   7 +-
>  tools/perf/util/evlist.c                           |   2 +
>  tools/perf/util/evsel.c                            |   2 +-
>  tools/perf/util/header.c                           |   2 -
>  tools/perf/util/header.h                           |   1 -
>  tools/perf/util/hist.c                             |  96 ++--
>  tools/perf/util/hist.h                             |  16 +-
>  tools/perf/util/map.c                              |   1 +
>  tools/perf/util/session.h                          |   1 -
>  tools/perf/util/setup.py                           |   5 +-
>  tools/perf/util/sort.c                             | 128 +++--
>  tools/perf/util/sort.h                             |  36 +-
>  tools/perf/util/stat.c                             |   2 +-
>  tools/perf/util/thread.c                           |   4 +
>  tools/perf/util/thread.h                           |   1 +
>  tools/perf/util/top.c                              |  23 +-
>  tools/perf/util/top.h                              |   2 +-
>  tools/perf/util/util.h                             |   4 +-
>  41 files changed, 1270 insertions(+), 778 deletions(-)
>  create mode 100644 tools/perf/config/Makefile
>  create mode 100644 tools/perf/tests/make

Pulled, thanks a lot Arnaldo!

I'm wondering, do we need any of the fixes here for perf/urgent and v3.10 
as well?

Thanks,

	Ingo
