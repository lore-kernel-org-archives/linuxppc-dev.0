Date: Sat, 4 Oct 2003 14:48:57 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Typo fix in 2.6.0-test5
In-Reply-To: <1065192807.23151.19.camel@gaston>
Message-ID: <Pine.LNX.4.44.0310041440130.15962-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > > Also, include/video/macmodes.h is missing (used by matroxfb).
> > >
> > > Is it in the bk tree as of then (can be checked via web pages)?
> >
> > Nope. Missing in the 2.5 devel bk tree as well. It might be by design, and
> > matroxfb is really what's broken, though.
>
> No, it's not missing afaik, it's just not where matroxfb is looking for

My fault - I thought I'd looked for it there, but missed it. Trivial patch
attached.

Other than that, no compile problems. Boots on my Lombard, will give it a
test on our iMac next.

--- drivers/video/matrox/matroxfb_base.h.org	2003-10-04 14:43:06.000000000 +0200
+++ drivers/video/matrox/matroxfb_base.h	2003-10-04 14:44:46.000000000 +0200
@@ -55,7 +55,7 @@
 #if defined(CONFIG_PPC_PMAC)
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
-#include <video/macmodes.h>
+#include "../macmodes.h"
 #endif

 /* always compile support for 32MB... It cost almost nothing */

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
