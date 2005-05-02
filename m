Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 16431679EA
	for <linuxppc-dev@ozlabs.org>; Tue,  3 May 2005 08:17:43 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	DebianPPC <debian-powerpc@lists.debian.org>
Content-Type: text/plain
Date: Tue, 03 May 2005 08:15:33 +1000
Message-Id: <1115072133.6031.33.camel@gaston>
Mime-Version: 1.0
Subject: Laptop sleep & current "git" tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi folks !

All my pending patches regarding power management are now upstream in
Linus "git" repository. That means I expect those to fix all known
issues (with the notable exception of the USB related problems, all of
these things aren't yet there but they aren't under my control, so still
unplug USB devices).

I would appreciate extensive testing, provided you figure out how to
retreive the "git" repository from kernel.org :) There must be some
howto somewhere, but I'm afraid I don't have a link at hand.

For those who can't dare experimenting with that new git toy, best may
be for you to wait for 2.6.12-rc4 which will contain all of these.

Cheers,
Ben.
