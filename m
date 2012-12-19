Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 941332C0090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2012 10:10:21 +1100 (EST)
Message-ID: <1355958613.5397.54.camel@pasglop>
Subject: Re: [git pull] Please pull powerpc.git next branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Dec 2012 10:10:13 +1100
In-Reply-To: <CA+55aFw-cRskrvW07FVJd9HfrBhn41Ogi1Vv_v1U12zahzFu=A@mail.gmail.com>
References: <1355517897.19932.136.camel@pasglop>
 <1355787094.5397.30.camel@pasglop>
 <CA+55aFw-cRskrvW07FVJd9HfrBhn41Ogi1Vv_v1U12zahzFu=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-12-18 at 10:02 -0800, Linus Torvalds wrote:

> Anyway, I've pulled it in, but got a conflict on the kernel_thread
> cleanups from Al. And since the conflict was in the powerpc assembly
> code that I don't really know the details of, I did the
> straightforward resolve of it, but I'd like you to check it out.
> 
> (I haven't pushed it out yet, I'm waiting for the allmodconfig to
> finish compiling, so if you see this email quickly, but don't see the
> powerpc merge yet, just wait a few minutes)

Sorry for the delay, I verified that it looked right yesterday but
didn't manage to actually test it until today due to a problem with our
test farm. It's all good, thanks !

Cheers,
Ben.
