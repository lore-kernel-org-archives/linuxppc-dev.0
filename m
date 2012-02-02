Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 42D701007D2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2012 13:36:36 +1100 (EST)
Message-ID: <1328150174.28487.100.camel@pasglop>
Subject: [RFC] Removing support for legacy iSeries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Thu, 02 Feb 2012 13:36:14 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Anton Blanchard <anton@au1.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 Paul Mackerras <pmac@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So I (and Stephen) believe the time has come that we get rid of the
legacy iSeries support in the kernel....

Is there any objection ? Do we have any user left ?

The hypervisor on these is really nasty, and removing support for it
would allow us to clean up quite a bit of code path including low level
& asm ones from iSeries special cases.

Also it's becoming increasingly hard for me to test that we are still
capable of booting these.

I will keep it if we have users but since distros don't support it
anymore (and haven't for a while now) I am pretty keen.

Any objection ?

Cheers,
Ben.
