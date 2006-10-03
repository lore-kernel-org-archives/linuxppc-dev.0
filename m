Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 1F4D367D6C
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 04:30:46 +1000 (EST)
Date: Tue, 3 Oct 2006 22:30:26 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RFC: qe lib code location?
Message-ID: <20061003223026.7b25231a@localhost.localdomain>
In-Reply-To: <724D42AC-3DBA-4B32-8E4A-914441251470@kernel.crashing.org>
References: <724D42AC-3DBA-4B32-8E4A-914441251470@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_=HJEUK.Ac0/q1CS7K6M98Xr";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Kim Phillips <Kim.Phillips@freescale.com>, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_=HJEUK.Ac0/q1CS7K6M98Xr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Oct 2006 11:34:11 -0500
Kumar Gala wrote:

> I was wondering what peoples thought were on having the qe lib code =20
> live in drivers/qe instead of sysdev/qe_lib (with the exception of =20
> the interrupt controller code)
>=20
> Yes, one can argue the cpm code should live in drivers/cpm by this =20
> logic, but lets considered them grandfathered for now.
>=20

My vote to  let it be as it is now. The lib should be generic enough and fo=
r now there are way few QE-enabled designs to declare it generic even insid=
e ppc. Once it virtually become such a thing - nothing will prevent us to m=
ove it to the proper  location IMHO.

Thanks,

-Vitaly

--Sig_=HJEUK.Ac0/q1CS7K6M98Xr
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFIqxCuOg9JvQhSEsRAosNAKCMocwvl5zwM6kAfS+86tKH6UO8sgCeIGDS
I/xu5bmO87Q2GW+TPLCwza0=
=QTga
-----END PGP SIGNATURE-----

--Sig_=HJEUK.Ac0/q1CS7K6M98Xr--
