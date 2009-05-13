Return-Path: <andi@firstfloor.org>
Received: from one.firstfloor.org (one.firstfloor.org [213.235.205.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2CE94DDFD1
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 00:10:15 +1000 (EST)
Date: Wed, 13 May 2009 16:15:32 +0200
From: Andi Kleen <andi@firstfloor.org>
To: Chris Friesen <cfriesen@nortel.com>
Subject: Re: question about softirqs
Message-ID: <20090513141532.GT19296@one.firstfloor.org>
References: <18948.63755.279732.294842@cargo.ozlabs.ibm.com>
	<20090508.234815.127227651.davem@davemloft.net>
	<4A086DB2.8040703@nortel.com>
	<20090511.162436.193717082.davem@davemloft.net>
	<4A08C62F.1050105@nortel.com> <20090512081237.GA16403@elte.hu>
	<4A09933B.8010606@nortel.com> <874ovpmmdq.fsf@basil.nowhere.org>
	<4A0AC9EC.6070908@nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A0AC9EC.6070908@nortel.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, netdev@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	Andi Kleen <andi@firstfloor.org>, paulus@samba.org,
	Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> "If a soft irq is raised in process context, raise_softirq() in
> kernel/softirq.c calls wakeup_softirqd() to make sure that ksoftirqd

softirqd is only used when the softirq runs for too long or when
there are no suitable irq exits for a long time.

In normal situations (not excessive time in softirq) they don't
do anything. 

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
