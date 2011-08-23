Return-Path: <ospite@studenti.unina.it>
Date: Wed, 24 Aug 2011 00:37:20 +0200
From: Antonio Ospite <ospite@studenti.unina.it>
To: Geoff Levand <geoff@infradead.org>
Subject: Re: [Cbe-oss-dev] [PATCH part1 v2 4/9] Add region 1 memory early
Message-Id: <20110824003720.bc0589b8776467cc42e5d066@studenti.unina.it>
In-Reply-To: <4E54135A.7030509@infradead.org>
References: <1312228986-32307-1-git-send-email-a.heider@gmail.com>
	<1313091073-4572-1-git-send-email-a.heider@gmail.com>
	<1313091073-4572-5-git-send-email-a.heider@gmail.com>
	<4E54135A.7030509@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__24_Aug_2011_00_37_20_+0200_aG9LN7AygmgFbXrT"
Cc: cbe-oss-dev@lists.ozlabs.org, Andre Heider <a.heider@gmail.com>,
	linuxppc-dev@lists.ozlabs.org, Hector Martin <hector@marcansoft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Wed__24_Aug_2011_00_37_20_+0200_aG9LN7AygmgFbXrT
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Aug 2011 13:53:46 -0700
Geoff Levand <geoff@infradead.org> wrote:

[...]
> > =20
> > +	if (!map.r1.size) {
> > +		DBG("%s:%d: no region 1, not adding memory\n",
> > +			__func__, __LINE__);
> > +	} else {
>=20
> Remove brackets around a single line conditional.
>=20
> > +		DBG("%s:%d: adding memory: start %llxh, size %llxh\n",
> > +			__func__, __LINE__, map.rm.size, map.r1.size);
> > +
> > +		memblock_add(map.rm.size, map.r1.size);
> > +		memblock_analyze();
> > +	}
> > +

In Documentation/CodingStyle I read that if [only] one branch is a
single statement then the parenthesis are OK (and even recommended) for
both branches, I guess this is for style consistency. See Chapter 3,
around line 169 on my copy. I guess the wording on that paragraph can
be made more explicit, I'll try to fix that up.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Wed__24_Aug_2011_00_37_20_+0200_aG9LN7AygmgFbXrT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5UK6AACgkQ5xr2akVTsAFVywCfUttzaLP0tUyKMZmQ9Ax7DQNf
dL8AoIj4gElxAhISc97ezPLmDM9M9YSM
=50rU
-----END PGP SIGNATURE-----

--Signature=_Wed__24_Aug_2011_00_37_20_+0200_aG9LN7AygmgFbXrT--
