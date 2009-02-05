Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1354CDDE17
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 15:01:39 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n1541YHV002806
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Feb 2009 22:01:35 -0600
Subject: [ANN] Introducing new "test" branch in powerpc.git tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 05 Feb 2009 15:01:33 +1100
Message-Id: <1233806493.4612.65.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hoy !

So I've been annoyed for some time by the way we do our preparation for
the next merge window. The "next" branch is defined as not being rebased
ever (well, as much as possible), which makes it impossible to just
stash things early in there and rebase if needed, which is a useful
exercise in the weeks leading to the merge window to be able to test
patches, fix them, etc... while keeping a good idea of what's planned to
go in.

Thus I've created a "test" branch. I'll push it out later today with
various things pending. For pulls from sub-maintainers, I'll probably
merge into "next" quickly (ie. a day or two after hitting "test" just
enough time to find gross problems). That will allow me to be more
pro-active also at pulling things off the mailing list and sticking them
there even if some cosmetic changes have been requested to the patch as
I will have no issue rebasing it when the new patch comes in.

Now, one important rule is: test will be reset at the beginning of every
merge window. I will not let it degenerate into the old linuxppc-dev bk
tree that drifted for years and had things that never got merged.

I'm also not sure whether sub-maintainers should do the same thing with
a "test" branch of their own. I certainly don't mind if they rebase
their "next" branches so I'm happy for them to play the same game
directly into their 'next' branch as long as the day they ask me to pull
it into the real 'next', they are reasonably confident that the stuff in
there is stable.

For any complaint, see my secretary in the Oort cloud.

Cheers,
Ben.
