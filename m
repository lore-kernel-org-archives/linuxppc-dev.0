Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7222F2C03CF
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Oct 2012 06:11:08 +1000 (EST)
Message-ID: <1349381456.4260.50.camel@pasglop>
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 05 Oct 2012 06:10:56 +1000
In-Reply-To: <CA+55aFxbzeNG=sAQvPcE56rEpAbACqM04m2s73BzXVgK+PCnaQ@mail.gmail.com>
References: <1349339900.4260.10.camel@pasglop>
 <CA+55aFxbzeNG=sAQvPcE56rEpAbACqM04m2s73BzXVgK+PCnaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-10-04 at 09:00 -0700, Linus Torvalds wrote:
> So this happens if you have "reverse merges" (ie you've pulled my
> tree, or some other tree I've pulled), and there is no longer a single
> clear common point that you started from. In that case, there is no
> simple diff for the "what has changed since that original point", and
> to get the diff for the merge you actually have to do the merge and
> check the end result. git-request-pull doesn't do that, it just
> assumes it's the simple case of some single common point.

That was more/less my guess. Thanks.

> The fact that you haven't seen it until now just means that you've
> generally done a good job at keeping your powerpc tree "clean" from
> other trees, and containing only your own work. 

Heh, yeah I try to :-) In this specific case, this was a topic branch
from Bjorn which some pre-requisite patches to the generic PCI code that
Gavin did to allow us to get rid of some custom resource allocation
crap, so the "getting rid of" had a dependency on that topic branch.

Unfortunately, Bjorn had also based that branch on top of some larger
cleanup patch so I ended up pulling that as well from him, which tripped
the whole thing.

Cheers,
Ben.
