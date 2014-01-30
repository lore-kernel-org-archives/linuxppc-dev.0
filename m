Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 05CC62C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 20:28:57 +1100 (EST)
Date: Thu, 30 Jan 2014 10:28:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 0/6] setting the table for integration of cpuidle with
 the scheduler
Message-ID: <20140130092835.GL11314@laptop.programming.kicks-ass.net>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
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

On Wed, Jan 29, 2014 at 12:45:07PM -0500, Nicolas Pitre wrote:
> As everyone should know by now, we want to integrate the cpuidle
> governor with the scheduler for a more efficient idling of CPUs.
> In order to help the transition, this small patch series moves the
> existing interaction with cpuidle from architecture code to generic
> core code.  The ARM, PPC, SH and X86 architectures are concerned.
> No functional change should have occurred yet.
> 
> @peterz: Are you willing to pick up those patches?

Yeah.. no objections. Should I pick these up or will you be sending
another round?
