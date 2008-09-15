Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 69CB7DE8D6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 Sep 2008 21:53:26 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Modules and inserting into kernel
Date: Mon, 15 Sep 2008 13:53:19 +0200
References: <20080915113818.35AB5DE5AF@ozlabs.org>
In-Reply-To: <20080915113818.35AB5DE5AF@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2344469.cTs9ddaLfF";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200809151353.21472.laurentp@cse-semaphore.com>
Cc: VenkataKrishna <venkatakrishnap@vrindatech.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart2344469.cTs9ddaLfF
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Monday 15 September 2008, VenkataKrishna wrote:
>=20
> I installed ELDK kit and I compiled kernel uImage in linux. Now I want to
> build and compile device driver your target under MPC8260. How can I do t=
his
> and inserting you module in Linux.

To compile the modules just run

make modules

in the kernel source tree. After copying the modules to the target, load th=
em with insmod or modprobe (read the manpage for both commands).

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2344469.cTs9ddaLfF
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkjOTLEACgkQ8y9gWxC9vpe1AACffwjH+WjFmRZmvNafIlmqqAiE
3skAoMf0bi6ZXU7HE2pkHe7ROfoePL9T
=MbgP
-----END PGP SIGNATURE-----

--nextPart2344469.cTs9ddaLfF--
