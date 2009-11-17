Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/4] powerpc: Add Kconfig dependency for PCI_MSI as
	needed by XICS
From: Michael Ellerman <michael@ellerman.id.au>
To: Mel Gorman <mel@csn.ul.ie>
In-Reply-To: <1258459659-11770-2-git-send-email-mel@csn.ul.ie>
References: <1258459659-11770-1-git-send-email-mel@csn.ul.ie>
	<1258459659-11770-2-git-send-email-mel@csn.ul.ie>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-sZ52rn806U0XDPxqubVz"
Date: Tue, 17 Nov 2009 23:40:10 +1100
Message-ID: <1258461610.24093.74.camel@concordia>
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


--=-sZ52rn806U0XDPxqubVz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-11-17 at 12:07 +0000, Mel Gorman wrote:
> It's possible to set CONFIG_XICS without CONFIG_PCI_MSI. When that
> happens, the kernel fails to build with
>=20
> arch/powerpc/platforms/built-in.o: In function `.xics_startup':
> xics.c:(.text+0x12f60): undefined reference to `.unmask_msi_irq'
> make: *** [.tmp_vmlinux1] Error 1
>=20
> This patch adds the dependency in KConfig.

Actually we should ifdef the code instead, XICS doesn't require MSI -
that code chunk just needs to be conditional.

cheers

--=-sZ52rn806U0XDPxqubVz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAksCmakACgkQdSjSd0sB4dKS2gCgmcX8gR4CJhHXWGzg/YpM/XqV
qMQAniqmAKEbm0IDB5u85Rgf9iSmymdo
=v1gr
-----END PGP SIGNATURE-----

--=-sZ52rn806U0XDPxqubVz--
