Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 06FDD1A01C5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jul 2014 13:54:45 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 463A7140092
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2014 13:54:43 +1000 (EST)
Message-ID: <1406519677.4935.41.camel@pasglop>
Subject: [PATCH] Add Michael Ellerman as powerpc co-maintainer
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Date: Mon, 28 Jul 2014 13:54:37 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael has been backing me up and helping will all aspects of
maintainership for a while now, let's make it official.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
--
Linus: I'll put this patch in powerpc-next, I'm just CC'ing
you so you are aware, in case I'm not available and Michael starts
sending you stuff directly.

diff --git a/MAINTAINERS b/MAINTAINERS
index c43ea88..815cd6f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5357,6 +5357,7 @@ F:	arch/powerpc/boot/rs6000.h
 LINUX FOR POWERPC (32-BIT AND 64-BIT)
 M:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
 M:	Paul Mackerras <paulus@samba.org>
+M:	Michael Ellerman <mpe@ellerman.id.au>
 W:	http://www.penguinppc.org/
 L:	linuxppc-dev@lists.ozlabs.org
 Q:	http://patchwork.ozlabs.org/project/linuxppc-dev/list/
