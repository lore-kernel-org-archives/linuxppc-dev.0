Return-Path: <johannes@sipsolutions.net>
Subject: Re: [RFC/PATCH] powerpc: Add irqtrace support to 32-bit powerpc
From: Johannes Berg <johannes@sipsolutions.net>
To: Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <1207145738.3957.2.camel@johannes.berg>
References: <20080201195040.GA8950@farnsworth.org>
	(sfid-20080201_205114_032143_11799746)
	<1207145738.3957.2.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-JUG55B9XuV8jvafzD3W7"
Date: Fri, 04 Apr 2008 21:33:18 +0200
Message-Id: <1207337598.19189.77.camel@johannes.berg>
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


--=-JUG55B9XuV8jvafzD3W7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Wed, 2008-04-02 at 16:15 +0200, Johannes Berg wrote:
> On Fri, 2008-02-01 at 12:50 -0700, Dale Farnsworth wrote:
> > This adds the low level irq tracing hooks for 32-bit powerpc.
> > This patch applies on top of Benjamin Herrenschmidt's patch that
> > provides similar support for 64-bit powerpc.  See
> > <http://ozlabs.org/pipermail/linuxppc-dev/2007-October/044361.html>
> >=20
> > It seems to work on my prpmc2800 board with a ppc7447.
>=20
> At first it appears to work on my powerbook (with Ben's latest version
> of the 64-bit patch), but then it seems to cause random corruption, I've
> had a crash in the ext3 code and one in console_callback(), both of
> which I cannot otherwise explain.

FWIW, same kernel without the patch works fine.

johannes

--=-JUG55B9XuV8jvafzD3W7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR/aCfaVg1VMiehFYAQJByw//VhypFA/GiqANdUC4APuc3m5O+oHE0Efg
w2FREVYBRq2lHWcsJKcsszatZqNt5yFMM0MIP+8wdzKftp7w+25hNL+00wx84elH
4dRSSpnempItyOIxFFL0IGff2HwzEiSXAFtMPbScVwllA19EpGAoDTvEjNH/4Wl+
c65dWsrSL49apQDNfaUB8otjmz9cpegiCZiRJ4hw+R559A8fwRwlMaj+umeZDtBn
pDKIG5V82dTlhtkgzJIZYl8Kcdg5Ez8nCDlZQoQwnOPhGmrv29C4Ay8PATkSoOeN
5aLnVkTAkMTWOevUDkSyio1qSReRM7Yk1yG9yfbBGmdJIRbQiYFu9gRmuYE5S72S
rEwPwNnAhW2s5vRRn8SqzvSMJchJMI4yQit+8Z7xTFolIBTDAaNkd+njXr9iYk9F
Uxce/H+HuoU5iDm+Q0awW8j41ozU5nDZZU2zu4EmqCYGwQNRJJ6rEzzOeSGozeFs
j4RFZlj+WyiHASDeiIDmFJG0VjOYEk6BOHuG8FeDiRtONLtFqnUCMls3UwLeyd13
tNp9lBVsyjb3/cEw+7t3d1S86+K2aZgCqZc6oK9IzZ3O8kkEqme3fQLpE+X6ktJo
sThyvZS9EwlHKzwuvIv1vWHy0vBBq1LYsF6y72OeAs6Vpqqp5HKE9yy18m8vqM8q
boJxZChZM0A=
=AdDz
-----END PGP SIGNATURE-----

--=-JUG55B9XuV8jvafzD3W7--
