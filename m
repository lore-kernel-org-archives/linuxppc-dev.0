Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1DD0CDDF16
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 02:47:47 +1100 (EST)
Subject: Re: [PATCH 2/5] powerpc: fix suspend states again
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1174318342.5044.16.camel@localhost.localdomain>
References: <20070319105352.771599000@sipsolutions.net>
	<20070319105358.796834000@sipsolutions.net>
	<1174315727.5044.6.camel@localhost.localdomain>
	<1174317726.22561.4.camel@johannes.berg>
	<1174318342.5044.16.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-MwKUhokdHE10Jpqu2/HL"
Date: Mon, 19 Mar 2007 16:45:46 +0100
Message-Id: <1174319146.22561.6.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-MwKUhokdHE10Jpqu2/HL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-03-19 at 16:32 +0100, Benjamin Herrenschmidt wrote:

> No, on powerbook_sleep_3400, the CPU is never reset nor powered off.

Oh ok, wasn't aware of that. I think the right place to put it is
restore_processor_state, new patch coming.

johannes

--=-MwKUhokdHE10Jpqu2/HL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBF/rAq/ETPhpq3jKURAsuEAKCVzxTJ6+e6CArBARMMEPdTd8XWWACfaJQG
vwnSseQpfhQn6gkx9KWCkLo=
=83u2
-----END PGP SIGNATURE-----

--=-MwKUhokdHE10Jpqu2/HL--
