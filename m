Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id EC523DDEEF
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 22:00:46 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: Floating inputs on unused GPIO pins
Date: Mon, 13 Oct 2008 13:00:40 +0200
References: <200810131156.59477.laurentp@cse-semaphore.com>
	<Pine.LNX.4.64.0810131201360.3562@vixen.sonytel.be>
In-Reply-To: <Pine.LNX.4.64.0810131201360.3562@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2564495.D8XtkFrj95";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200810131300.43207.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2564495.D8XtkFrj95
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Geert,

On Monday 13 October 2008, Geert Uytterhoeven wrote:
> On Mon, 13 Oct 2008, Laurent Pinchart wrote:
> > our hardware engineer asked me to make sure all unused GPIO pins are
> > configured as outputs to avoid floating inputs. He got theory on his si=
de
> > (floating inputs can lead to higher current consumption, metastability =
or
> > even permanent damage), but I'd like to ask the list for practical
> > feedback.   =20
> >=20
> > I haven't been able to find any mention of floating input protection in
> > the MPC8248 documents. Has anyone here experienced issues with floating
> > inputs in real-life designs ? Do you setup your board with all unused G=
PIO
> > pins configured as outputs ?  =20
>=20
> I always thought configurable GPIO pins default to _inputs_ after power-o=
n,
> so it's safe to tie them to VCC through a pull-up resistor?
> For CMOS, you can tie them to VDD or GND without a resistor.

That's not really an option. The GPIO pins are connected to an optional exp=
ansion module. When the module is plugged in the pins have dedicated functi=
ons. When the module is not present they are by default floating inputs. Th=
at's the case our hardware engineer is concerned about.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2564495.D8XtkFrj95
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjzKlsACgkQ8y9gWxC9vpeM0QCfbgGC7S9+aecaxV07Ubri1T/T
CpIAoJB0yFAy/x+sTxQULG8avA2yB8Ep
=Clls
-----END PGP SIGNATURE-----

--nextPart2564495.D8XtkFrj95--
