Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C64D679F2
	for <linuxppc-dev@ozlabs.org>; Wed,  4 May 2005 09:53:13 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
In-Reply-To: <20050503083728.3bedc3ef@colin.toulouse>
References: <1115072133.6031.33.camel@gaston>
	<20050503083728.3bedc3ef@colin.toulouse>
Content-Type: text/plain
Date: Wed, 04 May 2005 09:50:56 +1000
Message-Id: <1115164256.7627.57.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	DebianPPC <debian-powerpc@lists.debian.org>
Subject: Re: Laptop sleep & current "git" tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2005-05-03 at 08:37 +0200, Colin Leroy wrote:
> On Tue, 03 May 2005 08:15:33 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> Hi Ben,
> 
> > All my pending patches regarding power management are now upstream in
> > Linus "git" repository. That means I expect those to fix all known
> > issues (with the notable exception of the USB related problems, all of
> > these things aren't yet there but they aren't under my control, so
> > still unplug USB devices).
> 
> All the USB patches from David Brownell that I tracked are in
> git too, including the ehci repower stuff I sent him. I don't have
> issues with these patches applied. Do you?

I have no problem but I didn't see the hub power switching patch on my
git commit logs and it wasn't in linus tree yesterday at least :) I'll
dbl check later today. It's on greg's queue though for sure so it should
be in 2.6.12 hopefully.

Ben.
