Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-ee0-f42.google.com (mail-ee0-f42.google.com [74.125.83.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8F3DC2C0180
 for <linuxppc-dev@ozlabs.org>; Sun,  9 Dec 2012 01:27:29 +1100 (EST)
Received: by mail-ee0-f42.google.com with SMTP id c41so739062eek.15
 for <linuxppc-dev@ozlabs.org>; Sat, 08 Dec 2012 06:27:26 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 8 Dec 2012 15:27:22 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@infradead.org>
Subject: Re: [GIT PULL 00/32] perf/core improvements and fixes
Message-ID: <20121208142722.GB9022@gmail.com>
References: <1353248997-30763-1-git-send-email-acme@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1353248997-30763-1-git-send-email-acme@infradead.org>
Cc: Feng Tang <feng.tang@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Stephane Eranian <eranian@google.com>, David Howells <dhowells@redhat.com>,
 linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Jiri Olsa <jolsa@redhat.com>, Robert Richter <robert.richter@amd.com>,
 Borislav Petkov <bp@amd64.org>, acme@ghostprotocols.net,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Corey Ashford <cjashfor@linux.vnet.ibm.com>, Namhyung Kim <namhyung@gmail.com>,
 Anton Blanchard <anton@au1.ibm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <efault@gmx.de>,
 linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
 David Ahern <dsahern@gmail.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Note that I had to do a number of conflict resolutions between 
perf/urgent (now upstream) and perf/core, related to UAPI fixes:

 commit f0b9abfb044649bc452fb2fb975ff2fd599cc6a3
 Merge: adc1ef1 1b3c393
 Author: Ingo Molnar <mingo@kernel.org>
 Date:   Sat Dec 8 15:25:06 2012 +0100

    Merge branch 'linus' into perf/core
    
    Conflicts:
        tools/perf/Makefile
        tools/perf/builtin-test.c
        tools/perf/perf.h
        tools/perf/tests/parse-events.c
        tools/perf/util/evsel.h
    
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

I think I managed to resolve them all correctly - but please 
double check the end result nevertheless.

Thanks,

	Ingo
