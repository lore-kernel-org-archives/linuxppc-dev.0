Return-Path: <rjw@rjwysocki.net>
Received: from cloudserver094114.home.net.pl (cloudserver094114.home.net.pl
 [79.96.170.134])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCH9027hDzDrWJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 22:56:35 +1000 (AEST)
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>,
 linux@dominikbrodowski.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ingo Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Len Brown <lenb@kernel.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V3 0/9] cpufreq: transition-latency cleanups
Date: Wed, 19 Jul 2017 14:42:02 +0200
Message-ID: <2155547.8AYfQSCbsT@aspire.rjw.lan>
In-Reply-To: <cover.1500373914.git.viresh.kumar@linaro.org>
References: <cover.1500373914.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday, July 19, 2017 03:42:40 PM Viresh Kumar wrote:
> Hi Rafael,
> 
> This series tries to cleanup the code around transition-latency and its
> users. Some of the old legacy code, which may not make much sense now,
> is dropped as well. And some code consolidation is also done across
> governors.
> 
> Based of: v4.13-rc1
> Tested on: ARM64 Hikey board.

>From the first quick look this version is fine by me.

Unless I find anything of concern later, this will be queued up for 4.14.

Thanks,
Rafael
