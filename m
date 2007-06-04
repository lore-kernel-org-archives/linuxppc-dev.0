Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B89E8DDE49
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Jun 2007 18:18:59 +1000 (EST)
In-Reply-To: <20070604001639.GA25972@lixom.net>
References: <1180720112.14219.62.camel@ld0161-tx32>
	<dfc15991e31bfc09389461dc443acd7c@kernel.crashing.org>
	<E1HuGfE-0007zw-EH@jdl.com>
	<1180743742.19517.485.camel@localhost.localdomain>
	<e2020ffad171013c07f8809e1e1aef97@kernel.crashing.org>
	<E1HuW61-00049R-FI@jdl.com>
	<27807251665003e059b2c39d2b700415@kernel.crashing.org>
	<1180826202.14025.12.camel@localhost.localdomain>
	<20070604001639.GA25972@lixom.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f7f5c8cff01c7031a1d0b4e666869334@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/8] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
Date: Mon, 4 Jun 2007 10:18:52 +0200
To: olof@lixom.net (Olof Johansson)
Cc: Jon Loeliger <jdl@jdl.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> They aren't -that- good when you come out of the blue and don't know
>> where to start. I think a tutorial based on building a tree for an
>> example board step by step would be best.
>
> There seems to be two things that causes problems:

0) The lack of good, clear, exhaustive, and recipe-style
documentation.

> 1) People basing their new tree on an old example that's broken, and
> getting crap for that because it's not correct

Yeah.

> 2) Trying to add new devices that aren't in any trees already, and
> the near infinite discussions that then start.

This is a *good* thing (as long as it's productive) --
it simply is a lot of work to define a good device binding
for non-trivial devices.

> (2) I don't have a good solution for. Better documentation pointers 
> would
> definitely be a help, but it's not the whole solution. I'd expect it to
> get better and better over time as there'll be less and less unmapped
> terrain, and better and better examples to use.

We can only hope :-)


Segher
