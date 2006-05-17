Return-Path: <rostedt@goodmis.org>
Received: from ms-smtp-04.nyroc.rr.com (ms-smtp-04.nyroc.rr.com [24.24.2.58])
	by ozlabs.org (Postfix) with ESMTP id 6E6C267BFA
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 20:02:03 +1000 (EST)
Date: Wed, 17 May 2006 06:01:57 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 09/09] robust VM per_cpu i386 Kconfig update
In-Reply-To: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605170601330.8408@gandalf.stny.rr.com>
References: <Pine.LNX.4.58.0605170547490.8408@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>, linux-mips@linux-mips.org,
	David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@vger.kernel.org,
	Martin Mares <mj@atrey.karlin.mff.cuni.cz>, spyro@f2s.com,
	Joe Taylor <joe@tensilica.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, benedict.gaster@superh.com,
	sam@ravnborg.org, bjornw@axis.com, kenneth.w.chen@intel.com,
	Ingo Molnar <mingo@elte.hu>, kiran@scalex86.org,
	clameter@sgi.com, Nick Piggin <nickpiggin@yahoo.com.au>,
	grundler@parisc-linux.org, arnd@arndb.de,
	Rusty Russell <rusty@rustcorp.com.au>, starvik@axis.com,
	Linus Torvalds <torvalds@osdl.org>,
	Thomas Gleixner <tglx@linutronix.de>, rth@twiddle.net,
	Chris Zankel <chris@zankel.net>, tony.luck@intel.com,
	Andi Kleen <ak@suse.de>, ralf@linux-mips.org,
	Marc Gauthier <marc@tensilica.com>, lethal@linux-sh.org,
	schwidefsky@de.ibm.com, linux390@de.ibm.com, davem@davemloft.net,
	parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch forces the CONFIG_HAS_VM_PERCU to be defined for i386.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.16-test/arch/i386/Kconfig
===================================================================
--- linux-2.6.16-test.orig/arch/i386/Kconfig	2006-05-17 04:32:27.000000000 -0400
+++ linux-2.6.16-test/arch/i386/Kconfig	2006-05-17 05:00:10.000000000 -0400
@@ -1116,3 +1116,7 @@ config X86_TRAMPOLINE
 config KTIME_SCALAR
 	bool
 	default y
+
+config HAS_VM_PERCPU
+	bool
+	default y
\ No newline at end of file
