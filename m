Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 122DBDDFAC
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 02:01:48 +1100 (EST)
Message-Id: <20090213150055.947823726@goodmis.org>
Date: Fri, 13 Feb 2009 10:00:55 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] [git-pull] powerpc, ftrace clean ups 
Cc: Paul Mackerras <paulus@samba.org>, Frederic Weisbecker <fweisbec@gmail.com>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Benjamin,

Please pull the latest ppc/ftrace tree, which can be found at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git
ppc/ftrace


Steven Rostedt (2):
      powerpc, ftrace: use unsigned int for instruction manipulation
      powerpc, ftrace: use create_branch lib function

----
 arch/powerpc/kernel/ftrace.c |   59 +++++++++++++----------------------------
 1 files changed, 19 insertions(+), 40 deletions(-)
-- 
