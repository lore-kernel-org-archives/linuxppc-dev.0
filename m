Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 82EA82C00B6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 16:39:39 +1100 (EST)
Message-ID: <1386653965.32037.61.camel@pasglop>
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 10 Dec 2013 16:39:25 +1100
In-Reply-To: <CA+55aFz_VXtkX0vH+T2kGpzA90Zqys=_quJFq3fGT68YTCnBtw@mail.gmail.com>
References: <1386640667.32037.53.camel@pasglop>
 <CA+55aFz_VXtkX0vH+T2kGpzA90Zqys=_quJFq3fGT68YTCnBtw@mail.gmail.com>
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

On Mon, 2013-12-09 at 19:58 -0800, Linus Torvalds wrote:
> On Mon, Dec 9, 2013 at 5:57 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> >
> > Here are a handful of powerpc fixes for 3.13.
> 
> Grr.
> 
> I've pulled it, but looking at that history, it's just pure and utter
> f*cking garbage.
> 
> It was rebased *minutes* before sending it, as far as I can tell. Why?

It was *created* shortly before sending it:

Basically I put that thing together as a patchwork bundle which I grew
over this week.

Today I just applied them to my git, ran my build testers, booted a
machine to dbl check and sent. I tend to not let things linger long in
git when it's just fixes like that.

> And it has a pointless merge that you must have created with "--no-ff"
> for no apparent good reason.

Oh that's my fault. I thought you preferred that way to keep track of
cases where I pull from somebody since then the patch don't have my
s-o-b... my bad for misunderstanding that part of the process.

> WTF? What the hell happened here, and why? As mentioned, it's in my
> tree, but I was *this* close to just unpulling and saying "fuck that"
> when I started looking at it.

Heh sorry.

Cheers,
Ben.

> 
>               Linus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
