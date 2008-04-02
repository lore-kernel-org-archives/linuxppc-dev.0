Return-Path: <johannes@sipsolutions.net>
Subject: Re: [RFC/PATCH] powerpc: Add irqtrace support to 32-bit powerpc
From: Johannes Berg <johannes@sipsolutions.net>
To: Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <20080201195040.GA8950@farnsworth.org>
	(sfid-20080201_205114_032143_11799746)
References: <20080201195040.GA8950@farnsworth.org>
	(sfid-20080201_205114_032143_11799746)
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-DlV6z0zXAH7DU/TcU3vi"
Date: Wed, 02 Apr 2008 16:15:38 +0200
Message-Id: <1207145738.3957.2.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-DlV6z0zXAH7DU/TcU3vi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-02-01 at 12:50 -0700, Dale Farnsworth wrote:
> This adds the low level irq tracing hooks for 32-bit powerpc.
> This patch applies on top of Benjamin Herrenschmidt's patch that
> provides similar support for 64-bit powerpc.  See
> <http://ozlabs.org/pipermail/linuxppc-dev/2007-October/044361.html>
>=20
> It seems to work on my prpmc2800 board with a ppc7447.

At first it appears to work on my powerbook (with Ben's latest version
of the 64-bit patch), but then it seems to cause random corruption, I've
had a crash in the ext3 code and one in console_callback(), both of
which I cannot otherwise explain.

johannes

--=-DlV6z0zXAH7DU/TcU3vi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR/OVCaVg1VMiehFYAQJFNg//blchECtd6WRWhXs52EHP2JRzuu5IfvFJ
Wp31jaWFVg06Mz3wPo44CfwEF2fkmv4lcHQgEz1CrFbW6m6O0nBM/lvusjwFbbsr
942zENQ7yUKFVFMilFD2t0+8ocxjubcCed3+k3JX4Ag2ZiayafUoMYthIlCRGguK
KPU0rClNWUwh4aTaxhwBFVGmv6t/bIhaiFaclkjWEkvjTDgBxj8RVJ7W7WvOQKy4
FYTJcKzoH1ElMbtEcgiw22PX1nFimVe9KlI/Jmm7/vAstMqfqLAtbARZQ9/5Rbnd
P3/iyPpo86MOyxAPsD4XrY4JihslTEaYoQIB5co7mv738mha1ne50j3ctEavANHA
w38QcBBi1Zcw7EyD9qjjYaY3VtS5NDV3YeJRGlG7QUX0qzJS6hXMOEKExzVSsIT6
qmjjFKVv0EMbowiKtrSD1SW9Ki7bNdxQRyoGDnuOEfEsSoDshL4eKg8wp8ixdQuF
YpuRyXi+s0eSvG13nAYV0gDkFfIaLs2bxFFeZSp78+tB+DCCHsIeNrhibC7FANTQ
AY4pSaLfheIMIgK4lIBUiY7qYWlXkRaSb8yAoYUFQr/wVw05XmvsgX7O1WEug6r4
+1o94tYG6FQ9H2UBgs1YDGwAt0KVq/5vvLx3lO0ti1+SNfT6gxcBWN+PjUrpg430
Oxjm3vDHnH0=
=7gme
-----END PGP SIGNATURE-----

--=-DlV6z0zXAH7DU/TcU3vi--
