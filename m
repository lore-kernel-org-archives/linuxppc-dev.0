Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 348FCDDE0A
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 08:32:40 +1100 (EST)
Date: Wed, 19 Nov 2008 16:32:38 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/9] ftrace: align __mcount_loc sections
In-Reply-To: <20081119212333.052756846@goodmis.org>
Message-ID: <alpine.DEB.1.10.0811191631040.20272@gandalf.stny.rr.com>
References: <20081119212204.318400312@goodmis.org>
	<20081119212333.052756846@goodmis.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>, Milton Miller <miltonm@bga.com>,
	Matt Fleming <matthew.fleming@imgtec.com>,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I need to change my scripts to parse out the first line of all patches, so 
quilt can send out the proper owner. This patch has the following header:

>From 626f82959cd00ca804b12543cad86714e74264da Mon Sep 17 00:00:00 2001
From: Matt Fleming <matthew.fleming@imgtec.com>
Date: Fri, 7 Nov 2008 13:26:25 +0000
Subject: [PATCH] ftrace: align __mcount_loc sections


If you pull from my repo, it will all work out. But still, I do not want 
to take credit for someone else's work.

-- Steve
