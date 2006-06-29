Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3FB0567B68
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 18:36:12 +1000 (EST)
Received: from localhost.localdomain (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id k5T8gXiH008489
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 03:42:34 -0500
Subject: new IRQ work status
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Thu, 29 Jun 2006 18:36:05 +1000
Message-Id: <1151570165.28229.15.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here's a progress report on my new irq management work.

I've ported pseries, iseries (well tested) and cell (barely tested) at
this point, and tested various funky combinations of device-trees to
validate as much as the core as possible. I still need to port over chrp
and maple which are easy, and powermac which will be a bit more
difficult as it relies a lot more on intrs/n_intrs in the device-nodes
which I've now removed.

Hopefully, it should be finished this week. The current serie of patch
applies on top of 2.6.17-mm1. I will do a version on top of the powerpc
tree as soon as the genirq port is upstream (which hopefully should
happen soon, possibly tomorrow).

I don't yet want to post the patches on the list (too much), they can be
found at:

http://gate.crashing.org/~benh/irq-WIP/

Comments welcome.

Cheers,
Ben.
