Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8FD932C00A1
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jan 2014 21:28:15 +1100 (EST)
Message-ID: <1389781680.6933.88.camel@pasglop>
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 Jan 2014 21:28:00 +1100
In-Reply-To: <CA+55aFyfY5kEezwx8-jhgdgOX+EG__v3QRZmGnGstDpUP-UVWQ@mail.gmail.com>
References: <1389762075.6933.76.camel@pasglop>
 <CA+55aFyfY5kEezwx8-jhgdgOX+EG__v3QRZmGnGstDpUP-UVWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-01-15 at 15:05 +0700, Linus Torvalds wrote:
> On Wed, Jan 15, 2014 at 12:01 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> >
> > My original intend was to put it in powerpc-next and then shoot it to
> > stable, but it got a tad annoying (due to churn it needs to be applied
> > at least on rc4 or later while my next is at rc1 and clean that way), so
> > I put it in the merge branch.
> 
> Quite frankly, I'll prefer to not merge it now, and then 3.13 will get
> it from stable, when it does things like this.
> 
> Partly because it fixes a power-only bug, but potentially changes
> non-power behavior. If it was all in arch/powerpc, I wouldn't mind.

Right, I wasn't too comfortable either. I'll resend the pull request
after the merge window is open.

Cheers,
Ben.

>                Linus
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
