Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0DC81B7D5B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Apr 2010 16:12:14 +1000 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id A0F46C592F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Apr 2010 07:48:29 +0200 (CEST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: Xorg on Fujitsu "Lime" with MPC5200b?
References: <4BC682DC.1050200@billgatliff.com>
	<201004151553.53426.roman.fietze@telemotive.de>
	<4BC77391.9000806@billgatliff.com>
In-Reply-To: <4BC77391.9000806@billgatliff.com>
MIME-Version: 1.0
Message-ID: <201004160748.29107.roman.fietze@telemotive.de>
Date: Fri, 16 Apr 2010 07:48:28 +0200
Content-Type: multipart/signed; boundary="nextPart5503650.dqfLDAPJkB";
	protocol="application/pgp-signature"; micalg=pgp-sha1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--nextPart5503650.dqfLDAPJkB
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Bill,

On Thursday 15 April 2010 22:14:09 Bill Gatliff wrote:

> I'm not sure what the *Weak stuff is doing. Can I just hack
> shadowUpdatePacked() itself?

I think so. But take care if you want to use that code on other
systems or without shadowfb. If I search for shadowUpdatePacked, then
I'll find it in quite some other locations.


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de

Amtsgericht Ulm                                HRB 541321
Vorstand:
Peter Kersten, Markus Fischer, Franz Diller, Markus Stolz

--nextPart5503650.dqfLDAPJkB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkvH+i0ACgkQp5XY/BK//MLEGACgj6HH5gN7TOJOGIdKRyHpUAAY
gk4AmwXeL+OQat2tfFOBO8D8+p6DWdFn
=MHdq
-----END PGP SIGNATURE-----

--nextPart5503650.dqfLDAPJkB--
