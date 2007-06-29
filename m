Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B95B3DDEEF
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Jun 2007 10:13:25 +1000 (EST)
Subject: Re: PCI IO range limitation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <46844692.1040804@genesi-usa.com>
References: <46838B54.2010806@semihalf.com>
	<1183052634.5521.284.camel@localhost.localdomain>
	<46844692.1040804@genesi-usa.com>
Content-Type: text/plain
Date: Fri, 29 Jun 2007 10:13:16 +1000
Message-Id: <1183075997.5521.292.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Marian Balakowicz <m8@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-29 at 00:38 +0100, Matt Sealey wrote:
> Benjamin Herrenschmidt wrote:
> > On Thu, 2007-06-28 at 12:20 +0200, Marian Balakowicz wrote:
> >> Hi,
> >>
> >> Trying to change PCI IO window base for 52xx target I found that
> >> we are pretty much limited to a "0" offset only.
> > 
> > We just fixed that for 64 bits but 32 bits still has the limitation.
> > Note that it's not a very good idea to have your IO range at !0 if
> > you're going to use anything ISA-like, such as a VGA video card or other
> > legacy devices behind a PCI southbridge or SuperIO.
> 
> The chances of that on an MPC52xx platform are practically zero, aren't
> they?

Euh... don't you use VGA video cards on Efika ? :-)

Ben.
