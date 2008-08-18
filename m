Return-Path: <michael@ellerman.id.au>
Subject: Re: [MPC7448] machdep_calls
From: Michael Ellerman <michael@ellerman.id.au>
To: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
In-Reply-To: <319b0ac50808180435o4a8e5bebr79f86e17ba2fb9af@mail.gmail.com>
References: <319b0ac50808180145r44a1b64fhd09c038ce45bb206@mail.gmail.com>
	<1219051624.28339.39.camel@pasglop>
	<319b0ac50808180422r504a012djb971bf80e819a6d2@mail.gmail.com>
	<319b0ac50808180435o4a8e5bebr79f86e17ba2fb9af@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-usWkxQXsVbVPMrmu3nRb"
Date: Mon, 18 Aug 2008 22:20:04 +1000
Message-Id: <1219062004.7946.5.camel@localhost>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-usWkxQXsVbVPMrmu3nRb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-08-18 at 13:35 +0200, S=C3=A9bastien Chr=C3=A9tien wrote:
> Can somebody explain me the aim of the function  "setup_arch" in the
> machine_call structure ?

Is this MPC7448 anything like an mpc7448hpc2 ?

If so maybe you should start by looking at the code for it in:

arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c

Even if it's not related, that will give you some idea of what the
callbacks are for.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-usWkxQXsVbVPMrmu3nRb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIqWj0dSjSd0sB4dIRAts5AJ9JsJowLdmPY7/wwwbFvA4lMqHltgCfRS3S
f1lSG2Sd7elCBYgHya3XUhM=
=+w/r
-----END PGP SIGNATURE-----

--=-usWkxQXsVbVPMrmu3nRb--
