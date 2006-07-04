Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B9A567B68
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jul 2006 21:16:46 +1000 (EST)
Subject: Re: [PATCH] powermac: defer work in backlight key press
From: Johannes Berg <johannes@sipsolutions.net>
To: Aristeu Sergio Rozanski Filho <aris@valeta.org>
In-Reply-To: <20060704110354.GA30435@cathedrallabs.org>
References: <20060704013923.GG27596@cathedrallabs.org>
	<1152000419.20701.48.camel@localhost>
	<20060704110354.GA30435@cathedrallabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-UyYXBFNAaJMQam2DbH9M"
Date: Tue, 04 Jul 2006 13:16:21 +0200
Message-Id: <1152011781.20701.60.camel@localhost>
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


--=-UyYXBFNAaJMQam2DbH9M
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-07-04 at 08:03 -0300, Aristeu Sergio Rozanski Filho wrote:
> today pmac_backlight_key() is called either with 0 (to reduce backlight
> level) or 1 (to increase).

Oh, it looked on first look like it was -1 or 1, I see it now.

> I found that actually happening two
> keystrokes between interrupt being serviced and actually running that
> work queue would be so damn small that the extra code wouldn't be worth.
> but if you think it's worth for, I can fix it, no problem.

Yeah, you're right. Unless that thing has some fast repeat if you hold
keys... Not sure what I was thinking.

johannes

--=-UyYXBFNAaJMQam2DbH9M
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARKpOAqVg1VMiehFYAQLEpA//cfaeLaG+WyZjG8AhYLFvjLWeuS6s+Q7A
KvKUi3GyBOxRtuHw/SefHCSvs2yVBpq008J+ZDv5aPxK5meT4WZNrHbp+ELEm3e+
YKpuLoHiavYQWyLLbTM0Fu3ngv2rGwWRvb6jyINYu0yuu8KOSA7ylC2UdCgbuoTu
3B4aVRw9G9ctsNL1j28KA0kcV3HgHM5hRqtwuMchX0Jzy+HPHb4WeOGV8YnYp6rY
8Zs2yWG/lpf6uGrN5hB1cpAPSGDmeVKYBdvZ4Kv6dyhkq56CimdQ4MPQvdOfrkET
M50JLPPvfAC20s7Vcuw3T0tbH6e8Aqdw1ERr/HcYrCba+sx8bpIo/rDS0YxyYSXp
WMhM+h86bxZMHQVdHlsnXkb2Mx0ankM4OZIfHWaaYbwNQrmdo6PF4weTnETD4xU3
0FZDwSUFAa2NMSnwv4nXeAKPUeE83olI7aEdaUD3Q3fHc7O/uUFMYlfAczsAC/f8
veats6mvQRAzLB8ZFW7v0vQx1V+LVA3LIUAAublbxWFSQ+8Cdz5XCjaK8sv4eRHG
ll/yRe19szwoKrofMcZYTpmZk2oJ2rRr6R69ABmFGJIQuyQJusPWnVQFhCGUheVe
iPqhKjaCtfPWY3nUBibZGzuPiRiWiYPcyw7JUzHOmxTGybAWltqDbwQsvIagW3v+
d7JXCVtS0Qw=
=KW36
-----END PGP SIGNATURE-----

--=-UyYXBFNAaJMQam2DbH9M--
