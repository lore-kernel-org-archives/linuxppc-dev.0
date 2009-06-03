Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A33B1DDDE9
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Jun 2009 17:05:40 +1000 (EST)
Date: Wed, 3 Jun 2009 17:05:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] sound/ppc: update annotations of serveral functions
Message-Id: <20090603170536.41c79414.sfr@canb.auug.org.au>
In-Reply-To: <s5hskihyh7m.wl%tiwai@suse.de>
References: <20090603153519.cd7049db.sfr@canb.auug.org.au>
	<s5hskihyh7m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__3_Jun_2009_17_05_36_+1000_jlIl0oQtat7ilvB."
Cc: Jean Delvare <khali@linux-fr.org>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__3_Jun_2009_17_05_36_+1000_jlIl0oQtat7ilvB.
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Wed, 03 Jun 2009 08:17:01 +0200 Takashi Iwai <tiwai@suse.de> wrote:
>
> At Wed, 3 Jun 2009 15:35:19 +1000,
> Stephen Rothwell wrote:
> >=20
> > [I am not sure if this is the correct approach as I don't know if any of
> > this actual hardware or drivers are really hot pluggable.]
>=20
> I thought it can be bound/unbound dynamically via sysfs.

Right.

> Anyway, the patch looks correct, so I applied it now.
> There were still places with __initdata (and one forgotten __init), so
> I fixed them as well.

Thanks for all that.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__3_Jun_2009_17_05_36_+1000_jlIl0oQtat7ilvB.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkomIMAACgkQjjKRsyhoI8yQUgCfZ/zC0fZxhAtX25ZPtVBXtcNZ
flYAnRYf7VXgVPlpivfPoK7kvwZHY4MY
=oUmr
-----END PGP SIGNATURE-----

--Signature=_Wed__3_Jun_2009_17_05_36_+1000_jlIl0oQtat7ilvB.--
