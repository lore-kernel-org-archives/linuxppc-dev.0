Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 71AC32BDF2
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Dec 2004 21:28:14 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	gentoo-ppc-user@gentoo.org, fedora-ppc@lists.infradead.org
Content-Type: text/plain
Date: Sun, 05 Dec 2004 21:25:28 +1100
Message-Id: <1102242328.11763.68.camel@gaston>
Mime-Version: 1.0
Subject: TEST: Sleep patch #6
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(As usual, I'm cross posting several lists, please don't reply to all of them,
and CC me as I'm not subscribed to all of them neither)

Ok, here's the 7th version of the sleep patch for ATI based albooks &
iBook G4. Other machine users, please test too as it may cause
regressions (or improvements) as well.

The cache flush problem happens to not be completely fixed yet :( There is
something going on that I don't completely explain yet, might be related to
an errata of some CPU revisions. This version of the patch adds a load/flush
loop before the L2 HW flush on the 745x that appear to make the thing stable
on the machines I've tested on. It's a good enough workaround for now, I'm
working with freescale to find out what's really going on though.

http://gate.crashing.org/~benh/albook-ibookg4-sleep-7.diff


Ben.
