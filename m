Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A2B7EDDE0D
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 13:41:20 +1000 (EST)
Subject: Re: Updates to powerpc.git
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080709091846.69b08e34@zod.rchland.ibm.com>
References: <1215588881.8970.358.camel@pasglop>
	<20080709091846.69b08e34@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Sat, 12 Jul 2008 13:32:06 +1000
Message-Id: <1215833526.7549.141.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-07-09 at 09:18 -0400, Josh Boyer wrote:
> 
> If you want to use your master branch as a place for experimental
> stuff, that's fine by me.  But you'll want to keep next separate from
> it so it's as "clean" as possible for those trying to track what is
> definitely going into the next release.

Yes. The idea is that "next" stays clean.

> If it were up to me (which it's not), I would have master just track
> Linus, next track what's going into the next release, and "bleeding"
> or "experimental" track stuff that isn't fully vetted yet.  I might
> start doing that with my tree in the very near future.

Why keeping a branch to track linus in my public tree ? I have plenty of
these locally :-)

> Also, Paul is pretty good about not rebasing his branches when at all
> possible, and I suspect that's why his master and next were often the
> same.  It makes life lots easier for the sub-maintainers and anyone
> trying to track against the tree.  I humbly beg you to keep that
> going.

Yes. I intend to stay on that line, but as I'm new to the job, mistake
are more likely to happen.

Cheers,
Ben.
