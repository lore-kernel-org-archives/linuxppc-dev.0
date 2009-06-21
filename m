Return-Path: <gerhard_pircher@gmx.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CE7E0B7188
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Jun 2009 04:19:03 +1000 (EST)
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id A15E9DDD1C
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Jun 2009 04:19:01 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Sun, 21 Jun 2009 20:18:55 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Message-ID: <20090621181855.74980@gmx.net>
MIME-Version: 1.0
Subject: ALSA fixes for non-coherent ppc32 again
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Takashi Iwai
	<tiwai@suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Takashi Iwai posted patches to make ALSA work on non-coherent PPC32
systems (almost exactly) a year ago. See here:
http://www.nabble.com/-PATCH-0-3--ALSA-fixes-for-non-coherent-ppc32-to17980027.html#a17980027

As far as I can see these patches never went upstream. Where there any
objections or did we just forget about them? It would be cool, if the
patches could be merged now, as at least two platforms need this bugfix
(namely Sam440 and AmigaOne).

Thanks!

Gerhard

-- 
GRATIS für alle GMX-Mitglieder: Die maxdome Movie-FLAT!
Jetzt freischalten unter http://portal.gmx.net/de/go/maxdome01
