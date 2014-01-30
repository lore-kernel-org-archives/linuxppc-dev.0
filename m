Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0163.hostedemail.com
 [216.40.44.163]) by ozlabs.org (Postfix) with ESMTP id BC53A2C023F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 03:41:24 +1100 (EST)
Message-ID: <1391100076.2422.56.camel@joe-AO722>
Subject: Re: [PATCH v2 6/6] cpu/idle.c: move to sched/idle.c
From: Joe Perches <joe@perches.com>
To: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 30 Jan 2014 08:41:16 -0800
In-Reply-To: <20140130162753.GF5002@laptop.programming.kicks-ass.net>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
 <1391017513-12995-7-git-send-email-nicolas.pitre@linaro.org>
 <20140130152500.GB5002@laptop.programming.kicks-ass.net>
 <alpine.LFD.2.11.1401301102210.1652@knanqh.ubzr>
 <20140130162753.GF5002@laptop.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-kernel@lists.linaro.org,
 Russell King <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org,
 linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Paul Mundt <lethal@linux-sh.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-01-30 at 17:27 +0100, Peter Zijlstra wrote:
> On Thu, Jan 30, 2014 at 11:03:31AM -0500, Nicolas Pitre wrote:
> > > This is not a valid patch for PATCH(1). Please try again.
> > 
> > Don't you use git?  ;-)
> 
> Nah, git and me don't get along well.

Perhaps you could use a newer version of patch

http://savannah.gnu.org/forum/forum.php?forum_id=7361

GNU patch version 2.7 released

Item posted by Andreas Gruenbacher <agruen> on Wed 12 Sep 2012 02:18:14
PM UTC.

I am pleased to announce that version 2.7 of GNU patch has been
released. The following significant changes have happened since the last
stable release in December 2009: 

      * Support for most features of the "diff --git" format, including
        renames and copies, permission changes, and symlink diffs.
        Binary diffs are not supported yet; patch will complain and skip
        them.
