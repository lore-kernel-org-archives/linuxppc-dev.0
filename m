Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1CE9768596
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Nov 2005 17:33:57 +1100 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Content-Type: text/plain
Date: Thu, 03 Nov 2005 17:33:39 +1100
Message-Id: <1130999620.4680.28.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: 2.6.14 USB vs. sleep issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For those who experience crashes on sleep and/or wakeup (typically due
to USB) with 2.6.14, I made a test patch that might help. Please let me
know if it makes things more reliable.

http://gate.crashing.org/~benh/fix-ohci-sleep.diff

Note that the patch is totally untested here so it may be just plain
bogus :)

Ben.
