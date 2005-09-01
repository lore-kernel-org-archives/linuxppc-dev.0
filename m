Return-Path: <stelian@popies.net>
Received: from sd291.sivit.org (sd291.sivit.org [194.146.225.122])
	by ozlabs.org (Postfix) with ESMTP id EA6546815F
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Sep 2005 06:12:53 +1000 (EST)
From: Stelian Pop <stelian@popies.net>
To: Daniel Drake <dsd@gentoo.org>
In-Reply-To: <431755E4.70703@gentoo.org>
References: <jehdda2tqt.fsf@sykes.suse.de>
	<1125288175.5595.3.camel@localhost.localdomain>
	<1125311951.4662.3.camel@localhost.localdomain>
	<431755E4.70703@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 01 Sep 2005 21:54:54 +0200
Message-Id: <1125604494.3999.7.camel@deep-space-9.dsnet>
Mime-Version: 1.0
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
	Alex Williamson <alex.williamson@hp.com>, linuxppc-dev@ozlabs.org
Subject: Re: 2.6.13-rc7-git2 crashes on iBook
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Le jeudi 01 septembre 2005 à 20:26 +0100, Daniel Drake a écrit :
> Hi,
> 
> Stelian Pop wrote:
> > Confirmed on an Apple Powerbook too.
> > 
> > For reference, the (already reverted) patch which needs to be applied is
> > below.
> > 
> > Signed-off-by: Stelian Pop <stelian@popies.net>
> > 
> > Index: linux-2.6.git/drivers/pci/setup-res.c
[...]

> Sorry for my ignorance. Which tree was this reverted in? You are probably 
> aware that this bug made it into 2.6.13 (patch was not reverted there).

It must be my bad english but I wasn't implying that the patch was
reverted in 2.6.13 but that one should apply it (just apply, without -R,
because I didn't attach the original patch but a reversed version of it)
on a clean 2.6.13 tree in order to make it work. :)

However, a different fix (a real fix, not the workaround proposed above)
was discussed on lkml this week and BenH proposed a patch I haven't had
the chance to test yet (see http://lkml.org/lkml/2005/8/31/1 ).

Stelian.
-- 
Stelian Pop <stelian@popies.net>
