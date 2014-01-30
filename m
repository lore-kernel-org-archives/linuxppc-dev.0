Return-Path: <nicolas.pitre@linaro.org>
Received: from mail-qa0-f48.google.com (mail-qa0-f48.google.com
 [209.85.216.48])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4BD802C014B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 00:31:58 +1100 (EST)
Received: by mail-qa0-f48.google.com with SMTP id f11so4279963qae.21
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 05:31:55 -0800 (PST)
Date: Thu, 30 Jan 2014 08:31:52 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 0/6] setting the table for integration of cpuidle with
 the scheduler
In-Reply-To: <20140130092835.GL11314@laptop.programming.kicks-ass.net>
Message-ID: <alpine.LFD.2.11.1401300830340.1652@knanqh.ubzr>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
 <20140130092835.GL11314@laptop.programming.kicks-ass.net>
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

> On Wed, Jan 29, 2014 at 12:45:07PM -0500, Nicolas Pitre wrote:
> > As everyone should know by now, we want to integrate the cpuidle
> > governor with the scheduler for a more efficient idling of CPUs.
> > In order to help the transition, this small patch series moves the
> > existing interaction with cpuidle from architecture code to generic
> > core code.  The ARM, PPC, SH and X86 architectures are concerned.
> > No functional change should have occurred yet.
> > 
> > @peterz: Are you willing to pick up those patches?
> 
> Yeah.. no objections. Should I pick these up or will you be sending
> another round?

I think you could pick them now, taking care of picking up the amended 
#1/6.


Nicolas
