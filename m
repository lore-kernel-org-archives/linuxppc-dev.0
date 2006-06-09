Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F251567C13
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 22:11:07 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 11/12] snd-aoa: add Kconfig and Makefile
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hejy04x7k.wl%tiwai@suse.de>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130917.996988000@sipsolutions.net>
	<s5hejy04x7k.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-fO7VAIgWLkOkb9lsHipc"
Date: Fri, 09 Jun 2006 14:10:50 +0200
Message-Id: <1149855050.3864.16.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	netstar@gatheringofgray.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-fO7VAIgWLkOkb9lsHipc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-06-07 at 20:50 +0200, Takashi Iwai wrote:

> Let's remove EXPERIMENTAL.  Or keep snd-powermac untouched.

Good point. It's been working for lots of people and I'm almost done
verifying that it works for all that snd-powermac handled, so I'll
remove the EXPERIMENTAL.

johannes

--=-fO7VAIgWLkOkb9lsHipc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARIllSKVg1VMiehFYAQIBRw//TZbAyEAtac7OgGzoPUgMJQtjahV+AbJC
IbefrY/zSNm9JP6jStqOQUJ7hxqql/rr1YS4SzuDrzTy/whHSuf1DMUv71e67o61
0bwPqZwvSFcatK0H2rDAKsNJym3y7PFV7A5S06uaOJkUeZaf8qklGZwzretDsCQ1
Q0HVjIWpZT0J+W2G+2xbxZ0gYc5gPtFpaU7yAoudq/vhtqthDhlfG9rx/QyAy2EO
iQs6BzgDEcGUCO8sug6x4FPcTeI4LPhcytnOAqMHnFezI62ZAin0tDBDK98YpFD0
O03/5T1CxInC1+vBIHcWtR9oNYkB306Bn4Yi95zEHwSjwlGVoV2ZDK9TXSIuZMCq
wsewLhjut+QXt3y6UZ0IuleRaidXNS+Ey8/sA+xSQgtOc3y6revqWFJ3Nql7jJxL
3j6cQQXLbyDlCPsrHs8yf+TI34IqEyRfPRjX+mBT8rHVH7FxqhpgU2IZucfYFHUw
ayTU7urAxqt8/oKhl4a8pCX2xI17Z7qziwSbXpOCoV7LTjo+/QSQmXs/+fGCLWeY
L2pBzgbeFT1Fem2smGvxzEOI1wv2CgbJZblHQ2m9ye0ECQz6ptV3rf+zdEEqmTBQ
HFaIemvQ8su98JOBh92qV9g7oNwCxwxX4CyiWS1CwAdyu++97ubQ0nvqZJ8FKNo5
0qtMFg//E8w=
=yNf6
-----END PGP SIGNATURE-----

--=-fO7VAIgWLkOkb9lsHipc--
