Return-Path: <michael@ellerman.id.au>
Subject: Re: question on why hvc_console calls hvc_poll() in
	hvc_handle_interrupt().
From: Michael Ellerman <michael@ellerman.id.au>
To: Ryan Arnold <rsa@us.ibm.com>
In-Reply-To: <1145564752.29313.185.camel@localhost.localdomain>
References: <20060418185534.B1ADF679F0@ozlabs.org>
	<1145563391.29313.174.camel@localhost.localdomain>
	<1145564752.29313.185.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-f+ZxoLvmb1d/GNyUyk4M"
Date: Wed, 03 May 2006 17:42:43 +1000
Message-Id: <1146642164.16640.30.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Milton Miller <miltonm@bga.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-f+ZxoLvmb1d/GNyUyk4M
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-04-20 at 15:25 -0500, Ryan Arnold wrote:
> While on the topic of hvc_console; I think I saw a patch go through a
> while ago that added hvc_poll() to hvc_handle_interrupt().  I can't say
> I'm too pleased with that addition.  I did my best to keep locking
> outside of the interrupt handler.
>=20
> I wonder if that change was tested on a power5 lpar system with several
> secondary VSerial Server adapters (hvc1-hvcn) being hammered with data.
> I'm pretty paranoid about deadlock, hence the reason for keeping locking
> out of the int. handler.

That was Milton's patch. No idea whether it's correct/tested.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-f+ZxoLvmb1d/GNyUyk4M
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEWF7zdSjSd0sB4dIRArUtAJ0TsWRb2bSV73GuNNf49fhwsj9OJgCfRTFW
aD+hsWJL78oqf8C8EMEiGk8=
=HcZu
-----END PGP SIGNATURE-----

--=-f+ZxoLvmb1d/GNyUyk4M--
