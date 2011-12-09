Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 942C51007D6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2011 15:42:02 +1100 (EST)
Message-ID: <1323405702.19891.7.camel@pasglop>
Subject: Re: linux-next: manual merge of the 4xx tree with the powerpc tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@gmail.com>
Date: Fri, 09 Dec 2011 15:41:42 +1100
In-Reply-To: <CA+5PVA5vVC=e24imM0QxbT10kBAF4v=kwheKs7cOHKKcC+if=A@mail.gmail.com>
References: <20111209123811.12cf28971f21a309976f31bb@canb.auug.org.au>
 <CA+5PVA5vVC=e24imM0QxbT10kBAF4v=kwheKs7cOHKKcC+if=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Tanmay Inamdar <tinamdar@apm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-12-08 at 20:46 -0500, Josh Boyer wrote:
> On Thu, Dec 8, 2011 at 8:38 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi Josh,
> >
> > Today's linux-next merge of the 4xx tree got a conflict in
> > arch/powerpc/platforms/40x/ppc40x_simple.c between commit 11eab297f57b
> > ("powerpc: Add support for OpenBlockS 600") from the powerpc tree and
> > commit d5b9ee7b514e ("powerpc/40x: Add APM8018X SOC support") from the
> > 4xx tree.
> 
> I blame BenH.  I sent him a pull request with d5b9ee7b514e in it
> before he went and updated his tree.  Still not pulled afaik.  Guess
> I'll be rebasing my next branch tomorrow to pick up a series from Tony
> Breeds, unless Ben handles the outstanding pull before I wake up :).

Don't bother rebasing, I can deal with a minor merge conflict like
that :-)

> > I fixed it up (see below) and can carry the fix as necessary.
> 
> Looks correct to me.  Hopefully you won't have to carry it long.
> >
> > [Josh: I have changed you contact address to the above]

Cheers,
Ben.
