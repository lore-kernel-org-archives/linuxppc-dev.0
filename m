Return-Path: <johannes@sipsolutions.net>
Subject: Re: RFC: [PATCH Upated]: snd-pmac-gpio interfaces for snd-powermac
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1142553267.14988.39.camel@localhost.localdomain>
References: <1137630485.4425.2.camel@grayson>
	<1142445631.4670.9.camel@localhost>
	<1142553267.14988.39.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-+wuzecirrpptvlwD5uD3"
Date: Fri, 17 Mar 2006 13:57:49 +0100
Message-Id: <1142600269.3905.0.camel@localhost>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-+wuzecirrpptvlwD5uD3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-03-17 at 10:54 +1100, Benjamin Herrenschmidt wrote:

> I think we should only use the pfuncs on k2 (ppc64) or when the macio
> node contains the include-k2-support property. At least, I +think+
> that's what darwin is doing.

According to the comments, yes :)

Been reading through their sources -- damn it's convoluted :(

johannes

--=-+wuzecirrpptvlwD5uD3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARBqyS6Vg1VMiehFYAQJLXQ/+O0yYG54+NXNkTS4xmNMIYZ+o9JCy0Tmx
4+GhGAhKdnfF5c3ttHxDBV+Oe42VtQideSMJFDjpa7tBTQHt2hc/tUz44OBq67mo
3TaVDo4aXuGPjGa/MloAY6A6VZ2ulLNpVnTi/HFyt/8fntTQhIJSWsOhZHVNF9TS
1NUmfWacJQk2HjNeokCcTXA0IXT14No/rfK/d67ywNFfQvowBn6jnfPhTdf/d0It
QkSBqotfpfXVOvZTKIxmauLOUGYcWcQ2h+AbS/dk5ESuMW9HtpDcCJRveqKsu/w0
RNpxSdFgKiAJ9xmx0B1u2M8E0roJ0pYP4AZzVDkevQHLoIlP1OLXISIcXGSlrkX0
43ygN36iiIwPDKahi/a3cejF3bKD6nBE/w9fMZbbvi7c6AVMYgO/RHeLSJUP8vHe
03Pp8trh+l0iQpVGPeV/a2pmFO+FjFFgvlZ66INWCz+MvEJ5Di/0/XNO9sO6Fwje
lVZl/Gsxwafr/Z+ts4KJozFpVizRxOnM+P4t3OIpm9upObU/NtmmY+U/ioeyaZMn
eeD+YWvKR1/LcWiS3Rx7HU3j7iJGFiFuahTuQH7P4U6UwW5tqmX8ilnmiFk6jZ88
xEs4OpIYHcFdKRhU809UL5F7M0cKLm1Ecx8toO4Ks0Zs57h3kXbZ9hBAPopFt0bQ
EuPY2pKn89Y=
=3zl8
-----END PGP SIGNATURE-----

--=-+wuzecirrpptvlwD5uD3--
