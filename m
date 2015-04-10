Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 583A91A0176
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 20:38:56 +1000 (AEST)
Message-ID: <1428662335.21137.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pasemi: Only the build the pasemi MSI code for
 PASEMI=y
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 10 Apr 2015 20:38:55 +1000
In-Reply-To: <20150410164208.1cc2a994@canb.auug.org.au>
References: <1428630726-12905-1-git-send-email-mpe@ellerman.id.au>
 <20150410142414.0ea55c4b@canb.auug.org.au>
 <1428643714.30592.4.camel@ellerman.id.au>
 <20150410164208.1cc2a994@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Olof Johannsson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-04-10 at 16:42 +1000, Stephen Rothwell wrote:
> Hi Michael,
> 
> On Fri, 10 Apr 2015 15:28:34 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > Like this?
> > 
> > $ git diff --stat -M HEAD^
> >  arch/powerpc/platforms/pasemi/Makefile                            |  1 +
> >  arch/powerpc/{sysdev/mpic_pasemi_msi.c => platforms/pasemi/msi.c} |  4 +---
> >  arch/powerpc/sysdev/Makefile                                      |  2 +-
> >  arch/powerpc/sysdev/mpic.h                                        | 10 +++++-----
> >  4 files changed, 8 insertions(+), 9 deletions(-)
> 
> Yeah, much easier to see what is going on.  And (I think) the diff
> should work as long as it is only given to "git am" (et al) and not
> "patch".

Yep, which is fine by me.

I've worked out I can pass -M to git-send-email and it will pass it along to
git-format-patch and DTRT.

BUT, I can't work out how to tell git-send-email I *always* want to pass -M, so
I'll probably forget next time :)

cheers
