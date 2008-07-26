Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ADB47DDF5B
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 14:29:29 +1000 (EST)
Subject: Re: [git pull] Please pull from powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0807251734030.4188@nehalem.linux-foundation.org>
References: <1217027473.11188.120.camel@pasglop>
	<alpine.LFD.1.10.0807251734030.4188@nehalem.linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Date: Sat, 26 Jul 2008 14:28:51 +1000
Message-Id: <1217046531.11188.126.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	akpm <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-07-25 at 17:38 -0700, Linus Torvalds wrote:
> 
> On Sat, 26 Jul 2008, Benjamin Herrenschmidt wrote:
> > 
> > Please pull from:
> > ﻿
> > ﻿git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge
> 
> What odd character do you have there before the 'git://' and why?

Hrm... no idea... must be some weirdo evolution thing...

> It cuts-and-pastes into some whitespace that isn't space, and that the 
> shell thus makes part of that word when parsing. It seems to be U+FEFF, 
> which is "zero-width non-break space", but what the heck is the point of 
> that kind of garbage in email?

No idea how it got there.

> Is this some new way for Evolution to screw up?

Quite possibly. I'll do some tests to see if I can reproduce locally...
it could be the result of a key combo that leaves that in the mail but
isn't visible... weird.

Sorry about that,

Cheers,
Ben.
