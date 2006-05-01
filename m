Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A71FC67B55
	for <linuxppc-dev@ozlabs.org>; Mon,  1 May 2006 19:22:03 +1000 (EST)
Subject: Re: [PATCH] via-pmu: report powerbutton as proper input event
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1146474566.30710.45.camel@localhost.localdomain>
References: <1146251713.5019.4.camel@localhost>
	<1146466716.30710.39.camel@localhost.localdomain>
	<1146473774.24172.2.camel@localhost>
	<1146474566.30710.45.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-3Ad/TjCHCqXhqk5Id4vV"
Date: Mon, 01 May 2006 11:21:54 +0200
Message-Id: <1146475314.24172.7.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-3Ad/TjCHCqXhqk5Id4vV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-05-01 at 19:09 +1000, Benjamin Herrenschmidt wrote:
> > What else does it report? As far as I know it doesn't have anything
> > else, at least on my system.
>=20
> Depends on the machine... earlier ones have the backlight there or
> volume control.. then LID close could be an event too...

Ok, yea. Well, we need to rework all of that. Currently, to get at the
lid status, you have to open /dev/adb and do something through that.

I honestly don't understand the reason for this. Is it just historic?

johannes

--=-3Ad/TjCHCqXhqk5Id4vV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARFXTL6Vg1VMiehFYAQJN0xAAo7FGNIWF7JT7sJv/omXoVeUfpgL0iJp8
sz1MyLCYwR08zgrgOtsofvfBgLmQSWGQtG1Fj/wtUfrNhRM8kdOIMEXbTC8FUKL6
yCMSeoJwoAaaL/OI4tS9YAXJ6D5Y2jR7ogjA114hihocJh0aBoeqSnCPoL1KjfJ9
/FunZ/w3EmOYRX8gS3bmV9iwGCl4gwm9DRDlS1Wsixe0EdKnS9j535klyQk4tEoh
R6mXe+3nlKZ0legU696BMx1icB+ivRBkr4gtPonx4k8405d6JyI0ZyA5Vkgk2Fq+
c4sTQZjXtHGD5uHQzBrJ1suggOkpmKBplheZIXSbCCfD/U+mnC/AcNVvS1F4JK8V
vKgi4AbwIO4vJDAzFMJu18Cei/npBU3rrhcD8tT4PcKANJcKFDyYqiQUM6eu2er6
sMPD42gacy3k9YTkQ+RdD17rHmG0mO8lm/Dw82tKW2JyN6a1gux5dbW4m4InZZjB
7RooF+3PmIEAftsK/RPVSe2V+cHgzHo4qy0Fk9+Z1U4ZKpGGD64sUszshC8boN3/
5ZgOQ99AaWK0g9znOqMAavVoRX/06gJSu52vA0/RdgDjeGHOTRSqtt/UP98YCqZO
U+A40NlgumC2cbHGHWaaMqJTPqjlFn/TmJAb1iTbWlqchfLIV1tnlvRp5P4RLSP+
KmnQekv1JOs=
=oPrY
-----END PGP SIGNATURE-----

--=-3Ad/TjCHCqXhqk5Id4vV--
