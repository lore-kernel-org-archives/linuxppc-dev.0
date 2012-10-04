Return-Path: <linus971@gmail.com>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
 [74.125.82.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E40962C03A2
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Oct 2012 02:00:37 +1000 (EST)
Received: by mail-we0-f170.google.com with SMTP id x10so406202wey.15
 for <linuxppc-dev@ozlabs.org>; Thu, 04 Oct 2012 09:00:34 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1349339900.4260.10.camel@pasglop>
References: <1349339900.4260.10.camel@pasglop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Oct 2012 09:00:14 -0700
Message-ID: <CA+55aFxbzeNG=sAQvPcE56rEpAbACqM04m2s73BzXVgK+PCnaQ@mail.gmail.com>
Subject: Re: [git pull] Please pull powerpc.git merge branch
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
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

On Thu, Oct 4, 2012 at 1:38 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> First, however, a note about the pull request details ... the diffstat looks
> completely on crack, any idea what's up ? It sees piles of files modified
> in various other archs & generic code but I see no patch in that branch
> that touches any of them.

So this happens if you have "reverse merges" (ie you've pulled my
tree, or some other tree I've pulled), and there is no longer a single
clear common point that you started from. In that case, there is no
simple diff for the "what has changed since that original point", and
to get the diff for the merge you actually have to do the merge and
check the end result. git-request-pull doesn't do that, it just
assumes it's the simple case of some single common point.

The fact that you haven't seen it until now just means that you've
generally done a good job at keeping your powerpc tree "clean" from
other trees, and containing only your own work.

               Linus
