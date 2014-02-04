Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6CEDD2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 21:02:02 +1100 (EST)
Date: Tue, 4 Feb 2014 11:01:26 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 1/2] time: Change the return type of
 clockevents_notify() to integer
In-Reply-To: <20140124065739.17564.97259.stgit@preeti.in.ibm.com>
Message-ID: <alpine.DEB.2.02.1402041100250.24986@ionos.tec.linutronix.de>
References: <20140124065501.17564.39363.stgit@preeti.in.ibm.com>
 <20140124065739.17564.97259.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: daniel.lezcano@linaro.org, peterz@infradead.org, fweisbec@gmail.com,
 agraf@suse.de, paul.gortmaker@windriver.com, paulus@samba.org,
 mingo@kernel.org, mikey@neuling.org, shangw@linux.vnet.ibm.com,
 rafael.j.wysocki@intel.com, paulmck@linux.vnet.ibm.com, arnd@arndb.de,
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

On Fri, 24 Jan 2014, Preeti U Murthy wrote:
> -extern void tick_broadcast_oneshot_control(unsigned long reason);
> +extern int tick_broadcast_oneshot_control(unsigned long reason);

> -static inline void tick_broadcast_oneshot_control(unsigned long reason) { }
> +static inline int tick_broadcast_oneshot_control(unsigned long reason) { }

> -static inline void tick_broadcast_oneshot_control(unsigned long reason) { }
> +static inline int tick_broadcast_oneshot_control(unsigned long reason) { }

The inline stubs need to return 0.

Thanks,

	tglx
