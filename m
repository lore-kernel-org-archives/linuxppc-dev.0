Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D4C92DE017
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 05:46:56 +1100 (EST)
Subject: Re: [PATCH 0/5] sleep notifier cleanup
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20070319181800.149901000@sipsolutions.net>
References: <20070319181800.149901000@sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xG5DJ2s7JDljNlkWCVQb"
Date: Mon, 19 Mar 2007 19:44:55 +0100
Message-Id: <1174329895.22561.15.camel@johannes.berg>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-xG5DJ2s7JDljNlkWCVQb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-03-19 at 19:18 +0100, Johannes Berg wrote:
> This patch series gets rid of the various pmu sleep notifier
> users by various means.

Forgot to mention, the time suspend patch is required for this since it
kills off another user.

johannes

--=-xG5DJ2s7JDljNlkWCVQb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF/ton/ETPhpq3jKURAiTYAJ4ovJETtD554rQmj2vgEP6yq11JmQCdFono
ITZUL8Mb6GqqLFCP07t0TzA=
=QRFq
-----END PGP SIGNATURE-----

--=-xG5DJ2s7JDljNlkWCVQb--
