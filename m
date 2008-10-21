Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 643A2DDEFC
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 18:34:11 +1100 (EST)
Date: Tue, 21 Oct 2008 09:33:50 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Bug in "genirq: record trigger type"
Message-ID: <20081021073350.GA22351@elte.hu>
References: <200810202205.m9KM5une024759@hera.kernel.org>
	<1224570730.7654.242.camel@pasglop>
	<86802c440810210022i75d3c081r8fc979386cdda9ce@mail.gmail.com>
	<20081021072857.GA333@elte.hu> <1224574343.7654.244.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1224574343.7654.244.camel@pasglop>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Yinghai Lu <yinghai@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2008-10-21 at 09:28 +0200, Ingo Molnar wrote:
> 
> > From: Chris Friesen <cfriesen@nortel.com>
> > Date: Mon, 20 Oct 2008 12:41:58 -0600
> > Subject: [PATCH] genirq: fix set_irq_type() when recording trigger type
> > 
> > In set_irq_type() we want to pass the type rather than the current
> > interrupt state.
> > 
> > Signed-off-by: Chris Friesen <cfriesen@nortel.com>
> > Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

thx, added your ack to the commit as well.

	Ingo
