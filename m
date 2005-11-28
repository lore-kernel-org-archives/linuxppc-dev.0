Return-Path: <SRS0+a7507532f178560193a5+827+infradead.org+dwmw2@baythorne.srs.infradead.org>
Received: from baythorne.infradead.org (baythorne.infradead.org [81.187.2.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 99366687FD
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Nov 2005 22:29:02 +1100 (EST)
From: David Woodhouse <dwmw2@infradead.org>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20051128110146.ACD2E353F54@atlas.denx.de>
References: <20051128110146.ACD2E353F54@atlas.denx.de>
Content-Type: text/plain
Date: Mon, 28 Nov 2005 11:28:55 +0000
Message-Id: <1133177335.31573.44.camel@baythorne.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Make ARCH=ppc build again with new syscall path
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-11-28 at 12:01 +0100, Wolfgang Denk wrote:
> In message <1133172766.31573.14.camel@baythorne.infradead.org> you wrote:
> >
> > There's also a third option, which _encourages_ people to port their
> > platform without necessarily making it easier: just let arch/ppc break.
> 
> Please don't. This is supposed to be a "stable" kernel tree.

I wouldn't advocate doing it just yet, but I don't think anyone really
expects to see arch/ppc continue until Linus announces 2.7.0. Setting a
cut-off of 2.6.17 or so, or perhaps a point in time when we officially
stop caring about it, would seem a sensible approach.

Neither did I suggest actively breaking it or removing it -- if you feel
strongly about keeping it then I'm sure Paul would accept your patches
to make it keep working, even after others have stopped bothering.

But I think the time and effort required to maintain arch/ppc in
perpetuity should be weighed up against that of just porting the
embedded platforms to arch/powerpc.

It's your choice, of course, but I personally don't think I'll be
submitting many more patches which take arch/ppc into account -- this
one was an exception because it was me who broke it, and it is still a
_little_ too early to be letting it break, IMO. 

-- 
dwmw2
