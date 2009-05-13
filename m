Return-Path: <andi@firstfloor.org>
Received: from one.firstfloor.org (one.firstfloor.org [213.235.205.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1B9BFDDFDC
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 00:57:25 +1000 (EST)
Date: Wed, 13 May 2009 17:02:42 +0200
From: Andi Kleen <andi@firstfloor.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: question about softirqs
Message-ID: <20090513150242.GX19296@one.firstfloor.org>
References: <20090511.162436.193717082.davem@davemloft.net>
	<4A08C62F.1050105@nortel.com> <20090512081237.GA16403@elte.hu>
	<4A09933B.8010606@nortel.com> <874ovpmmdq.fsf@basil.nowhere.org>
	<4A0AC9EC.6070908@nortel.com>
	<20090513141532.GT19296@one.firstfloor.org>
	<alpine.LFD.2.00.0905131612180.3561@localhost.localdomain>
	<87my9hkrmw.fsf@basil.nowhere.org> <4A0ADF34.2040001@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A0ADF34.2040001@cosmosbay.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	David Miller <davem@davemloft.net>,
	Andi Kleen <andi@firstfloor.org>, paulus@samba.org,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I have one machine SMP flooded by network frames, CPU0 handling all

Yes that's the case softirqd is supposed to handle. When you 
spend a significant part of your CPU time in softirq context it kicks
in to provide somewhat fair additional CPU time.

But most systems (like mine) don't do that.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
