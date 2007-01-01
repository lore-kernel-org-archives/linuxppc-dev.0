Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84D30DDE2A
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Jan 2007 07:44:49 +1100 (EST)
In-Reply-To: <1167679875.22068.350.camel@pmac.infradead.org>
References: <1167679875.22068.350.camel@pmac.infradead.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b3e2d9d05daea206820fc34181c93975@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Fix Maple PATA IRQ assignment.
Date: Mon, 1 Jan 2007 21:42:00 +0100
To: David Woodhouse <dwmw2@infradead.org>
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On the Maple board, the AMD8111 IDE is in legacy mode... except that it
> appears on IRQ 20 instead of IRQ 15.

How does this work?  The hardware routes the EIDE interrupts
to #14/#15 in legacy mode, just like it should.  Can you show
the relevant configuration bits please?


Segher
