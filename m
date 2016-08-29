Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sNQlf48jGzDrh3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Aug 2016 08:08:46 +1000 (AEST)
Message-ID: <1472508517.2388.9.camel@kernel.crashing.org>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-4.8-4 tag
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc dev
 list <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 30 Aug 2016 08:08:37 +1000
In-Reply-To: <CA+55aFwo321H+EYjOuwhfJvrn+vbfoT0fV8TMHSy2C0BYSD+EA@mail.gmail.com>
References: <1472445840.2889.99.camel@kernel.crashing.org>
 <CA+55aFwo321H+EYjOuwhfJvrn+vbfoT0fV8TMHSy2C0BYSD+EA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-08-29 at 12:15 -0700, Linus Torvalds wrote:
> On Sun, Aug 28, 2016 at 9:44 PM, Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> > 
> > 
> > This is my first signed-tag and use of 2fa so I hope I got it all right...
> > I tried to use the same format Michael uses for the tag etc...
> 
> The signature all looks fine, but when the contents of the tag are
> just the same git information that you can get from git itself, it's
> not useful as a merge message. So I prefer the actual high-level "what
> changed" message instead:
> 
> > 
> > We have some misc fixes for powerpc 4.8. Some trivial bits and some
> > regressions, and a trivial cleanup or two that I saw no point in letting
> > rot in patchwork.
> 
> .. although optimally with a *bit* more detail.
> 
> Anyway, pulled.

Ok. Will fix that next time.

Cheers,
Ben.
