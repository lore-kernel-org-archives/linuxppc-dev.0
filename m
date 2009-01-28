Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 8C90CDE074
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 20:50:48 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: How to bring up fs_enet on 2.6.27?
Date: Wed, 28 Jan 2009 10:50:39 +0100
References: <547eba1b0901272104r69f80c88yf99bb009ff886688@mail.gmail.com>
In-Reply-To: <547eba1b0901272104r69f80c88yf99bb009ff886688@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2493386.EOPoPvodch";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200901281050.44952.laurentp@cse-semaphore.com>
Cc: Daniel Ng <daniel.ng1234@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2493386.EOPoPvodch
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Daniel,

On Wednesday 28 January 2009 06:04:11 Daniel Ng wrote:
> Hi,
>
> I'm trying to bring the primary Ethernet interface up on my 8272-based
> board running 2.6.27.
>
> Previously, I had this same hardware working with 2.6.14 using the
> following driver:
>
> linux-2.6.14/arch/ppc/8260_io/fcc_enet.c
>
> This doesn't exist anymore in 2.6.27. From reading the code comments,
> I think the new driver I should be using is:
>
> linux-2.6.27/drivers/net/fs_enet/fs_enet-main.c

That's right.

> The PHY is an Intel LXT972. I have selected the closest-matching
> Kernel config option 'LXT970'.
>
> The primary ethernet uses FCC2.

Make sure FS_ENET_HAS_FCC is set in your kernel configuration.

[snip]

> The fs_enet probe() function doesn't seem to get called (I had put a
> panic() in it). Should it?

Yes it should.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart2493386.EOPoPvodch
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmAKm8ACgkQlyYWY4YEWhWDawCfVWYNT3t05wjlIpfq4Qj8VYOB
WJYAn0AO9BlIVXU3uM/yA3LdbnR0lzKD
=S14V
-----END PGP SIGNATURE-----

--nextPart2493386.EOPoPvodch--
