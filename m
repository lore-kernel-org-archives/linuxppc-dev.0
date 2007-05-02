Return-Path: <rene@exactcode.de>
Received: from mx01.qsc.de (mx01.qsc.de [213.148.129.14])
	by ozlabs.org (Postfix) with ESMTP id F1EFDDDF1B
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 01:06:07 +1000 (EST)
From: =?utf-8?q?Ren=C3=A9_Rebe?= <rene@exactcode.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [patch 0/8] PS3 AV/FB patches
Date: Wed, 2 May 2007 17:05:56 +0200
References: <20070502124830.911142000@pademelon.sonytel.be>
	<200705021603.34637.rene@exactcode.de>
	<Pine.LNX.4.62.0705021650290.3706@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0705021650290.3706@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200705021705.57402.rene@exactcode.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi again,

On Wednesday 02 May 2007 16:53:49 Geert Uytterhoeven wrote:
> 	Hi Ren=E9,
>=20
> On Wed, 2 May 2007, [iso-8859-1] Ren=E9 Rebe wrote:
> > While 3d acceleration is not that important for me on the PS3, just spe=
cifing
> > a exact resolution, to e.g. drive non-TV display, does also not appear =
to be
> > possible with the current ps3fb code and the hypervisor, only TV resolu=
tions
> > are support, right?
>=20
> In addition to the TV resolutions 480i/480p/720p/1080i/1080p in 50/60 Hz,
> ps3fb supports 1280x768 (WXGA), 1280x1024 (SXGA), and 1920x1200 (WUXGA).

Ok fair enough I forgot to mention the {W,S}XGA ones - actually after the s=
tatic list
of the user-land helper I read the kernel side code already to see if there=
 is something
else that can be passed to the hypervisor.

I mean more the currently also common modes such as: 1680x1050 and co.

> > Is there any chance we can get at least modesetting and basic 2D accele=
ration
> > (best some alpha-bitblt & colorspace conversion + scaling)?
>=20
> These requests are definitely considered.

Nice to hear. I keep pressing my thumbs.

Yours,

=2D-=20
  Ren=C3=A9 Rebe - ExactCODE GmbH - Europe, Germany, Berlin
  http://exactcode.de | http://t2-project.org | http://rene.rebe.name
