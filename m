Return-Path: <torvalds@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7EF87DDF10
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 10:41:28 +1000 (EST)
Date: Fri, 25 Jul 2008 17:38:23 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git pull] Please pull from powerpc.git merge branch
In-Reply-To: <1217027473.11188.120.camel@pasglop>
Message-ID: <alpine.LFD.1.10.0807251734030.4188@nehalem.linux-foundation.org>
References: <1217027473.11188.120.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	akpm <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Sat, 26 Jul 2008, Benjamin Herrenschmidt wrote:
> 
> Please pull from:
> ﻿
> ﻿git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

What odd character do you have there before the 'git://' and why?

It cuts-and-pastes into some whitespace that isn't space, and that the 
shell thus makes part of that word when parsing. It seems to be U+FEFF, 
which is "zero-width non-break space", but what the heck is the point of 
that kind of garbage in email?

Is this some new way for Evolution to screw up?

			Linus
