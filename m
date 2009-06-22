Return-Path: <gerhard_pircher@gmx.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8587BB7150
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Jun 2009 19:23:40 +1000 (EST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 4590FDDD1C
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2009 19:23:38 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Mon, 22 Jun 2009 11:23:34 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <s5h8wjkoi70.wl%tiwai@suse.de>
Message-ID: <20090622092334.123270@gmx.net>
MIME-Version: 1.0
References: <20090621181855.74980@gmx.net>	<1245623678.16880.27.camel@pasglop>
	<s5h8wjkoi70.wl%tiwai@suse.de>
Subject: Re: ALSA fixes for non-coherent ppc32 again
To: Takashi Iwai <tiwai@suse.de>, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Mon, 22 Jun 2009 09:12:35 +0200
> Von: Takashi Iwai <tiwai@suse.de>
> An: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Gerhard Pircher <gerhard_pircher@gmx.net>, linuxppc-dev@ozlabs.org
> Betreff: Re: ALSA fixes for non-coherent ppc32 again

> At Mon, 22 Jun 2009 08:34:38 +1000,
> Benjamin Herrenschmidt wrote:
> > 
> > On Sun, 2009-06-21 at 20:18 +0200, Gerhard Pircher wrote:
> > > Hi,
> > > 
> > > Takashi Iwai posted patches to make ALSA work on non-coherent PPC32
> > > systems (almost exactly) a year ago. See here:
> > >
> > > http://www.nabble.com/-PATCH-0-3--ALSA-fixes-for-non-coherent-ppc32-to17980027.html#a17980027
> > > 
> > > As far as I can see these patches never went upstream. Where there
> > > any objections or did we just forget about them? It would be cool,
> > > if the patches could be merged now, as at least two platforms need
> > > this bugfix (namely Sam440 and AmigaOne).
> > 
> > I definitely forgot about those...
> 
> Me, too, almost... :)
:)

> > But I'm fine with what Takashi did
> > for now, I can always make the powerpc helper for dma_mmap_coherent()
> > smarter later on if necessary.
> 
> I updated the patch series for 2.6.31, including sparc32, parisc, mips
> and sh support.  The patches are found in test/dma-fix branch of sound
> git tree:
>  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> test/dma-fix
Thanks!

> The old patches for 2.6.30 is found at history/dma-fix-2.6.30 branch
> there, too.
> 
> 
> For merging to the upstream, we'll need definitely discussions on
> linux-arch ML or so, as once James Bottomley suggested.  I'll try to
> make it up once after the merge window.
> 
> But, it'd be helpful if someone can test the patches above beforehand,
> of course :)
Sure, I'll give it a try until tomorrow.

Gerhard

-- 
GRATIS für alle GMX-Mitglieder: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01
