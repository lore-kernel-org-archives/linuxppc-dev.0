Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 46FFE67B5B
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Nov 2006 07:19:48 +1100 (EST)
Subject: Re: [PATCH] 2.6.18-rt7: PowerPC: fix breakage in threaded fasteoi
	type IRQ handlers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20061119200650.GA22949@elte.hu>
References: <200611192243.34850.sshtylyov@ru.mvista.com>
	<1163966437.5826.99.camel@localhost.localdomain>
	<20061119200650.GA22949@elte.hu>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 07:19:50 +1100
Message-Id: <1163967590.5826.104.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-11-19 at 21:06 +0100, Ingo Molnar wrote:
> * Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Wait wait wait .... Can somebody (Ingo ?) explain me why the fasteoi 
> > handler is being changed and what is the rationale for adding an ack 
> > that was not necessary before ?
> 
> dont worry, it's -rt only stuff.

Still, I'm curious :-) Besides, there have been people talking about
having -rt work on ppc64 so ...

What do you need an ack() for on fasteoi ? On all fasteoi controllers I
have, ack is implicit by obtaining the vector number and all there is is
an eoi...

Cheers,
Ben.
