Return-Path: <nicolas.pitre@linaro.org>
Received: from mail-qc0-f176.google.com (mail-qc0-f176.google.com
 [209.85.216.176])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 464622C009F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 01:10:08 +1100 (EST)
Received: by mail-qc0-f176.google.com with SMTP id e16so3169356qcx.35
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Feb 2014 06:10:02 -0800 (PST)
Date: Thu, 6 Feb 2014 14:09:59 +0000 (GMT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 6/6] cpu/idle.c: move to sched/idle.c
In-Reply-To: <20140130162753.GF5002@laptop.programming.kicks-ass.net>
Message-ID: <alpine.LFD.2.11.1402061152550.1906@knanqh.ubzr>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
 <1391017513-12995-7-git-send-email-nicolas.pitre@linaro.org>
 <20140130152500.GB5002@laptop.programming.kicks-ass.net>
 <alpine.LFD.2.11.1401301102210.1652@knanqh.ubzr>
 <20140130162753.GF5002@laptop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linaro-kernel@lists.linaro.org, Russell King <linux@arm.linux.org.uk>,
 linux-sh@vger.kernel.org, linux-pm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
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

On Thu, 30 Jan 2014, Peter Zijlstra wrote:

> On Thu, Jan 30, 2014 at 11:03:31AM -0500, Nicolas Pitre wrote:
> > > This is not a valid patch for PATCH(1). Please try again.
> > 
> > Don't you use git?  ;-)
> 
> Nah, git and me don't get along well.
> 
> > Here's a plain patch:
> 
> Thanks!

Hi Peter,

Did you merge those patches in your tree?  If so, is it published 
somewhere?  That would be a good idea if that could appear in linux-next 
so to prevent people from adding more calls to cpuidle_idle_call() from 
architecture code.  I'm sending you 2 additional patches right away to 
remove those that appeared in v3.14-rc1.


Nicolas
