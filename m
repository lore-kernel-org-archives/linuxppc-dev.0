Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id 3C512DDEF1
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 14:14:39 +1000 (EST)
Message-Id: <20080515034942.109223655@goodmis.org>
Date: Wed, 14 May 2008 23:49:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH 0/2] ftrace ported to PPC
Cc: proski@gnu.org, a.p.zijlstra@chello.nl, pq@iki.fi,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sandmann@redhat.com, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The following two patches ports ftrace to PowerPC. I tested this on
both my PPC64 box as well as my 32bit PowerBook G4.

This applies to the latest sched-devel (with some extra hacks to get that
to boot on PPC).

This also depends on the CFLAGS_REMOVE_foo.o patches I sent earlier.

-- Steve
