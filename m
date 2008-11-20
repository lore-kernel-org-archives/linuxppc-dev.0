Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id 06DF2DDDED
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 07:35:53 +1100 (EST)
Message-Id: <20081120203415.251344054@goodmis.org>
Date: Thu, 20 Nov 2008 15:34:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ftrace: updates to recordmcount.pl script
Cc: Matt Fleming <mjf@gentoo.org>, Jim Radford <radford@galvanix.net>,
	linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
	Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ingo,

I took Matt's patch and stripped out all the sh changes, leaving
only the update to recordmcount.pl. Hopefully, this will disappear
when it is pulled into linux-next.

The second patch is the changes needed for PowerPC in the recordmcount.pl
script.

The thrird patch is the cleanup.

All of this is based off of tip/master.

The following patches are in:

  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git

    branch: tip/devel


Matt Fleming (1):
      sh: dynamic ftrace support.

Steven Rostedt (2):
      ftrace: add support for powerpc to recordmcount.pl script
      ftrace: create default variables for archs in recordmcount.pl

----
 scripts/recordmcount.pl |   37 +++++++++++++++++++++++++++++--------
 1 files changed, 29 insertions(+), 8 deletions(-)
