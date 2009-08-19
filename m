Return-Path: <peterz@infradead.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DB8F3B6F20
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 21:23:32 +1000 (EST)
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 68454DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 21:23:32 +1000 (EST)
Subject: Re: spin_is_locked() broken for uniprocessor?
From: Peter Zijlstra <peterz@infradead.org>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
In-Reply-To: <c384c5ea0908190416r4e0b5508x4765381888516484@mail.gmail.com>
References: <alpine.LFD.2.00.0908190022570.3361@localhost.localdomain>
	<DE9C9034-D2CE-4D21-93D9-A10FE2580920@kernel.crashing.org>
	<7099.1250674686@redhat.com>
	<20090819115301.563be6da@lxorguk.ukuu.org.uk>
	<c384c5ea0908190416r4e0b5508x4765381888516484@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 19 Aug 2009 13:23:13 +0200
Message-Id: <1250680993.7583.350.camel@twins>
Mime-Version: 1.0
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Linux-Kernel List <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-08-19 at 13:16 +0200, Leon Woestenberg wrote:
> Hello,
> 
> On Wed, Aug 19, 2009 at 12:53 PM, Alan Cox<alan@lxorguk.ukuu.org.uk> wrote:
> > On Wed, 19 Aug 2009 10:38:06 +0100
> >
> > in drivers because there is driver code that uses spin_is_locked() in
> > fairly sensible fashion when dealing with locking.
> >
> One use is to measure lock contention hits on a particular spin lock.
> 
> 
> However I wonder if there are tracing capabilities to measure lock
> contention on a particular lock?

lock_stat no good for you?
