Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id B177EDDDFB
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 07:52:29 +1000 (EST)
Message-Id: <20070712210156.973038514@arndb.de>
Date: Thu, 12 Jul 2007 23:01:56 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [PATCH 0/5] Kconfig cleanup revisited
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since this was brought up by Mark, here is a resend of the
Kconfig cleanup patches that have not been merged so far,
with updates for the comments I received.

I stumbled over another bug in the process, and fear I have
found a can of worms there (not opened yet): There are
still many files under arch/powerpc that include headers
from include/asm-ppc/. Most of these includes can simply
be removed, but some are real bugs, where generic code still
relies on board-specific macro definitions.

	Arnd <><

--
