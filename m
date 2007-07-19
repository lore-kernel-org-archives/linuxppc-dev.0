Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 32E15DDFC6
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 07:45:43 +1000 (EST)
In-Reply-To: <fa686aa40707191249r1e73f6f7s7f2aa4502919e98a@mail.gmail.com>
References: <fa686aa40707191249r1e73f6f7s7f2aa4502919e98a@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <29147F04-4307-4720-B3C3-2AF6721967F1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: BUG: compile failure on ps3-head.S
Date: Thu, 19 Jul 2007 23:45:24 +0200
To: "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> commit id bafdb645779c63300763acb383f7b9dd2d427228 (on Linus' tree)
> causes breakage on my mpc8349 build (see below).  I've worked around
> it by removing ps3* from arch/powerpc/boot/Makefile, but I have not
> dug into what the 'proper' solution should be.

> arch/powerpc/boot/ps3-head.S:40: Error: Unrecognized opcode: `clrldi'
> arch/powerpc/boot/ps3-head.S:41: Error: Unrecognized opcode: `mtmsrd'

Those source files just need a .machine pseudo-op somewhere.


Segher
