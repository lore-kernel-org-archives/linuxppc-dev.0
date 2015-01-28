Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 59B301A0BF2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jan 2015 01:55:35 +1100 (AEDT)
Date: Wed, 28 Jan 2015 11:55:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL 00/26] perf/core improvements and fixes
Message-ID: <20150128145536.GJ7220@kernel.org>
References: <1422294449-12735-1-git-send-email-acme@kernel.org>
 <20150128145015.GB6559@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150128145015.GB6559@gmail.com>
Cc: Richard Fowles <rfowles@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Stephane Eranian <eranian@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Paul Mackerras <paulus@samba.org>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Jiri Olsa <jolsa@redhat.com>,
 Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>,
 Borislav Petkov <bp@suse.de>, Don Zickus <dzickus@redhat.com>,
 Ramkumar Ramachandra <artagnon@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Joe Mario <jmario@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Kan Liang <kan.liang@intel.com>, Mike Galbraith <efault@gmx.de>,
 linux-kernel@vger.kernel.org, David Ahern <dsahern@gmail.com>,
 Cody P Schafer <cody@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Wed, Jan 28, 2015 at 03:50:15PM +0100, Ingo Molnar escreveu:
> Pulled, thanks a lot Arnaldo!

Thanks!
 
> Note that there was some minimal interaction with Frederic's 
> pending perf/hw_breakpoint work, in tools/perf/Documentation/perf-record.txt.
> 
> I resolved the conflict and merged perf/hw_breakpoint into 
> perf/core as well, to avoid future complications. (Once I've 
> pushed it all out you guys might want to double check what I did 
> there though, just to make sure.)

As soon as 'git remote update tip' gets this stuff, I'll check it!

- Arnaldo
