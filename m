Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D3720DDE22
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 21:13:36 +1000 (EST)
Subject: Re: PCI IO range limitation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Marian Balakowicz <m8@semihalf.com>
In-Reply-To: <468A15D9.7010003@semihalf.com>
References: <46838B54.2010806@semihalf.com>
	<1183052634.5521.284.camel@localhost.localdomain>
	<468A15D9.7010003@semihalf.com>
Content-Type: text/plain
Date: Tue, 03 Jul 2007 21:13:30 +1000
Message-Id: <1183461210.10386.104.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-07-03 at 11:24 +0200, Marian Balakowicz wrote:
> Benjamin Herrenschmidt wrote:
> > On Thu, 2007-06-28 at 12:20 +0200, Marian Balakowicz wrote:
> >> I guess that with the above dropping of non-zero based PCI IO ranges
> >> this is not supposed to be working. But does anyone know why?
> > 
> > We just fixed that for 64 bits but 32 bits still has the limitation.
> > Note that it's not a very good idea to have your IO range at !0 if
> > you're going to use anything ISA-like, such as a VGA video card or other
> > legacy devices behind a PCI southbridge or SuperIO.
> 
> Agree with the zero-based IO range for ISA devices. But, knowing we don't
> have any ISA stuff on board it should be possible to change the IO base.

And you don't plan to ever have a VGA video card ?

> Are you planning on modifications for 32 bits as well?

Not right now, but you are welcome to send a patch :-) Though I fail to
see why you want to do it.

Ben
