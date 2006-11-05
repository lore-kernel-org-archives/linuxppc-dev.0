Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3099D67CDE
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 09:57:06 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id kA5Mufgm028505
	for <linuxppc-dev@ozlabs.org>; Sun, 5 Nov 2006 16:56:42 -0600
Subject: CONFIG_8260_PCI9 question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 09:56:40 +1100
Message-Id: <1162767400.28571.257.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

include/asm-ppc/io.h has a special case for IO macros for when
CONFIG_8260_PCI9 is set.

However, I fail to see in what way those are different from the normal
ones. So I'm about to remove that gratuitous difference.

If I've missed something, please shout now.

Ben.
