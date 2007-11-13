Return-Path: <roman.fietze@telemotive.de>
Received: from mail.telemotive.de (mail.telemotive.de [62.206.149.210])
	by ozlabs.org (Postfix) with ESMTP id A48A9DDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Nov 2007 01:47:01 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 5820F3CADC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Nov 2007 15:40:19 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: SDRAM failures on MPC5200B
References: <46A0D76E.4030101@acdstar.com> <4739ADDC.8010402@acdstar.com>
In-Reply-To: <4739ADDC.8010402@acdstar.com>
MIME-Version: 1.0
Message-ID: <200711131540.18315.roman.fietze@telemotive.de>
Date: Tue, 13 Nov 2007 15:40:17 +0100
Content-Type: multipart/signed; boundary="nextPart2504171.lkXzIyz8hA";
	protocol="application/pgp-signature"; micalg=pgp-sha1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--nextPart2504171.lkXzIyz8hA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hallo Mark,

On Tuesday 13 November 2007 14:59:56 lokowich wrote:

> A follow-up: The first version of our termination network was based
> on the Lite5200 reference design, but was confirmed by Freescale to
> be inadequate. We revised the hardware per their errata, terminating
> both ends of the data bus. This fixed the problem. Thanks for the
> helpful feedback.

If I can remember it correctly, the is no errata on the Freescale
documentation web pages specifying to terminate the SDRAM data lines
on both ends. The only document I can remember that specifies
something similar is AN3045, "A comparison of the MPC5200B (Mask Set
M62C) with prior MPC5200 Versions" on page 2, in the chapter
"1. Overview".

Could you please give me some hint about what errata or other document
we probably missed?

Maybe I have to tell our HW people that it will be necessary to fix
our design as well.


Thank you

Roman

=2D-=20
Roman Fietze Telemotive AG B=FCro M=FChlhausen


--nextPart2504171.lkXzIyz8hA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQBHObdSp5XY/BK//MIRAu3oAJwNZr3d7SLG8LPeAjlP9wILJWiAcgCZAe9B
ZfNos6EYsbDNJCfS6Y754Kk=
=zqR0
-----END PGP SIGNATURE-----

--nextPart2504171.lkXzIyz8hA--
