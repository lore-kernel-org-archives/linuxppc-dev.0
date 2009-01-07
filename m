Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 8DDD1DE6D0
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 08:36:20 +1100 (EST)
Date: Thu, 8 Jan 2009 08:36:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH V3 01/17] Squashfs: inode operations
Message-Id: <20090108083609.97f0703a.sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.64.0901071854210.32034@vixen.sonytel.be>
References: <E1LJnJn-0002L2-GZ@dylan.lougher.demon.co.uk>
	<Pine.LNX.4.64.0901071854210.32034@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__8_Jan_2009_08_36_09_+1100_IRCI5g.wNKF4sD4i"
Cc: linux-embedded@vger.kernel.org,
	Phillip Lougher <phillip@lougher.demon.co.uk>, Linux/PPC,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Development <linuxppc-dev@ozlabs.org>, linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__8_Jan_2009_08_36_09_+1100_IRCI5g.wNKF4sD4i
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Wed, 7 Jan 2009 19:00:24 +0100 (CET) Geert Uytterhoeven <Geert.Uytterhoe=
ven@sonycom.com> wrote:
>
> Note that I get lots of
>=20
> | warning: format '%llx' expects type 'long long unsigned int', but argum=
ent 3 has type 'u64'
>=20
> on ppc64, since you switched from `unsigned long long' to 'u64', as `u64'=
 is
> (still -- this is being changed) `unsigned long' on pp64.
>=20
> I guess no action has to be taken, for now?

Correct, as we are in the process of changing u64 to unsigned long long for
powerpc.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__8_Jan_2009_08_36_09_+1100_IRCI5g.wNKF4sD4i
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkllIEkACgkQjjKRsyhoI8z+kACgqYc6WZOOWrsC3r7DIQxcBfZT
ddUAoKQX7RBP6l9WH98d3MgBSQ/3fPDf
=JuME
-----END PGP SIGNATURE-----

--Signature=_Thu__8_Jan_2009_08_36_09_+1100_IRCI5g.wNKF4sD4i--
