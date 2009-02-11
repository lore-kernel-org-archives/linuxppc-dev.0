Return-Path: <michael@ellerman.id.au>
Subject: Re: request_irq return errno 38
From: Michael Ellerman <michael@ellerman.id.au>
To: Vijay Nikam <vijay.t.nikam@gmail.com>
In-Reply-To: <f234e2140902110141l52550ceem664f57f697bd48e0@mail.gmail.com>
References: <f234e2140902110043i5a4aefb5yb635bc32b9653943@mail.gmail.com>
	<1234343703.9778.13.camel@localhost>
	<f234e2140902110141l52550ceem664f57f697bd48e0@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-1YqAPNX5hKhrxgkADLgo"
Date: Wed, 11 Feb 2009 20:54:32 +1100
Message-Id: <1234346072.9778.20.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-1YqAPNX5hKhrxgkADLgo
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-02-11 at 15:11 +0530, Vijay Nikam wrote:
> Thanks for your prompt reply ...
>=20
> I am using kernel version 2.6.20 ...

OK, that kernel has the irq remapping stuff.

> May I know what raw IRQ means ? ? ? and what is the reason I cant map
> raw_irq_number ???

Sorry, that's not the best terminology.

I guess the right name is hardware irq number.

You can't map it because the kernel keeps a mapping between hardware irq
numbers and virtual irq numbers. request_irq() expects a virtual irq
number.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-1YqAPNX5hKhrxgkADLgo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmSoFgACgkQdSjSd0sB4dL4rACcC2d+8GOfVHR+YqkVSlY0bXlU
NMoAoIU5TcRTsyxvoax5ADN9nN5VLKSd
=qKlT
-----END PGP SIGNATURE-----

--=-1YqAPNX5hKhrxgkADLgo--
