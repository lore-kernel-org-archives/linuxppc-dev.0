Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 83E8EDDF91
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 22:50:08 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 14 May 2008 14:50:05 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <s5hr6c5ax6a.wl%tiwai@suse.de>
Message-ID: <20080514125005.312530@gmx.net>
MIME-Version: 1.0
References: <a265241c0805051123h595123edrd46bf65a8099c3c2@mail.gmail.com>
	<6DA6B1DA-11B5-4B89-88AD-561B4D17B33B@kernel.crashing.org>
	<20080505195054.172000@gmx.net>	<1210031058.21644.120.camel@pasglop>
	<20080506075115.269150@gmx.net>	<1210063719.21644.162.camel@pasglop>
	<20080506091622.269180@gmx.net> <s5hr6c5ax6a.wl%tiwai@suse.de>
Subject: Re: ALSA fixes for non-coherent archs (Re: [PATCH] Sam440ep support)
To: Takashi Iwai <tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, cjg@cruxppc.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Wed, 14 May 2008 14:26:53 +0200
> Von: Takashi Iwai <tiwai@suse.de>
> An: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> CC: benh@kernel.crashing.org, galak@kernel.crashing.org, cjg@cruxppc.org, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
> Betreff: ALSA fixes for non-coherent archs (Re: [PATCH] Sam440ep support)

> At Tue, 06 May 2008 11:16:22 +0200,
> Gerhard Pircher wrote:
> > 
> > Naturally I can do some tests, if you or Takashi come up with a new
> > patch.
> 
> OK, here is another patch for testing.  Since I lost my old patch
> somewhere (and it's not worth to dig the archive), I wrote it up
> quickly from scratch.  This version should cover both SG and non-SG
> buffers.  It's against the latest git tree.
Thanks a lot! I'll test it tonight, if I can get the lastest kernel
version running on my A1 (2.6.26-rc1 oopsed already on startup and
Kumar's fixmap patch for highmem seems to break dma-noncoherent.c).

regards,

Gerhard

-- 
249 Spiele für nur 1 Preis. Die GMX Spieleflatrate schon ab 9,90 Euro.
Neu: Asterix bei den Olympischen Spielen: http://flat.games.gmx.de
