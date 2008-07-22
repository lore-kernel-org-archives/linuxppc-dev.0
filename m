Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from lxorguk.ukuu.org.uk (earthlight.etchedpixels.co.uk
	[81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B1D92DE0D9
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 02:17:36 +1000 (EST)
Date: Tue, 22 Jul 2008 16:59:29 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] serial: fix struct uart_info change fallout
Message-ID: <20080722165929.717e38d4@lxorguk.ukuu.org.uk>
In-Reply-To: <20080723014910.7351c495.sfr@canb.auug.org.au>
References: <20080722102520.ca801ab5.sfr@canb.auug.org.au>
	<20080722025850.0d073a5e@lxorguk.ukuu.org.uk>
	<20080722130152.f115224d.sfr@canb.auug.org.au>
	<20080722114436.2c13edea@lxorguk.ukuu.org.uk>
	<20080723014910.7351c495.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I interpreted your "So much for the linux-next tree" as saying "well,
> that has been no help".  I am sorry if I got that wrong.

True it didn't help in the merge that much this time. I don't think that
is a problem with the linux-next tree but one of the lack of tty
maintainer and tty tree letting the confusion occur in the first place -
plus a large quantity of first time around ineptness on my part.

> But my point above is that you had a fix for the current breakage in
> Linus' tree a couple of weeks before you sent the patches to Linus that
> broke the powerpc build (i.e. linux-next did its job) and yet you didn't
> combine the fix with the original patch or send the fix with the original
> patch.  So we end up with a powerpc tree that won't build in the middle
> of the merge window while more powerpc patches are trying to be
> tested ... I understand that this could easily happen because of
> forgetfulness, tiredness or accident.

I really expected to get the rest merged within an hour or two, but then
it broke, then I was travelling and each time I got wireless access to
resync the tree and work on it - it broke again and again and again.

Next time I will bump the patch up the pile and get it out earlier when
that occurs.

Alan
