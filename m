Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B31D7B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2012 11:51:20 +1000 (EST)
Message-ID: <1337651473.2779.140.camel@pasglop>
Subject: powerpc -next rebase WARNING
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 22 May 2012 11:51:13 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Folks, bad news ... my fault.

I accidentally forgot a --signoff on a git am command last week, meaning
that a pair of patches are in -next and not signed off by me.

For various (legal) reasons that cannot go into Linus tree as-is, so I
have to rebase the tree to fix it.

Sorry about that ...

Cheers,
Ben.
