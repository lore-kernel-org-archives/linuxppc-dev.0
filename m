Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 42074B7D48
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 27 Apr 2010 20:52:06 +1000 (EST)
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: hs@denx.de
In-Reply-To: <4BD6C0EF.8070904@denx.de>
References: <mailman.1505.1272352353.27723.linuxppc-dev@lists.ozlabs.org>
	<4BD6C0EF.8070904@denx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Apr 2010 20:51:51 +1000
Message-ID: <1272365511.24542.33.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-04-27 at 12:48 +0200, Heiko Schocher wrote:
> Hello Benjamin,
> 
> Benjamin Herrenschmidt wrote:
> > Hi Linus !
> > 
> > PowerPC has been a bit quiet this time around :-) That is until Kumar
> > woke me up with a few fixes and defconfig updates for the freescale
> > embedded platforms.
> 
> I got no comments for the following patch:
> 
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-March/081303.html
> 
> Can this go in?

This is Kumar's call. However, it's definitely not something that can go
in -rc5, we only take grave bugs / regression fixes at this stage. More
like a candidate for -next.

My -next branch is open, so it's up to Kumar to pick that up and send me
something to pull from.

Cheers,
Ben.
