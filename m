Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/8] pseries: phyp dump: reserve-release proof-of-concept
From: Michael Ellerman <michael@ellerman.id.au>
To: Manish Ahuja <ahuja@austin.ibm.com>
In-Reply-To: <47B145E9.9020907@austin.ibm.com>
References: <4782B985.2090508@austin.ibm.com>
	<47B13D2E.1070001@austin.ibm.com>  <47B145E9.9020907@austin.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-PTEmw3tNYh7CQEf2NcSn"
Date: Tue, 12 Feb 2008 19:48:30 +1100
Message-Id: <1202806110.9738.15.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-PTEmw3tNYh7CQEf2NcSn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Tue, 2008-02-12 at 01:08 -0600, Manish Ahuja wrote:
> Initial patch for reserving memory in early boot, and freeing it later.
> If the previous boot had ended with a crash, the reserved memory would co=
ntain
> a copy of the crashed kernel data.
>=20
> Signed-off-by: Manish Ahuja <mahuja@us.ibm.com>
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
>=20
> ----
>  arch/powerpc/kernel/prom.c                 |   50 ++++++++++++++++++++
>  arch/powerpc/kernel/rtas.c                 |   32 +++++++++++++
>  arch/powerpc/platforms/pseries/Makefile    |    1=20
>  arch/powerpc/platforms/pseries/phyp_dump.c |   71 ++++++++++++++++++++++=
+++++++
>  include/asm-powerpc/phyp_dump.h            |   38 +++++++++++++++
>  include/asm/rtas.h                         |    3 +
   ^^^^^^^^^^^^^^^^^^

asm/rtas.h doesn't exist. You need to clean your tree, and patch
asm-powerpc/rtas.h instead.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-PTEmw3tNYh7CQEf2NcSn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHsV1edSjSd0sB4dIRAphFAJ0bHc6fpJ0uj52uLHZBEzb9F/n1IwCfQnL6
6Jo2juT9TacTq6IH8Ue9Sos=
=AIGn
-----END PGP SIGNATURE-----

--=-PTEmw3tNYh7CQEf2NcSn--
