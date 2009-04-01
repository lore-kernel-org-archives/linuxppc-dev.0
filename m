Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AA305DDDF3
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 11:20:51 +1100 (EST)
Subject: Add hvc_console to MAINTAINERS
From: Michael Ellerman <michael@ellerman.id.au>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1238544253.6522.14.camel@localhost>
References: <49BF956B.9030109@gmail.com>
	<20090330133531.f5d99c09.akpm@linux-foundation.org>
	<20090330205553.GA19278@yoda.jdub.homelinux.org>
	<20090330141852.59baaeda.akpm@linux-foundation.org>
	<20090331132944.GB2332@yoda.jdub.homelinux.org>
	<1238543040.6522.10.camel@localhost>
	<20090331235057.GB563@zod.rchland.ibm.com>
	<1238544253.6522.14.camel@localhost>
Content-Type: text/plain
Date: Wed, 01 Apr 2009 11:20:50 +1100
Message-Id: <1238545250.6522.17.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	roel.kluin@gmail.com, linux-kernel@vger.kernel.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a MAINTAINERS entry for the hypervisor virtual console driver.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

How about this?

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c2ca1d..854437a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1918,6 +1918,12 @@ L:	lm-sensors@lm-sensors.org
 W:	http://www.kernel.org/pub/linux/kernel/people/fseidel/hdaps/
 S:	Maintained
 
+HYPERVISOR VIRTUAL CONSOLE DRIVER
+L:	linuxppc-dev@ozlabs.org
+L:	linux-kernel@vger.kernel.org
+S:	Odd Fixes
+F:	drivers/char/hvc_*
+
 GSPCA FINEPIX SUBDRIVER
 P:	Frank Zago
 M:	frank@zago.net
-- 
1.6.1.2
