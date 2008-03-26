Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 3E9FDDDF87
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 23:34:53 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Sergej Stepanov <Sergej.Stepanov@ids.de>
Subject: Re: [PATCH] cpm_uart: Allocate DPRAM memory for SMC ports
	onCPM2-based platforms.
Date: Wed, 26 Mar 2008 13:34:46 +0100
References: <20080325160331.GB15093@ld0162-tx32.am.freescale.net>
	<200803251732.32569.laurentp@cse-semaphore.com>
	<1206520313.26613.14.camel@p60365-ste>
In-Reply-To: <1206520313.26613.14.camel@p60365-ste>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6938803.kn1gHDE5Qo";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803261334.49515.laurentp@cse-semaphore.com>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart6938803.kn1gHDE5Qo
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 26 March 2008 09:31, Sergej Stepanov wrote:
>=20
> Am Dienstag, den 25.03.2008, 17:32 +0100 schrieb Laurent Pinchart:
>=20
> > Do you have any opinion about the proposed patch ?
> >=20
>=20
> I have to say, it could be some off-topic.
> But if you would use the cpm_uart-driver for cpm2(or cpm1) as kernel
> module, at linking you can get warnings about:
> 	- cpm_setbrg (cpm_set_brg): something with section mismatch
> 	-  __alloc_bootmem (cpm_uart_allocbuf): the same
>=20
> The symbols are not exported.
> Is it ok, about kernel modules?

I get the same section-mismatch warning for __alloc_bootmem in=20
cpm_uart_allocbuf. cpm_setbrg doesn't cause any warning here.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=C3=A9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart6938803.kn1gHDE5Qo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH6kLp8y9gWxC9vpcRAjgtAJ94SRzLnJR1TmoSIzv81gF8drV5ggCeKPF/
Guym1huaq9TDvBC3ZNLgBW8=
=o3fr
-----END PGP SIGNATURE-----

--nextPart6938803.kn1gHDE5Qo--
