Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6AA1B67A33
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Apr 2005 08:06:08 +1000 (EST)
Date: Mon, 18 Apr 2005 15:06:05 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050418220605.GE25352@gate.ebshome.net>
References: <c3d0340b05041514362746169a@mail.gmail.com>
	<20050415221235.GA29802@gate.ebshome.net>
	<c3d0340b0504151609397d73f7@mail.gmail.com>
	<20050416005026.GB1086@gate.ebshome.net>
	<c3d0340b05041814144133a608@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b05041814144133a608@mail.gmail.com>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: Interrupt prioritization on linux for ppc440
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Apr 18, 2005 at 02:14:23PM -0700, Shawn Jin wrote:
> 
> > What could be interesting, though, is to to make all 4xx IRQs
> > critical, in this case we could use VR to quickly determine which IRQ
> > was asserted, instead of current implementation when we use bit
> > operations. Not sure, if performance gain is really worth the
> > effort :)
> 
> If we use VR to determine which IRQ was asserted, it's kind of
> reverse. We usually fetch a handler by its IRQ number. It could
> require to change irq_desc[] and request_irq().

You seems don't undestand what I'm talking about. VR can help us with 
determining what IRQ was asserted. It has nothing to do with irq_desc.

Curently, we use some bit searching functions like ffs to get IRQ 
number, VR can be used instead.

-- 
Eugene
