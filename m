Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C433DDF8A
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 08:03:37 +1000 (EST)
Subject: Re: Problem with OF interrupt parsing code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20071002123849.242670@gmx.net>
References: <20071001210025.314240@gmx.net> <20071001211120.156280@gmx.net>
	<d3eb2341d21ed1f9f7e71f097878731f@kernel.crashing.org>
	<1191279244.6310.32.camel@pasglop>  <20071002123849.242670@gmx.net>
Content-Type: text/plain
Date: Wed, 03 Oct 2007 08:03:27 +1000
Message-Id: <1191362607.22572.26.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-10-02 at 14:38 +0200, Gerhard Pircher wrote:
> I know that it's ugly, but the problem is how to distinguish the
> boards.
> The only real difference I know of is the PCI interrupt mapping. The
> northbridges chip revision for example is always the same, but CPU
> type,
> amount of memory and PCI devices can appear in all possible
> combinations.
> The firmware doesn't tell me, which board the kernel is runnning on,
> so I
> would like to rely on this fall back here until I get the chance to
> update the firmware (which is beyond my control).

And how does the firmware know ? There must be a strap somewhere...

Ben.
