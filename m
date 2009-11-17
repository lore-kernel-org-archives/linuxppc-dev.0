Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 3/4] powerpc: Only define smp_pSeries_cpu_bootable when
	CONFIG_XICS is set
From: Michael Ellerman <michael@ellerman.id.au>
To: Mel Gorman <mel@csn.ul.ie>
In-Reply-To: <1258459659-11770-4-git-send-email-mel@csn.ul.ie>
References: <1258459659-11770-1-git-send-email-mel@csn.ul.ie>
	<1258459659-11770-4-git-send-email-mel@csn.ul.ie>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-CweUSIc5Y+xPFs3kT+Jg"
Date: Tue, 17 Nov 2009 23:47:04 +1100
Message-ID: <1258462024.24093.79.camel@concordia>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-CweUSIc5Y+xPFs3kT+Jg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-11-17 at 12:07 +0000, Mel Gorman wrote:
> If CONFIG_XICS is set, then smp_pSeries_cpu_bootable() is unnecessary.
> As warnings are treated as errors, this fails to build.
>=20
> This patch only defines smp_pSeries_cpu_bootable() when CONFIG_XICS is
> set.

I'm not sure, but I would guess that was just an oversight by whoever
added the cpu_bootable check. By which I mean it should be in the mpic
ops as well - avoiding the need for any ifdefery.

cheers


--=-CweUSIc5Y+xPFs3kT+Jg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAksCm0gACgkQdSjSd0sB4dKX1wCfdaDspIvaQjUJD3xjRCf2XNov
xdkAoIrv/pqArTH3GwehfM+QqM8JG2h9
=PO41
-----END PGP SIGNATURE-----

--=-CweUSIc5Y+xPFs3kT+Jg--
