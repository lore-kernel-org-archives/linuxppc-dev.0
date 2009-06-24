Return-Path: <gerhard_pircher@gmx.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D5384B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 18:46:09 +1000 (EST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id B0FFEDDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 18:46:07 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 24 Jun 2009 10:46:01 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <20090623214224.104620@gmx.net>
Message-ID: <20090624084601.273130@gmx.net>
MIME-Version: 1.0
References: <20090621181855.74980@gmx.net>	<1245623678.16880.27.camel@pasglop>
	<s5h8wjkoi70.wl%tiwai@suse.de> <20090623085554.9200@gmx.net>
	<20090623214224.104620@gmx.net>
Subject: Re: ALSA fixes for non-coherent ppc32 again
To: tiwai@suse.de, benh@kernel.crashing.org
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
> Datum: Tue, 23 Jun 2009 23:42:24 +0200
> Von: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> An: benh@kernel.crashing.org, tiwai@suse.de
> CC: linuxppc-dev@ozlabs.org
> Betreff: Re: ALSA fixes for non-coherent ppc32 again

> Okay, that's wrong. I somehow messed up the .config file. It doesn't
> compile, too.
I got it to compile now and it seems to work fine. I overlooked a typo
in sound/core/Makefile first (ifndef CONFIG_SND_NONCOHERNT_DMA.)
                                                        ^
I vote for a merge, if the config option and the typo is fixed. Ben,
should I resend a properly formatted patch for the dma_mmap_coherent
implementation or can we take the patch I already sent?

Thanks!

Gerhard

-- 
GRATIS für alle GMX-Mitglieder: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01
