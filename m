Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CEC3BDE100
	for <linuxppc-dev@ozlabs.org>; Sun, 24 May 2009 16:38:12 +1000 (EST)
Subject: Re: mpc8315e-rdb: pci_enable_msi() fails (using today's
	galak/powerpc.git tree)
From: Michael Ellerman <michael@ellerman.id.au>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
In-Reply-To: <c384c5ea0905231512u72894e34g17746548e640d4fe@mail.gmail.com>
References: <c384c5ea0905231358t4803fbc6gf54618b2839a448a@mail.gmail.com>
	<c384c5ea0905231512u72894e34g17746548e640d4fe@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-e+v5y4I+8MwMO+hRXr4g"
Date: Sun, 24 May 2009 16:38:11 +1000
Message-Id: <1243147091.27293.3.camel@concordia>
Mime-Version: 1.0
Cc: Linux PPC <linuxppc-dev@ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-e+v5y4I+8MwMO+hRXr4g
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2009-05-24 at 00:12 +0200, Leon Woestenberg wrote:
> Hello,
>=20
> On Sat, May 23, 2009 at 10:58 PM, Leon Woestenberg
> <leon.woestenberg@gmail.com> wrote:
> > using this tree: git://git.kernel.org/pub/scm/linux/kernel/git/galak/po=
werpc.git
> >
> > pci_enable_msi() fails on my MPC8315E-RDB board with PCIe device in

<snip good bug report>

'lspci -vvv' of the device in question is often useful too.

cheers


--=-e+v5y4I+8MwMO+hRXr4g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoY61MACgkQdSjSd0sB4dIszgCfSZwTcpPgmZmKUhch7m3SIqyJ
9GgAoJiWfHusf2xDl0Q/xen/vc4S7d8w
=aT5v
-----END PGP SIGNATURE-----

--=-e+v5y4I+8MwMO+hRXr4g--
