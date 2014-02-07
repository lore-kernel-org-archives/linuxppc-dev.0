Return-Path: <nicolas.pitre@linaro.org>
Received: from mail-qc0-f180.google.com (mail-qc0-f180.google.com
 [209.85.216.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E9CCD2C0078
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 22:09:28 +1100 (EST)
Received: by mail-qc0-f180.google.com with SMTP id i17so5466347qcy.25
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Feb 2014 03:09:25 -0800 (PST)
Date: Fri, 7 Feb 2014 11:09:23 +0000 (GMT)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 6/6] cpu/idle.c: move to sched/idle.c
In-Reply-To: <20140206164336.GU2936@laptop.programming.kicks-ass.net>
Message-ID: <alpine.LFD.2.11.1402071051140.1906@knanqh.ubzr>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
 <1391017513-12995-7-git-send-email-nicolas.pitre@linaro.org>
 <20140130152500.GB5002@laptop.programming.kicks-ass.net>
 <alpine.LFD.2.11.1401301102210.1652@knanqh.ubzr>
 <20140130162753.GF5002@laptop.programming.kicks-ass.net>
 <alpine.LFD.2.11.1402061152550.1906@knanqh.ubzr>
 <20140206164336.GU2936@laptop.programming.kicks-ass.net>
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

On Thu, 6 Feb 2014, Peter Zijlstra wrote:

> On Thu, Feb 06, 2014 at 02:09:59PM +0000, Nicolas Pitre wrote:
> > Hi Peter,
> > 
> > Did you merge those patches in your tree? 
> 
> tree, tree, what's in a word.

Something you may plant on a patch of grass?  "Merging" becomes a 
strange concept in that context though.  :-)

> Its in my patch stack yes. 

Quilt I suppose?? (yet another word.)

> I should get some of that into tip I suppose, been side-tracked a bit 
> this week. Sorry for the delay.

If you prefer we pile those patches (and future ones after revew) 
ourselves just let me know.  Future patches are likely to be more 
intimate with the scheduler so I just need to know who to upstream them 
through afterwards.


Nicolas
