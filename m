Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9AFCBB6EE7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2012 14:41:03 +1000 (EST)
Message-ID: <1337661655.2779.167.camel@pasglop>
Subject: Re: powerpc -next rebase WARNING
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 22 May 2012 14:40:55 +1000
In-Reply-To: <1337651473.2779.140.camel@pasglop>
References: <1337651473.2779.140.camel@pasglop>
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

On Tue, 2012-05-22 at 11:51 +1000, Benjamin Herrenschmidt wrote:
> Folks, bad news ... my fault.
> 
> I accidentally forgot a --signoff on a git am command last week, meaning
> that a pair of patches are in -next and not signed off by me.
> 
> For various (legal) reasons that cannot go into Linus tree as-is, so I
> have to rebase the tree to fix it.
> 
> Sorry about that ...

Note that the rebase only affects the top 3 commits, so if your
tree is based on something older you're fine (Kumar, you seem to
be ok, I haven't checked Josh).

Cheers,
Ben.
