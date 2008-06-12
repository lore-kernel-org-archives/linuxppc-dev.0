Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 03982DDF0A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jun 2008 00:05:32 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Question on PowerPC's JTAG instruction
Date: Thu, 12 Jun 2008 16:05:26 +0200
References: <966933c00805291814s12439a96q57fabe77ff1139ec@mail.gmail.com>
In-Reply-To: <966933c00805291814s12439a96q57fabe77ff1139ec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart11450844.EnjOmffEZr";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200806121605.28850.laurentp@cse-semaphore.com>
Cc: John Zhou <johnzhouzj@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart11450844.EnjOmffEZr
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi John,

On Friday 30 May 2008 03:14, John Zhou wrote:
> Hi,
>=20
> We want to design a tool to speed up our hardware diagnostics via JTAG
> port.
>=20
> So we have question to ask for your help:
>=20
> 1. How do we access PowerPC's internal GPRs and SPRs etc. via JTAG
> instruction?
>=20
> We'v gone through IEEE.1149.1.   There are no standard JTAG instruction to
> access CPU's data bus, including internal or external data bus. Do we must
> need private JTAG instruction to access CPU's internal resource?

That's right.

> if it is, could you share the documents with us?

No public documentation is available. You will need to sign an NDA with=20
=46reescale (and probably pay $$$$).

I had to design a test bench to program the flash memory on our MPC8248-bas=
ed=20
hardware, and ended up using JTAG to bitbang the bus signals. Programming t=
he=20
processor through JTAG private instructions would have been faster.

> 2. For 'BSDL' usage, you know, we have many components on one board and m=
uch
> more signals are processed specically. So, how to integrate PowerPC's BSDL
> with other components' 'BSDL'?  Could you give us any hints on it? or any
> document is also welcome!
>=20
> Your any help is appreciated!

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart11450844.EnjOmffEZr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIUS0o8y9gWxC9vpcRAoAGAKDWc4AqmGwMHVKns0SOTci+YzS6SQCfUN/c
aX35y0M6hk0JLitLCR5oz5Y=
=XKWK
-----END PGP SIGNATURE-----

--nextPart11450844.EnjOmffEZr--
