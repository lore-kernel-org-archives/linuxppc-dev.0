Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B3F1D2C012C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 17:06:19 +1000 (EST)
Message-ID: <1343027168.2957.30.camel@pasglop>
Subject: Re: [PATCH] powerpc: Update g5_defconfig
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Mon, 23 Jul 2012 17:06:08 +1000
In-Reply-To: <m2fw8jyn43.fsf@igel.home>
References: <1343011712.2957.5.camel__22210.4697292254$1343011753$gmane$org@pasglop>
 <m2fw8jyn43.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-07-23 at 09:04 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > This updates the g5 defconfig to include nouveau instead of nvidiafb
> > (which works much better nowadays, in fact the latter crashes on modern
> > distros),
> 
> Does it?  Nvidiafb is super stable here, whereas nouveau has a lot of
> problems.

nvidiafb crashes solid here when X gets involved.

What do you mean by "lots of problems" ? I've been using nouveau for a
long time now on my two quad g5's including 3D, gnome-shell etc...
without anything more than a glitch or two on the edge of windows...

Also can you remind me what machine model and what video card variant ?

Cheers,
Ben.
