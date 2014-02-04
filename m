Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8A9692C0098
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Feb 2014 07:19:20 +1100 (EST)
Date: Tue, 4 Feb 2014 21:18:40 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 2/2] tick/cpuidle: Initialize hrtimer mode of broadcast
In-Reply-To: <52F11ECE.605@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.02.1402042118220.24986@ionos.tec.linutronix.de>
References: <20140124065501.17564.39363.stgit@preeti.in.ibm.com>
 <20140124065820.17564.83076.stgit@preeti>
 <alpine.DEB.2.02.1402041101330.24986@ionos.tec.linutronix.de>
 <52F11ECE.605@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: daniel.lezcano@linaro.org, peterz@infradead.org, fweisbec@gmail.com,
 paul.gortmaker@windriver.com, paulus@samba.org, mingo@kernel.org,
 mikey@neuling.org, shangw@linux.vnet.ibm.com, rafael.j.wysocki@intel.com,
 agraf@suse.de, paulmck@linux.vnet.ibm.com, arnd@arndb.de,
 linux-pm@vger.kernel.org, rostedt@goodmis.org, michael@ellerman.id.au,
 john.stultz@linaro.org, anton@samba.org, chenhui.zhao@freescale.com,
 deepthi@linux.vnet.ibm.com, r58472@freescale.com, geoff@infradead.org,
 linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
 schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 4 Feb 2014, Preeti U Murthy wrote:
> Do you want me to send out the next version with the above corrections
> including the patch added to this thread where we handle archs setting
> the CPUIDLE_FLAG_TIMER_STOP flag?

Yes please.
