Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0314667B22
	for <linuxppc-dev@ozlabs.org>; Wed, 24 May 2006 19:43:35 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Johannes Berg <johannes@sipsolutions.net>
To: Hollis Blanchard <hollis@penguinppc.org>
In-Reply-To: <1148395617.3434.0.camel@diesel>
References: <1147860564.14395.6.camel@johannes>
	<20060522221138.683790c2@diesel>  <1148387282.25971.8.camel@johannes>
	<1148395617.3434.0.camel@diesel>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-2R/CpLr945jIU+MnE7yr"
Date: Wed, 24 May 2006 11:41:23 +0200
Message-Id: <1148463688.11734.16.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-2R/CpLr945jIU+MnE7yr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-05-23 at 09:46 -0500, Hollis Blanchard wrote:

> Yeah, I'm not sure how I was supposed to know that i2sbus was the magic
> module.=20

Heh, yeah, sorry. Thing is, if you'd have just installed the modules and
rebooted, it would have worked :)

> That seems to be working now. Again, from PowerMac11,2:

Yeah looks fine, except I just fixed a very stupid bug in the i2sbus
module. Please don't try to remove it after loading, until you upgrade
to the current version.


> This is probably just because I loaded all the modules I could find.

I tried changing the tas module to detect if the codec *really is
present*, but failed. There's some code in there, but I'll solicit some
help with that later.

> Volume control does indeed work when the tas module isn't loaded.

Interesting, but good to know. I'd have thought that the fabric would
not take the codec into use. Will see if I can fix that.

> Could you also add a sample modules.conf? For example, users should be
> told to remove snd-powermac.

Good point. Everything else should not be necessary though, since the
i2sbus module should automatically load due to having a macio modalias.

johannes

--=-2R/CpLr945jIU+MnE7yr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHQqQKVg1VMiehFYAQKJHBAAkl7t1WnkC5dR+++jVI8HCthOG+MG0z0M
6h2tInvtjQDWiog170aJIKzlGHg8LCuynchPgHhwVKGurI+tBNLvCDZ2BxH/GTNw
YoI0pMm52eRYM2IK25kwwfPrfIcEVtLtU+9y94duoG6beOLn+pfEWDpnk4qY4RuZ
JSVcMMaaBB21z3KO36Rcgyv7NkaTjivzuAbQA231xrJKDXlBMxhS7RpYGmqPn8lK
VFfnTz5GV2Q6qBRLmuYMlM3WC+nO51+OeAB9ZFNazlBKj/t9gG2WYD4L+DJPOhTR
QY3jvUO+gH/cNJTw5Gh9PWsMXn/viDPek23uLyKqaxR8oKb9rCcHrhuJx1oqABhN
BGNFzY2shN0YGkQc7cMMAvJMRYVXlbYTdFmBMGJtFQuv58+tVjYOO6/uwwKwTcRA
COER/eKPb8Bw9OpGffiRURwRVaiciYIlcgUQ2zXOd6Dg6qk/iuqFgLqm+fwiCC6Z
W/C0+kTSktvqP8JvbSKbJ5sUyQ5+ogewxUThkD90XBF/nVQQ3B+lCsP2ZcGHiWwG
RF3NtYA7bRxz7MSZRWXXpPxDdYlMq/hdxhKmxIz4taN57+nlC+F2NuPaIc30qE4X
lcR/kUC/3o7RCKzfj7fGU/Nav8Tigntx4u07cCKl8Z+F8ocmPhZP9mKQL4NmdRDf
zy7VuL1qDoQ=
=JTWN
-----END PGP SIGNATURE-----

--=-2R/CpLr945jIU+MnE7yr--
