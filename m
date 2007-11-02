Return-Path: <schwidefsky@de.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.29.156])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 309BFDDDFE
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Nov 2007 18:50:04 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.8/8.13.8) with ESMTP id lA27nwCq415282
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 07:49:58 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.5) with
	ESMTP id lA27nwJR1806568
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 08:49:58 +0100
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lA27nv1j005157
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Nov 2007 08:49:58 +0100
Subject: Re: [PATCH] Restore deterministic CPU accounting on powerpc
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18218.44089.274628.680088@cargo.ozlabs.ibm.com>
References: <18218.44089.274628.680088@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 02 Nov 2007 08:49:56 +0100
Message-Id: <1193989796.10694.2.camel@localhost>
Mime-Version: 1.0
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Reply-To: schwidefsky@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-11-02 at 15:48 +1100, Paul Mackerras wrote:
> This also lets us simplify the s390 code a bit; it means that the s390
> timer interrupt can now call update_process_times even when
> CONFIG_VIRT_CPU_ACCOUNTING is turned on, and can just implement a
> suitable account_process_tick().

Just tested on s390 with CONFIG_VIRT_CPU_ACCOUNTING=y. Works fine and it
is a nice cleanup of the s390 timer code. Thanks Paul.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
