Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A0F8167A58
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 08:44:10 +1000 (EST)
Subject: Re: cpu power "management" for non-dfs chips with no pmu (for
	instance, 750cxe and mpc7447 in pegasos)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: matt@genesi-usa.com
In-Reply-To: <018201c696b1$e942ba40$99dfdfdf@bakuhatsu.net>
References: <018201c696b1$e942ba40$99dfdfdf@bakuhatsu.net>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 08:43:57 +1000
Message-Id: <1151448237.2350.98.camel@localhost.localdomain>
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


> I am basically trying to evaluate if we can do ANYTHING to reduce
> power consumption of systems which are idle, as I have noticed that
> for running firmware (sitting at a Forth prompt) and booting a
> Linux kernel and doing some work (for instance a simple benchmark),
> power consumption barely changes at all. The difference between an
> idle G4 and a running G4 is negligible. RC5 makes a big difference
> but it is heavily tuned. Most people won't run RC5 all the time to
> stress the CPU to the level that it wants to draw a couple extra
> watts, I think.

Well, I would expect the Idle G4 to have a fairly good PM in the first
place due to the NAP mode... though we may not enable that on Pegasos.
It depends if the bridge supports the proper protocol to handle
snooping. The Discovery II is bad enough as it is, I wouldn't expect it
to support that in a non-buggy way unfortunately.

Ben.
