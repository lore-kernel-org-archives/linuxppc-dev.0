Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C291D67B6C
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 07:38:38 +1000 (EST)
Subject: Re: [PATCH] General CHRP/MPC5K2 Platform and drivers support - to
	comment
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <453CD615.4050401@genesi-usa.com>
References: <453771E5.4090808@bplan-gmbh.de>
	<77AD49CA-69CB-4ADA-B8F3-3BC3A066BCF9@kernel.crashing.org>
	<453884F5.4000804@bplan-gmbh.de>
	<122A4E06-B8A6-4256-B96E-3811EA93EA25@kernel.crashing.org>
	<453B6A84.3050209@bplan-gmbh.de>
	<1161585371.10524.444.camel@localhost.localdomain>
	<453CD615.4050401@genesi-usa.com>
Content-Type: text/plain
Date: Tue, 24 Oct 2006 07:38:32 +1000
Message-Id: <1161639512.10524.485.camel@localhost.localdomain>
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

On Mon, 2006-10-23 at 16:47 +0200, Matt Sealey wrote:
> Curious question.
> 
> What are you guys going to do when the PowerPC name is defunct?

It's not really, is it ? I don't care anyway, it will stay PowerPC in
linux of course :)

> Like, last month :)
> 
> Power Architecture is where it is at. The trademark is even going to
> lapse

Who cares ? Besides, while PAPR says "Power architecture", the processor
architecture specification says PowerPC :)

> . It's a bit too late for the ppc->powerpc tree breakout now,
> but wouldn't it just confuse people to be using a "Power Architecture"
> processor or SoC of some type, using collections of definitions from
> the Power ISA 2.03 and have this "powerpc" thing pop up?

It's PowerPC ISA :)

> It confused me even before, because ppc and ppc64 have also been
> used to support real POWER (with a capital P, O, W, E and R) processors,
> and now these are lumped in with powerpc which is no better than
> ppc64 in these terms?

Historically, POWER means something else ... then with POWER3, POWER
processors became compatible with the PowerPC architecture, then IBM
played name changing game a couple of times and nobody knows what's up
anymore :)
 
> Just flexing my marketing exec muscles, see if they work, never done
> it before. Oh... *crack*.. that wasn't a good noise :]

AFAIK, the processor instruction set architecture is PowerPC an that
will not change.

Ben.
