Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D11BFDDE08
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 19:16:24 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 06 May 2008 11:16:22 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1210063719.21644.162.camel@pasglop>
Message-ID: <20080506091622.269180@gmx.net>
MIME-Version: 1.0
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>	
	<6DA6B1DA-11B5-4B89-88AD-561B4D17B33B@kernel.crashing.org>	
	<20080505195054.172000@gmx.net> <1210031058.21644.120.camel@pasglop>	
	<20080506075115.269150@gmx.net> <1210063719.21644.162.camel@pasglop>
Subject: Re: [PATCH] Sam440ep support
To: benh@kernel.crashing.org
Cc: tiwai@suse.de, linuxppc-dev@ozlabs.org, cjg@cruxppc.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Tue, 06 May 2008 18:48:39 +1000
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: linuxppc-dev@ozlabs.org, Takashi Iwai <tiwai@suse.de>, cjg@cruxppc.org, galak@kernel.crashing.org
> Betreff: Re: [PATCH] Sam440ep support

> 
> On Tue, 2008-05-06 at 09:51 +0200, Gerhard Pircher wrote:
> > Takashi Iwai posted a preliminary patch a long time ago. I tested it
> > on my machine and it failed with non coherent scatter-gather DMA
> > allocations (I guess almost all ALSA PCI drivers use SG DMA?).
> 
> How does Alsa allocate such SG ?
I can't answer this question. *ducked* :-) Takashi?

FYI: I posted the results of the test with Takashi's dma_mmap_coherent
patch here:
http://ozlabs.org/pipermail/linuxppc-dev/2006-June/024078.html

On the other side it looks like this problem does not only affect ALSA.
As far as I can tell also some V4L(2) drivers have a problem with mmaping
non coherent DMA allocations, but I'm not sure (it's a long time since I
did some tests with video cards on my AmigaOne).

Naturally I can do some tests, if you or Takashi come up with a new
patch.

Thanks!

Gerhard

-- 
GMX startet ShortView.de. Hier findest Du Leute mit Deinen Interessen!
Jetzt dabei sein: http://www.shortview.de/?mc=sv_ext_mf@gmx
