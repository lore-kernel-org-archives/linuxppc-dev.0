Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 935C6DDE16
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 23:14:28 +1100 (EST)
Subject: Re: [Alsa-devel] [PATCH] snd-aoa: fix onyx resume
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hzm9kdvpt.wl%tiwai@suse.de>
References: <1166106468.3161.6.camel@johannes.berg>
	<s5hzm9kdvpt.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-IFULpF97A5/HpBb9zNWn"
Date: Thu, 01 Feb 2007 21:17:39 +0100
Message-Id: <1170361059.4036.21.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	ALSA development <alsa-devel@alsa-project.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-IFULpF97A5/HpBb9zNWn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-12-19 at 11:30 +0100, Takashi Iwai wrote:
> At Thu, 14 Dec 2006 15:27:48 +0100,
> Johannes Berg wrote:
> >=20
> > When the machine resumes the onyx codec might be in a weird state. Henc=
e,
> > simply fully reset it once (and keep the code to take it out of suspend=
 in
> > case the suspend of the codec chip survives a reset).
> >=20
> > Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
>=20
> Applied to ALSA tree now.  Thanks.

It doesn't seem to be upstream yet, is there some holdup? Not that it's
important to me at this time, just curious.

johannes

--=-IFULpF97A5/HpBb9zNWn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFwkrj/ETPhpq3jKURAq6IAKCajSQaXDZtRxx9CsZqPUNxDr6QpACeNANz
lBOnviH124hwY3Bh8b+o1lI=
=KVlC
-----END PGP SIGNATURE-----

--=-IFULpF97A5/HpBb9zNWn--
