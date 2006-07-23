Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2E434679A6
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Jul 2006 07:37:49 +1000 (EST)
Subject: RE: AltiVec in the kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: matt@genesi-usa.com
In-Reply-To: <006701c6ae5b$d5e83620$7302a8c0@bakuhatsu.net>
References: <006701c6ae5b$d5e83620$7302a8c0@bakuhatsu.net>
Content-Type: text/plain
Date: Sun, 23 Jul 2006 17:37:29 -0400
Message-Id: <1153690649.10431.26.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: 'Olof Johansson' <olof@lixom.net>,
	'linuxppc-dev list' <linuxppc-dev@ozlabs.org>,
	'Paul Mackerras' <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I remember a discussion from one of the Gentoo guys wanting to do this
> with libfreevec.
> 
> Getting into Gentoo, though, is not difficult. The problem with this
> is Gentoo is one Linux distribution. I would be more impressed if code
> was in Debian or Ubuntu considering their exhausting lead times on
> producing new package trees and accepting new code :D

It seems to me that the "problem" just doesn't exist at the moment...
libfreevec is nice, but it's unfinished, and the author is away for now
and thus not able to complete nor work on a port to glibc or others.

Once he's back, of course, it would be nice to have him complete the
work (and maybe get some outside help).

I'd like to also verify his methodology for measuring the performance
improvements, I'm not saying it's wrong, I want to make sure some of the
overhead of enabling altivec has been properly measured for various
usage patterns and thus possibly restrict the optimisations to patterns
where that matter, as an example, only use altivec for large memcpy's.

Once that's done, I don't see any good reason why it would be so hard to
include that work into glibc, or rather into the powerpc add-ons in a
first step and maybe then the whole into glibc. Maintainers rarely
rejects things just for the sake of doing so. If they do so, they
usually provide reasons, often boiling to implementation details, than
can then be fixed. Note also that in the case of submitting code to
glibc, there is a copyright assignment issue to be sorted out I think (I
don't know the details here).

I have the feeling that there is very little point to this thread. Let's
wait for Konstantinos to be back and submit his work, possibly to this
list at first for review, tests, etc... and then to the appropriate
maintainers. If there is a problem at that point, then we'll see how we
can address it.

Regards,
Ben.
