Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id CFD7F67B79
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 18:04:58 +1000 (EST)
Date: Fri, 22 Sep 2006 12:04:50 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/11] Add support for QE and 8360EMDS board
Message-ID: <20060922120450.259c136d@localhost.localdomain>
In-Reply-To: <360F0BE4-6E0B-47EB-8A6C-0640F167FF82@kernel.crashing.org>
References: <451282DA.2080508@freescale.com>
	<360F0BE4-6E0B-47EB-8A6C-0640F167FF82@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_PAO22m=cLwNGGzd._OsV+Ul";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_PAO22m=cLwNGGzd._OsV+Ul
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Sep 2006 00:01:50 -0500
Kumar Gala wrote:

>=20
> On Sep 21, 2006, at 7:17 AM, Li Yang wrote:
>=20
> > The series of patches add generic QE infrastructure called
> > qe_lib, and MPC8360EMDS board support.  Qe_lib is used by
> > QE device drivers such as ucc_geth driver.
> >
> > This version updates QE interrupt controller to use new irq
> > mapping mechanism ,addresses all the comments received with
> > last submission and includes some style fixes.
>=20
> Wasn't there a patch for the docs that described the QE additions to =20
> the flat dev tree?
>=20
Yes, there was one,=20
but this time I will submit it together with cpm stuff in addition to QE,
once I'll validate that 8xx does not need anything defined but undocumented.

--
Sincerely, Vitaly

--Sig_PAO22m=cLwNGGzd._OsV+Ul
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFE5kiuOg9JvQhSEsRAgNPAJ453qoKs4mjhRkSoKSlO5a3NDOrXACdHdwe
zq23rdjVm149Jeme9UGevak=
=ol2g
-----END PGP SIGNATURE-----

--Sig_PAO22m=cLwNGGzd._OsV+Ul--
