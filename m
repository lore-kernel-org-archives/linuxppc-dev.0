Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 336D667B93
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Dec 2006 06:45:35 +1100 (EST)
Date: Fri, 1 Dec 2006 22:45:16 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: Re: fs_enet driver "generating" bad interrupts on 2.6.19
Message-ID: <20061201224516.70206c49@localhost.localdomain>
In-Reply-To: <200612011418.26201.laurent.pinchart@tbox.biz>
References: <200612011418.26201.laurent.pinchart@tbox.biz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_r46zsStzMw39OQovx_VD6q0;
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Sig_r46zsStzMw39OQovx_VD6q0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Dec 2006 14:18:26 +0100
Laurent Pinchart wrote:

>=20
> The problem wasn't visible with the 2.6.18 kernel. The number of bad=20
> interrupts didn't increase with outbound FCC traffic.
>=20
> Has anyone noticed the same problem ?
>=20
So, not reproduced on 8272ads and 8560ads FCC's with current kernel.
They are arch/powerpc though.

Bad irq's may be relevant to the fact that ppc/ has some cascaded IRQ's tha=
t were not adopted to genirq rework,=20
but that should be expressed in 2.6.18 too....

--
Sincerely, Vitaly

--Sig_r46zsStzMw39OQovx_VD6q0
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFcIZNuOg9JvQhSEsRAhB+AJ9TZP/Afcd9wDw2rX9UL0GDgNYAoACeK08T
9NVrMbHAsAxdUE1lVK936sw=
=keCo
-----END PGP SIGNATURE-----

--Sig_r46zsStzMw39OQovx_VD6q0--
