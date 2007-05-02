Return-Path: <rene@exactcode.de>
Received: from mx01.qsc.de (mx01.qsc.de [213.148.129.14])
	by ozlabs.org (Postfix) with ESMTP id E84B7DDF9C
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 00:29:43 +1000 (EST)
From: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 0/8] PS3 AV/FB patches
Date: Wed, 2 May 2007 16:03:34 +0200
References: <20070502124830.911142000@pademelon.sonytel.be>
In-Reply-To: <20070502124830.911142000@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705021603.34637.rene@exactcode.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Geert,

On Wednesday 02 May 2007 14:48:30 Geert Uytterhoeven wrote:
>         Hi Linus, Andrew,
>=20
> Here are our patches for the PS3 Audio Video Settings and Virtual Frame
> Buffer
> drivers for 2.6.22:
>=20
> [1/8] ps3fb: thread updates
> [2/8] ps3fb: atomic fixes
> [3/8] ps3av: thread updates
> [4/8] ps3fb: kill superfluous zero initializations
> [5/8] ps3av: misc updates
> [6/8] [PATCH] ps3: Make `ps3videomode -v 0' (auto mode) work again
> [7/8] ps3fb: Use __func__ instead of __FUNCTION__
> [8/8] ps3av: Use __func__ instead of __FUNCTION__
>=20
> The last 3 are new, but they are quite simple/trivial.

while at the ps3fb code I wonder if the initiator of the RSX petition ever =
spoke
with some Sony related kernel hackers regarding allowing any kind of
acceleration:

  http://www.petitiononline.com/RSX/petition.html

While 3d acceleration is not that important for me on the PS3, just specifi=
ng
a exact resolution, to e.g. drive non-TV display, does also not appear to be
possible with the current ps3fb code and the hypervisor, only TV resolutions
are support, right?

Is there any chance we can get at least modesetting and basic 2D accelerati=
on
(best some alpha-bitblt & colorspace conversion + scaling)?

Yours,

=2D-=20
  Ren=E9 Rebe - ExactCODE GmbH - Europe, Germany, Berlin
  http://exactcode.de | http://t2-project.org | http://rene.rebe.name
