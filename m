Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BCCE9DDE0D
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 05:14:48 +1000 (EST)
Date: Wed, 5 Sep 2007 14:14:35 -0500
From: Scott Wood <scottwood@freescale.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 4/4] Add 6xx-style HID0_SLEEP support.
Message-ID: <20070905191435.GA31951@ld0162-tx32.am.freescale.net>
References: <20070712191304.GC31381@ld0162-tx32.am.freescale.net>
	<Pine.LNX.4.60.0709052015490.5113@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0709052015490.5113@poirot.grange>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2007 at 09:12:30PM +0200, Guennadi Liakhovetski wrote:
> On Thu, 12 Jul 2007, Scott Wood wrote:
> 
> > Signed-off-by: Scott Wood <scottwood@freescale.com>
> > ---
> >  arch/powerpc/sysdev/6xx-pm.S |   52 ++++++++++++++++++++++++++++++++++++++++++
> >  arch/powerpc/sysdev/Makefile |    4 +++
> >  include/asm-powerpc/mpc6xx.h |    6 +++++
> >  3 files changed, 62 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/powerpc/sysdev/6xx-pm.S
> >  create mode 100644 include/asm-powerpc/mpc6xx.h
> 
> Hi Scott
> 
> has this patch (series) been pushed in any upstream tree? Don't see it in 
> the current powerpc.git nor in -mm. If I'm right and it's not upstream 
> yet, Paul, what are the plans wrt these patches?

I have a respin coming soon.

-Scott
