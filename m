Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 238A9DDEF2
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 09:54:58 +1000 (EST)
Date: Sun, 22 Jul 2007 09:55:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] Fix tas_suspend/resume build warning
Message-Id: <20070722095505.faa33dba.sfr@canb.auug.org.au>
In-Reply-To: <1185038966.868.5.camel@johannes.berg>
References: <20070722002937.11e234f8.sfr@canb.auug.org.au>
	<1185038966.868.5.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__22_Jul_2007_09_55_05_+1000_S5myAM.yt.h79Fzk"
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__22_Jul_2007_09_55_05_+1000_S5myAM.yt.h79Fzk
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 21 Jul 2007 19:29:26 +0200 Johannes Berg <johannes@sipsolutions.net=
> wrote:
>
> On Sun, 2007-07-22 at 00:29 +1000, Stephen Rothwell wrote:
> > sound/aoa/codecs/snd-aoa-codec-tas.c:750: warning: 'tas_suspend' define=
d but not used
> > sound/aoa/codecs/snd-aoa-codec-tas.c:760: warning: 'tas_resume' defined=
 but not used
>=20
> Heh. I daresay I never compiled a kernel without PM. Not sure why you'd
> want to, but still good to have it fixed. Thanks.

Thats was a PowerPC ppc64_defconfig build.  Why that has CONFIG_PM not set =
is anyone's guess :-)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__22_Jul_2007_09_55_05_+1000_S5myAM.yt.h79Fzk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGopzeTgG2atn1QN8RAoIlAJ4yhOc/DGdHTCveA/5/IiZ7QVPV1ACeKR2U
SHkqfhDEDkvVD2YKQu3bwWE=
=FnDI
-----END PGP SIGNATURE-----

--Signature=_Sun__22_Jul_2007_09_55_05_+1000_S5myAM.yt.h79Fzk--
