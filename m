Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E59BDDFDC
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 21:34:30 +1000 (EST)
Subject: Re: Status of snd-powermac?
From: Johannes Berg <johannes@sipsolutions.net>
To: anders.gudmundsson@telia.com
In-Reply-To: <1178013086.7194.24.camel@localhost.localdomain>
References: <1178013086.7194.24.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-6MqYifvNEOWFNkz6PDRw"
Date: Tue, 01 May 2007 13:35:06 +0200
Message-Id: <1178019306.3483.27.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-6MqYifvNEOWFNkz6PDRw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-05-01 at 11:51 +0200, Anders Gudmundsson wrote:

> Is the snd-powermac driver to be phased out for the snd-aoa, and is
> support planned for older cards (PB IV, G3 iBooks etc.) in snd-aoa?

The structure in snd-aoa allows you to define additional fabrics and
additional sound busses. Hence, it ought to be fairly simple to write
support for older cards if you have the hardware and a bit of know-how.

However, I have neither the hardware nor time to do that. Hence, while
support for those old cards should be possible without much problem, it
is not planned at the moment.

johannes

--=-6MqYifvNEOWFNkz6PDRw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGNyXp/ETPhpq3jKURAksvAJ4sGtSe5stuGdfuZkRB6eL6ERf0VwCgiDNU
mzSX3a3Qrw5Q4w0XmDmTYWs=
=hRsz
-----END PGP SIGNATURE-----

--=-6MqYifvNEOWFNkz6PDRw--
