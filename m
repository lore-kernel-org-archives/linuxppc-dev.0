Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BC8B32C03D0
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Oct 2012 06:14:25 +1000 (EST)
Message-ID: <1349381658.4260.53.camel@pasglop>
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 05 Oct 2012 06:14:18 +1000
In-Reply-To: <CA+55aFwf3XcC-SW5D6PouGCKqDRg7k7xbFHaPf-BBqRLa_-FBg@mail.gmail.com>
References: <1349339900.4260.10.camel@pasglop>
 <CA+55aFwf3XcC-SW5D6PouGCKqDRg7k7xbFHaPf-BBqRLa_-FBg@mail.gmail.com>
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

On Thu, 2012-10-04 at 09:02 -0700, Linus Torvalds wrote:
> Hmm. There's nothing there.
> 
> Did you mean for me to pull some branch/tag you didn't mention?

Heh, yeah, the mirrors hadn't updated yet so git request-pull didn't put
the branch name in. It's common but I usually fix it up by hand. Since I
was probably too tired for thinking straight, I forgot that and forgot
to put the proper branch name in the email subject as well... argh :-)

It's in my next branch. Mirrors should be good by now, it's at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git next

Sorry for the misshap.

Cheers,
Ben.
