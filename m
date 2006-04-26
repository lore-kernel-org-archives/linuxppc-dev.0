Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: ibmveth: Harden driver initilisation for kexec
From: Michael Ellerman <michael@ellerman.id.au>
To: jgarzik@pobox.com
In-Reply-To: <1143421876.7795.2.camel@localhost.localdomain>
References: <20060131041055.5623C68A46@ozlabs.org>
	<20060131042903.GF28896@krispykreme>  <44074A22.8060705@us.ibm.com>
	<1143421876.7795.2.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-SKjSZuZuzpUdCj3B68We"
Date: Wed, 26 Apr 2006 20:37:17 +1000
Message-Id: <1146047837.10735.29.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc64-dev@ozlabs.org, netdev@vger.kernel.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-SKjSZuZuzpUdCj3B68We
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-03-27 at 12:11 +1100, Michael Ellerman wrote:
> On Thu, 2006-03-02 at 13:40 -0600, Santiago Leon wrote:
> > From: Michael Ellerman <michael@ellerman.id.au>
> >=20
> > After a kexec the veth driver will fail when trying to register with th=
e
> > Hypervisor because the previous kernel has not unregistered.
> >=20
> > So if the registration fails, we unregister and then try again.
> >=20
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > Acked-by: Anton Blanchard <anton@samba.org>
> > Signed-off-by: Santiago Leon <santil@us.ibm.com>
> > ---
> >=20
> >   drivers/net/ibmveth.c |   32 ++++++++++++++++++++++++++------
> >   1 files changed, 26 insertions(+), 6 deletions(-)
>=20
> Looks like this hit the floor. Any chance of getting it into to 2.6.17
> Jeff? AFAICT it should still apply cleanly.

/me knocks politely

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-SKjSZuZuzpUdCj3B68We
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBET01ddSjSd0sB4dIRAgPPAJsE1EjunTZZhgh5asesW2Ol3Khk1wCffK4d
CU2Az5GOxMzhJJrVxpxpVIo=
=Pi34
-----END PGP SIGNATURE-----

--=-SKjSZuZuzpUdCj3B68We--
