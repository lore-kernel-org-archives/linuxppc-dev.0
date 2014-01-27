Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5CE2F2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 04:36:22 +1100 (EST)
Date: Mon, 27 Jan 2014 18:35:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/9] ARM: get rid of arch_cpu_idle_prepare()
Message-ID: <20140127173557.GE4941@twins.programming.kicks-ass.net>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-2-git-send-email-nicolas.pitre@linaro.org>
 <52E6175F.1050401@linaro.org>
 <20140127160736.GP15937@n2100.arm.linux.org.uk>
 <52E69395.9020004@linaro.org>
 <20140127172110.GR15937@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140127172110.GR15937@n2100.arm.linux.org.uk>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-kernel@lists.linaro.org,
 linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 27, 2014 at 05:21:10PM +0000, Russell King - ARM Linux wrote:
> A reviewed-by tag on its own doesn't mean much, as it could mean that
> you've just glanced over the code and decided "yea, it looks okay", or
> it could mean that you've spent all day verifying that the code change
> is indeed correct.

One should use Acked-by for the 'yea, it looks okay' thing.
