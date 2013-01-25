Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-ee0-f48.google.com (mail-ee0-f48.google.com [74.125.83.48])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4F4872C008E
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2013 21:36:31 +1100 (EST)
Received: by mail-ee0-f48.google.com with SMTP id t10so115430eei.21
 for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2013 02:36:28 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 25 Jan 2013 11:36:23 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@infradead.org>
Subject: Re: [GIT PULL 00/74] perf/core improvements and fixes
Message-ID: <20130125103623.GA20826@gmail.com>
References: <1359058103-31645-1-git-send-email-acme@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359058103-31645-1-git-send-email-acme@infradead.org>
Cc: Feng Tang <feng.tang@intel.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <fweisbec@gmail.com>, Al Cooper <alcooperx@gmail.com>,
 "H.C. Lee" <hyc.lee@gmail.com>, linuxppc-dev@ozlabs.org,
 Jon Stanley <jonstanley@gmail.com>, Andi Kleen <andi@firstfloor.org>,
 Paul Mackerras <paulus@samba.org>,
 Frederik Deweerdt <frederik.deweerdt@xprog.eu>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Jiri Olsa <jolsa@redhat.com>, Thomas Jarosch <thomas.jarosch@intra2net.com>,
 Namhyung Kim <namhyung.kim@lge.com>, Ulrich Drepper <drepper@gmail.com>,
 Hitoshi Mitake <h.mitake@gmail.com>, Joshua Zhu <zhu.wen-jie@hp.com>,
 Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>,
 Akihiro Nagai <akihiro.nagai.hw@hitachi.com>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Sasha Levin <sasha.levin@oracle.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Stefan Beller <stefanbeller@googlemail.com>,
 Corey Ashford <cjashfor@linux.vnet.ibm.com>, Namhyung Kim <namhyung@gmail.com>,
 Anton Blanchard <anton@au1.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Stephane Eranian <eranian@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Tom Zanussi <tom.zanussi@linux.intel.com>,
 Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
 Vince Weaver <vincent.weaver@maine.edu>, Mike Galbraith <efault@gmx.de>,
 linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
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

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> The following changes since commit 203e04c16330c880538588e932743f404ee4fd66:
> 
>   Merge tag 'perf-core-for-mingo' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2013-01-24 16:30:45 +0100)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux tags/perf-core-for-mingo
> 
> for you to fetch changes up to 2ae828786c65ab8f587647bd0f22f8fe00f1f238:
> 
>   perf test: Allow skipping tests (2013-01-24 16:40:53 -0300)
> 
> ----------------------------------------------------------------
> perf/core improvements and fixes
> 
> . Allow skipping problematic entries in 'perf test'.
> 
> . Fix some namespace problems in the event parsing routines.
> 
> . Add 'perf test' entry to make sure the python binding doesn't have
>   linking problems.
> 
> . Adjust 'perf test' attr tests verbosity levels.
> 
> . Make tools/perf build with GNU make v3.80, fix from Al Cooper.
> 
> . Do missing feature fallbacks in just one place, removing duplicated
>   code in multiple tools.
> 
> . Fix some memory leaks, from David Ahern.
> 
> . Fix segfault when drawing out-of-bounds jumps, from Frederik Deweerdt.
> 
> . Allow of casting an array of char to string in 'perf probe', from
>   Hyeoncheol Lee.
> 
> . Add support for wildcard in tracepoint system name, from Jiri Olsa.
> 
> . Update FSF postal address to be URL's, from Jon Stanley.
> 
> . Add anonymous huge page recognition, from Joshua Zhu.
> 
> . Remove some needless feature test checks, from Namhyung Kim.
> 
> . Multiple improvements to the sort routines, from Namhyung Kim.
> 
> . Fix warning on '>=' operator in libtraceevent, from Namhyung Kim.
> 
> . Use ARRAY_SIZE instead of reinventing it in 'perf script' and 'perf kmem',
>   from Sasha Levin.
> 
> . Remove some redundant checks, from Sasha Levin.
> 
> . Test correct variable after allocation in libtraceevent, fix from Sasha Levin.
> 
> . Mark branch_info maps as referenced, fix from Stephane Eranian.
> 
> . Fix PMU format parsing test failure, from Sukadev Bhattiprolu.
> 
> . Fix possible (unlikely) buffer overflow, from Thomas Jarosch.
> 
> . Multiple 'perf script' fixes, from Tom Zanussi.
> 
> . Add missing field in PERF_RECORD_SAMPLE documentation, from Vince Weaver.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Al Cooper (1):
>       perf tools: Fix GNU make v3.80 compatibility issue
> 
> Arnaldo Carvalho de Melo (24):
>       perf test: Remove leftover temp file left by one of the attr tests
>       perf tests: Adjust some message log levels to help diagnosing problems in attr tests
>       perf evsel: Do missing feature fallbacks in just one place
>       perf evsel: Introduce event fallback method
>       perf evsel: Introduce perf_evsel__open_strerror method
>       perf test: Check for linking problems in the python binding
>       perf python: Fix breakage introduced by the test_attr infrastructure
>       perf record: Don't pass host machine to guest synthesizer
>       perf hists: Rename hists__fprintf_nr_events to events_stats__fprintf
>       perf session: There is no need for a per session hists instance
>       perf machine: Introduce struct machines
>       perf machine: Simplify accessing the host machine
>       perf kvm: Initialize file_name var to fix segfault
>       perf tests: Don't fail if a matching vmlinux isn't found, skip that test
>       perf tools: Fix usage of __ in parse_events_term struct
>       perf pmu: Fix usage of __ in struct names
>       perf ui browsers: Fix usage of __ in struct names
>       perf tools: Fix usage of __ in event parsing struct names
>       perf tests: Use ARRAY_SIZE() were applicable
>       perf pmu: Privatize perf_pmu_{format,alias} structs
>       perf tools: Remove some needless die() calls from the main routine
>       perf tools: Allow passing NULL to intlist__find
>       perf tools: Allow passing a list to intlist__new
>       perf test: Allow skipping tests
> 
> David Ahern (3):
>       perf symbols: Move name malloc to when needed in dso__load
>       perf symbols: Mark vmlinux filename as allocated
>       perf tools: Move get_term_dimensions from top to util.c
> 
> Frederik Deweerdt (1):
>       perf annotate browser: Fix segfault when drawing out-of-bounds jumps
> 
> Hyeoncheol Lee (1):
>       perf probe: Allow of casting an array of char to string
> 
> Jiri Olsa (6):
>       perf tools: Add missing closedir in multi tracepoint processing
>       perf tools: Add support for wildcard in tracepoint system name
>       perf tests: Add event parsing test for '*:*' tracepoints
>       perf tests: Fix PYTHONPATH for python-use test tracepoints
>       perf tests: Add return states enum for tests
>       perf tools: Remove unused 'unset' parameter from parse_events
> 
> Jon Stanley (2):
>       tools lib traceevent: Update FSF postal address to be URL's.
>       tools lib traceevent: Add copyright header
> 
> Joshua Zhu (1):
>       perf tools: Add anonymous huge page recognition
> 
> Namhyung Kim (22):
>       perf hists: Exchange order of comparing items when collapsing hists
>       perf hists: Link hist entries before inserting to an output tree
>       perf diff: Use internal rb tree for compute resort
>       perf test: Add a test case for hists__{match,link}
>       perf tests: Check python path on attr and binding test
>       perf header: Ensure read/write finished successfully
>       perf ui/gtk: Factor out common browser routines
>       perf ui/gtk: Setup browser window early
>       perf symbols: Include elf.h header regardless LIBELF_SUPPORT
>       perf bench: Flush stdout before starting bench suite
>       perf sort: Move misplaced sort entry functions
>       perf sort: Get rid of unnecessary __maybe_unused
>       perf sort: Fix --sort pid output
>       perf sort: Align cpu column to right
>       perf sort: Calculate parent column width too
>       perf sort: Clean up sort__first_dimension setting
>       perf sort: Separate out branch stack specific sort keys
>       perf report: Update documentation for sort keys
>       tools lib traceevent: Fix warning on '>=' operator
>       perf tools: Get rid of unused include of config.mak
>       perf tools: Do not include PERF-VERSION-FILE to Makefile
>       perf tools: Move ltrim() to util/string.c
> 
> Sasha Levin (5):
>       perf tools: remove redundant checks from _sort__sym_cmp
>       perf kmem: use ARRAY_SIZE instead of reinventing it
>       perf script: use ARRAY_SIZE instead of reinventing it
>       uprobes: remove redundant check
>       tools lib traceevent: test correct variable after allocation
> 
> Stephane Eranian (1):
>       perf tools: Mark branch_info maps as referenced
> 
> Sukadev Bhattiprolu (1):
>       perf tools: Fix PMU format parsing test failure
> 
> Thomas Jarosch (1):
>       perf tools: Fix possible (unlikely) buffer overflow
> 
> Tom Zanussi (4):
>       perf tools: Reinstate 'signed' field flag for tracepoints
>       perf script: Don't display trace info when invoking scripts
>       perf script: hook up perf_scripting_context->pevent
>       perf script: Remove workqueue-stats script
> 
> Vince Weaver (1):
>       perf: Missing field in PERF_RECORD_SAMPLE documentation
> 
>  include/uapi/linux/perf_event.h                    |   3 +-
>  kernel/events/uprobes.c                            |   3 +-
>  tools/lib/traceevent/event-parse.c                 |  10 +-
>  tools/lib/traceevent/event-parse.h                 |   3 +-
>  tools/lib/traceevent/event-utils.h                 |   3 +-
>  tools/lib/traceevent/parse-filter.c                |   3 +-
>  tools/lib/traceevent/parse-utils.c                 |  19 +
>  tools/lib/traceevent/trace-seq.c                   |   3 +-
>  tools/perf/Documentation/perf-report.txt           |  38 +-
>  tools/perf/Documentation/perf-script-python.txt    |   2 -
>  tools/perf/Documentation/perf-test.txt             |   4 +
>  tools/perf/Makefile                                |  17 +-
>  tools/perf/builtin-bench.c                         |   2 +
>  tools/perf/builtin-diff.c                          |  92 ++--
>  tools/perf/builtin-kmem.c                          |  10 +-
>  tools/perf/builtin-kvm.c                           |   3 +-
>  tools/perf/builtin-record.c                        | 127 +-----
>  tools/perf/builtin-report.c                        |   6 +-
>  tools/perf/builtin-sched.c                         |   6 +-
>  tools/perf/builtin-script.c                        |  17 +-
>  tools/perf/builtin-stat.c                          |  46 +-
>  tools/perf/builtin-top.c                           | 106 +----
>  tools/perf/config/utilities.mak                    |   6 +-
>  tools/perf/perf.c                                  |  32 +-
>  tools/perf/perf.h                                  |   6 -
>  tools/perf/scripts/perl/bin/workqueue-stats-record |   2 -
>  tools/perf/scripts/perl/bin/workqueue-stats-report |   3 -
>  tools/perf/scripts/perl/workqueue-stats.pl         | 129 ------
>  tools/perf/tests/attr.c                            |   4 +-
>  tools/perf/tests/attr.py                           |  27 +-
>  tools/perf/tests/attr/test-record-group1           |   2 +-
>  tools/perf/tests/builtin-test.c                    |  40 +-
>  tools/perf/tests/evsel-roundtrip-name.c            |   4 +-
>  tools/perf/tests/hists_link.c                      | 499 +++++++++++++++++++++
>  tools/perf/tests/parse-events.c                    |  98 +++-
>  tools/perf/tests/pmu.c                             |  11 +-
>  tools/perf/tests/python-use.c                      |  23 +
>  tools/perf/tests/tests.h                           |   8 +
>  tools/perf/tests/vmlinux-kallsyms.c                |   3 +-
>  tools/perf/ui/browser.c                            |   4 +-
>  tools/perf/ui/browsers/annotate.c                  |  33 +-
>  tools/perf/ui/gtk/browser.c                        | 227 +---------
>  tools/perf/ui/gtk/gtk.h                            |   9 +-
>  tools/perf/ui/gtk/hists.c                          | 226 ++++++++++
>  tools/perf/ui/stdio/hist.c                         |   6 +-
>  tools/perf/ui/util.c                               |  11 -
>  tools/perf/util/PERF-VERSION-GEN                   |   4 +-
>  tools/perf/util/debug.h                            |   1 -
>  tools/perf/util/evsel.c                            | 108 ++++-
>  tools/perf/util/evsel.h                            |   6 +
>  tools/perf/util/header.c                           |  75 ++--
>  tools/perf/util/hist.c                             |  79 +++-
>  tools/perf/util/hist.h                             |   4 +-
>  tools/perf/util/include/linux/bitops.h             |   1 +
>  tools/perf/util/intlist.c                          |  36 +-
>  tools/perf/util/intlist.h                          |   2 +-
>  tools/perf/util/machine.c                          |  64 ++-
>  tools/perf/util/machine.h                          |  32 +-
>  tools/perf/util/map.c                              |   3 +-
>  tools/perf/util/parse-events.c                     |  87 +++-
>  tools/perf/util/parse-events.h                     |  21 +-
>  tools/perf/util/parse-events.y                     |  64 +--
>  tools/perf/util/pmu.c                              |  46 +-
>  tools/perf/util/pmu.h                              |  15 +-
>  tools/perf/util/probe-finder.c                     |  10 +-
>  tools/perf/util/python.c                           |   9 +
>  .../perf/util/scripting-engines/trace-event-perl.c |   1 +
>  .../util/scripting-engines/trace-event-python.c    |   1 +
>  tools/perf/util/session.c                          |  75 ++--
>  tools/perf/util/session.h                          |  30 +-
>  tools/perf/util/sort.c                             | 230 +++++-----
>  tools/perf/util/sort.h                             |   8 +-
>  tools/perf/util/string.c                           |  18 +
>  tools/perf/util/symbol-elf.c                       |   3 -
>  tools/perf/util/symbol-minimal.c                   |   1 -
>  tools/perf/util/symbol.c                           |  14 +-
>  tools/perf/util/symbol.h                           |   2 +-
>  tools/perf/util/sysfs.c                            |   2 +-
>  tools/perf/util/top.h                              |   2 -
>  tools/perf/util/util.c                             |  24 +
>  tools/perf/util/util.h                             |   4 +
>  81 files changed, 1816 insertions(+), 1202 deletions(-)
>  delete mode 100644 tools/perf/scripts/perl/bin/workqueue-stats-record
>  delete mode 100644 tools/perf/scripts/perl/bin/workqueue-stats-report
>  delete mode 100644 tools/perf/scripts/perl/workqueue-stats.pl
>  create mode 100644 tools/perf/tests/hists_link.c
>  create mode 100644 tools/perf/tests/python-use.c
>  create mode 100644 tools/perf/ui/gtk/hists.c

Pulled, thanks a lot Arnaldo!

	Ingo
