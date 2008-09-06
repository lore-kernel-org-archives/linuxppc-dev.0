Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 44328DDDE1
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Sep 2008 22:04:11 +1000 (EST)
Date: Sat, 6 Sep 2008 14:03:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/2] ftrace: fixes for PPC
Message-ID: <20080906120346.GA30964@elte.hu>
References: <20080906050602.409299112@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080906050602.409299112@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Steven Rostedt <rostedt@goodmis.org> wrote:

> I spent the day chasing a bug that would hang PPC on boot up when 
> ftrace is configured in. I found that it was simply a stupid bug I did 
> to handle the non MCOUNT_RECORD case. Since I was testing only on x86, 
> and the MCOUNT_RECORD is automatically set for dynamic ftrace if it is 
> available, I did not test the case where MCOUNT_RECORD was not set.
> 
> I have not finished porting MCOUNT_RECORD to PPC, but have found that 
> it has caused some issues for archs that do not support it yet.
> 
> This patch series handles these cases.

applied to tip/tracing/ftrace, thanks Steve.

	Ingo
