Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id E3AE7DDE1B
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 12:34:09 +1100 (EST)
Message-Id: <20081118013212.470074567@goodmis.org>
Date: Mon, 17 Nov 2008 20:32:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] ftrace,
	ppc64: fix race condition pointed out by Milton Miller
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Pekka Paalanen <pq@iki.fi>, miltonm@bga.com,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	Paul Mundt <lethal@linux-sh.org>, Paul Mackerras <paulus@samba.org>,
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


The following patch is in:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git

    branch: tip/ppc


Steven Rostedt (1):
      ftrace,ppc64: do not use nops for modules

----
 arch/powerpc/kernel/ftrace.c |   44 +++++++++++++++++++++++++++++++++++------
 1 files changed, 37 insertions(+), 7 deletions(-)

-- 
