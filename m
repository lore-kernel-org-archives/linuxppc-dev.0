Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D70002C00CB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 03:53:28 +1100 (EST)
Date: Thu, 30 Jan 2014 17:52:58 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 6/6] cpu/idle.c: move to sched/idle.c
Message-ID: <20140130165258.GC2936@laptop.programming.kicks-ass.net>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
 <1391017513-12995-7-git-send-email-nicolas.pitre@linaro.org>
 <20140130152500.GB5002@laptop.programming.kicks-ass.net>
 <alpine.LFD.2.11.1401301102210.1652@knanqh.ubzr>
 <20140130162753.GF5002@laptop.programming.kicks-ass.net>
 <1391100076.2422.56.camel@joe-AO722>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391100076.2422.56.camel@joe-AO722>
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

On Thu, Jan 30, 2014 at 08:41:16AM -0800, Joe Perches wrote:
> Perhaps you could use a newer version of patch
> 
> GNU patch version 2.7 released

Yeah, I know about that, I'll wait until its common in all distros,
updating all machines I use by hand is just painful.
