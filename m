Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 365DBDDDFF
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 06:01:22 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id m9GIwG9h019564
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 14:58:16 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9GJ1I9g166314
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 15:01:18 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9GJ1AgU001628
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 15:01:17 -0400
Date: Thu, 16 Oct 2008 15:01:06 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/2] ftrace: fixes for PPC
Message-ID: <20081016150106.6ddf7e46@zod.rchland.ibm.com>
In-Reply-To: <alpine.DEB.1.10.0810161444050.11042@gandalf.stny.rr.com>
References: <20080906050602.409299112@goodmis.org>
	<20080906120346.GA30964@elte.hu>
	<20081016181452.GA29739@yoda.jdub.homelinux.org>
	<alpine.DEB.1.10.0810161421530.11042@gandalf.stny.rr.com>
	<20081016183529.GB29739@yoda.jdub.homelinux.org>
	<alpine.DEB.1.10.0810161444050.11042@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
	Andrew, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 16 Oct 2008 14:45:15 -0400 (EDT)
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> On Thu, 16 Oct 2008, Josh Boyer wrote:
> > 
> > Well, that's why I asked.  You sent 2 patches out over a month ago that
> > don't appear to have shown up in any Linus or PowerPC tree.
> 
> Oh, the patches I sent on here, are not to solve this issue. It was 
> actually solving issues in linux-tip itself.

Totally confused as to what linux-tip is, but ok.

> I'm still looking into the cause for ftrace not to boot on PPC.

There were issues with -pg and some other compile flag on PPC at one
point.  I think you worked that out with Ben, but I don't recall.

Anyway, if you want a tester let me know.  It seems 2.6.27.1 should be
fine since FTRACE was disabled, but for .28-rc1 it would be cool if it
worked :).

josh
