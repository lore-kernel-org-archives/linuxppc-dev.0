Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6F904DDF61
	for <linuxppc-dev@ozlabs.org>; Wed, 28 May 2008 02:07:16 +1000 (EST)
Date: Tue, 27 May 2008 17:36:14 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] rcupreempt: remove export of rcu_batches_completed_bh
In-Reply-To: <Pine.LNX.4.58.0805221415330.14724@gandalf.stny.rr.com>
Message-ID: <alpine.LFD.1.10.0805271735280.3295@apollo.tec.linutronix.de>
References: <Pine.LNX.4.58.0805221415330.14724@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	paulus@samba.org, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 22 May 2008, Steven Rostedt wrote:
> In rcupreempt, rcu_batches_completed_bh is defined as a static inline in
> the header file. This does not need to be exported, and not only that,
> this breaks my PPC build.
> 
> Signed-off-by: Steven Rostedt <srostedt@redhat.com>

Applied, queued for Linus. Thanks

	 tglx
