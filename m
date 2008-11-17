Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id A3784DDEDE
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 06:11:34 +1100 (EST)
Message-Id: <20081117190948.619751203@goodmis.org>
Date: Mon, 17 Nov 2008 14:09:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] ftrace: PPC port of dynamic ftrace fixes
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pekka Paalanen <pq@iki.fi>, David Miller <davem@davemloft.net>,
	linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
	Paul Mackerras <paulus@samba.org>,
	Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This series of patches addresses the problems with PPC dynamic ftrace
updates that Paul Mackerras pointed out.

The following patches are in:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git

    branch: tip/ppc


Steven Rostedt (4):
      ftrace,ppc: consolidate dyn ftrace ppc code between 32 and 64 bit
      ftrace,ppc: fix test of 24bit jump
      ftrace,ppc: fix module check in dynamic ftrace code
      ftrace,ppc: fix test of branch link

----
 arch/powerpc/kernel/ftrace.c |  168 +++++++++++++++++++++---------------------
 1 files changed, 83 insertions(+), 85 deletions(-)
