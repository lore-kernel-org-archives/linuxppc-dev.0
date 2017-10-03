Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5mFt4xmCzDqlT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 15:26:58 +1100 (AEDT)
Date: Tue, 3 Oct 2017 14:36:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/2] powerpc/xive: fix CPU hot unplug
Message-ID: <20171003033615.GA3260@umbus.fritz.box>
References: <20170923082656.27219-1-clg@kaod.org>
 <378a1945-6263-dca7-3912-b4a2c61794b8@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
In-Reply-To: <378a1945-6263-dca7-3912-b4a2c61794b8@kaod.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--DocE+STaALJfprDB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2017 at 06:27:20PM +0200, C=E9dric Le Goater wrote:
> On 09/23/2017 10:26 AM, C=E9dric Le Goater wrote:
> > Hi,
> >=20
> > Here are a couple of small fixes to support CPU hot unplug. There are
> > still some issues to be investigated as, in some occasions, after a
> > couple of plug and unplug, the cpu which was removed receives a 'lost'
> > interrupt. This showed to be the decrementer under QEMU.
>=20
> So this seems to be a QEMU issue only which can be solved by=20
> removing the DEE bit from the LPCR on P9 processor when the CPU=20
> is stopped in rtas. PECE3 bit on P8 processors.=20
>=20
> I think these patches are valuable fixes for 4.14. The first=20
> is trivial and the second touches the common xive part but it
> is only called on the pseries platform. =20
>=20
> Could you please take a look ?

Sorry, I think I've missed something here.

Is there a qemu bug involved in this?  Has there been a patch sent
that I didn't spot?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnTBa0ACgkQbDjKyiDZ
s5JecA//dNmURblPxKiSAJy90XqMSQHi9zE02LgrhlmdyAGNh4WNvb9aIvpdSj40
pajSVuge7KRdbk2mD0XGbnlvmnAYcUJbERKN7yAasz7S0wyPmqExeLU3bLjYfI6q
2h7fFJsNLnIpCcU5ZO7xkDEKEuoTWwIiLSyW5yBxSZgVg8PhsqLI2kPvlEjeOtkt
WLQM3NGXGRMEI1Jh6a9ksR77YtuQOy8Ml0EbtRbblyajisWvpR+fuhPgiBTtF7oE
LKoIDe0f1VOPQTZFupPQ0evoJ1ElnLkFJRaS10Iimjx6ZPb2M+esZk2bb73+wy4s
MebXsf/fEAyjho2LhMIufrkcEK25TzfcXVearEDPRUg8mW03SnU96aRVF/bvL4nf
1cTbxxwR1DlTDbd7cqZgOOkuKZ732ir4uYuTNUZSyxHsqqAe94VIv0mb4VudCd12
nvuXuMr/1GOENFOpwLkNvSO0X5818v/gXBuPazOkgYEEnX4bbEmFfw3R9zfKMut2
kJJarqw6WMo1FAEtFFoFmZ3upGTTlDq+vDdRRcNmWoO65L8rQtmy3R3xA/OwwLP/
u1T3tKFh075Ki/Mtnn9NxNEKwyaUjoTqQGdAuTcSvrjoeasYRpnGnI2nvQBNGX2j
xBxqIHWjrQyB8hSHDRFZ8DTuoDn++5HmPe2fXPVmgNGI+Aw6bjo=
=qB6W
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
