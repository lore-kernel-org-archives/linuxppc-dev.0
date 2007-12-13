Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC] ehea: kdump support using new shutdown hook
From: Michael Ellerman <michael@ellerman.id.au>
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20071212170440.GD2359@redhat.com>
References: <200712121753.43543.osstklei@de.ibm.com>
	<20071212170440.GD2359@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-tGfd8eIMJyAvH2YKdVzf"
Date: Thu, 13 Dec 2007 17:30:24 +1100
Message-Id: <1197527424.7695.43.camel@concordia>
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Paul Mackerras <paulus@samba.org>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-tGfd8eIMJyAvH2YKdVzf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-12-12 at 12:04 -0500, Dave Jones wrote:
> On Wed, Dec 12, 2007 at 05:53:43PM +0100, Thomas Klein wrote:
>=20
>  > +static void ehea_update_adapter_handles(struct ehea_adapter *adapter)
>  > +{
>  > +	int i, k;
>  > +	int j =3D 0;
>  > +
>  > +	memset(adapter->res_handles, sizeof(adapter->res_handles), 0);
>=20
> arguments wrong way around.

Remind me why bzero is deprecated again? :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-tGfd8eIMJyAvH2YKdVzf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHYNGAdSjSd0sB4dIRAoFEAJ9QM6YR0cPfq81FGpxCjKh30Q7reACcCJ7i
/EUszDgbpmAvWyZO1o1oXHg=
=jX6N
-----END PGP SIGNATURE-----

--=-tGfd8eIMJyAvH2YKdVzf--
