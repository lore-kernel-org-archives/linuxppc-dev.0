Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 77749DDE20
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 11:51:16 +1100 (EST)
Subject: Re: [Linux-fbdev-devel] [PATCH 1/2] fb: add support for foreign
	endianness
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Valdis.Kletnieks@vt.edu
In-Reply-To: <28238.1203468428@turing-police.cc.vt.edu>
References: <20080205154432.GA8749@localhost.localdomain>
	<20080214224942.a0cb6218.akpm@linux-foundation.org>
	<20080215164542.GB16810@localhost.localdomain>
	<Pine.LNX.4.64.0802171030330.6848@anakin>
	<20080218081847.e9e65f2f.krzysztof.h1@poczta.fm>
	<19805.1203355811@turing-police.cc.vt.edu>
	<47BA162C.5000807@anagramm.de>
	<1203381353.6740.59.camel@pasglop> <47BABD3A.7010102@anagramm.de>
	<20080219040530.7b1d115d.akpm@linux-foundation.org>
	<28238.1203468428@turing-police.cc.vt.edu>
Content-Type: text/plain
Date: Wed, 20 Feb 2008 11:50:04 +1100
Message-Id: <1203468604.7273.7.camel@pasglop>
Mime-Version: 1.0
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com,
	Krzysztof Helt <krzysztof.h1@poczta.fm>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Andrew Morton <akpm@linux-foundation.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-02-19 at 19:47 -0500, Valdis.Kletnieks@vt.edu wrote:
> On Tue, 19 Feb 2008 04:05:30 PST, Andrew Morton said:
> > On Tue, 19 Feb 2008 12:27:54 +0100 Clemens Koller <clemens.koller@anagramm.de
> > wrote:
> > > That's not an issue in my case. The SM50x can be connected to
> > > either an PCI or some Local/CPU-whateverbus IF.
> > > I.e. on the MPC85xx PowerPC, PCI and LocalBus are separate bussses.
> > > If the sm501 is attached to the MPC85xx' PCI like any other video card,
> > > the PCI config-space is can be accessed as usual, whereas the framebuffer
> > > memory area is byte-swapped compared to other common video cards.
> 
> > Anyway, my head is now officially spinning.  Did anyone actually have a
> > reason why we shouldn't proceed with Anton's patch?
> 
> Clemens answered my question regarding the real-life existence of hardware
> that would benefit.  I'd say if Anton's patch works on Clemens' hardware and
> otherwise passes review, we should proceed...

No objection here neither.

Ben.
