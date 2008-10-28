Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id AC647DDF6C
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Oct 2008 02:10:18 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Subject: Re: Floating inputs on unused GPIO pins
Date: Tue, 28 Oct 2008 16:10:09 +0100
References: <200810131156.59477.laurentp@cse-semaphore.com>
	<48F34922.503@billgatliff.com>
	<c384c5ea0810130640w7d0031f5j130c4edf83acccaf@mail.gmail.com>
In-Reply-To: <c384c5ea0810130640w7d0031f5j130c4edf83acccaf@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1996234.hrPGy7VxOM";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200810281610.12445.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, Bill Gatliff <bgat@billgatliff.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1996234.hrPGy7VxOM
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Leon,

sorry for the late reply.

On Monday 13 October 2008, Leon Woestenberg wrote:
> Hello Laurent,
>=20
> On Mon, Oct 13, 2008 at 3:12 PM, Bill Gatliff <bgat@billgatliff.com> wrot=
e:
> > At least until someone plugs in that expansion module!
> >
> Bill's remark made a neuron connection in my head:
>=20
> Can you detect if the module is inserted or not? (By reading a known
> state of some pin)?

I can, although it's a bit more complex than that. The module is connected =
to the main board I2C bus so I can detect its presence by checking if chips=
 connected to the bus are detected. Using a GPIO would have been much easie=
r, but that's life :-)

> You could then configure the pins dynamically in your driver.

That's what I'm doing. As dynamic pin configuration requires board-specific=
 knowledge in the device driver I would have liked to avoid that if possibl=
e.

Best regards, and thanks for your help.

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1996234.hrPGy7VxOM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkkHK1QACgkQlyYWY4YEWhX3xQCfe++SHcE/YFnnNKJQOHaHIMhk
4tUAn2bsvcEDC7ejqz/FUiCK3wWFloGE
=Yuyz
-----END PGP SIGNATURE-----

--nextPart1996234.hrPGy7VxOM--
