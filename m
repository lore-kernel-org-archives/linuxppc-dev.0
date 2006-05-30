Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 48E0867B28
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 23:26:37 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 4/7] snd-aoa: add codecs
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hr72bbqfm.wl%tiwai@suse.de>
References: <20060528190026.754474000@johannes.berg>
	<20060528190125.927852000@johannes.berg> <s5h8xol9gom.wl%tiwai@suse.de>
	<1148992996.3102.8.camel@johannes>  <s5hr72bbqfm.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-jXU39/LcpDlIRCpRV2oa"
Date: Tue, 30 May 2006 15:26:10 +0200
Message-Id: <1148995575.4372.5.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-jXU39/LcpDlIRCpRV2oa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> > > > +	return 1;
> > >=20
> > > The put callback is supposed to return 0 if the values are unchanged
> > > (although most apps ignore the return value).
> >=20
> > Does it have to? This way there's an event, but...
>=20
> Yes, in principle.  As mentioned, it works even without the check,
> though.

Hmm. I thought it worked like this:
 0    -> no change
 1    -> change applied, and other apps are notified, 0 returned to the app
-err  -> error returned to app

Is that wrong?


> Well, I meant the position of asterisk to follow the conventional C
> coding style.  Of course it should be static.

Ah. Yeah, I'll see to that and probably just Lindent the files (cleaning
up after it...)

> The driver should give up the initialization and fail to load.
> Usually the error from snd_ctl_add() is critical, either no memory or
> a duplicated control element is found.

Hmm, that's a bit hard to do since the driver here consists of more than
one module, but I suppose I can do something about it.

johannes

--=-jXU39/LcpDlIRCpRV2oa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHxH76Vg1VMiehFYAQKEKA/9HWtVRT2z6pU4aosxiUbTNCAIFUZAy08m
DnrhhzZ5sQIGu5BszQwDiUYqXwcCT6Mg3qlVtMAKEzHJ7b1SV6qmJZ+A08sjGH0M
Y2/Lyum0Wa72O7zuWt2kJ0uDi493oeb2OCSRg+7i3niM0/e2DKj7fQyLlhx6wp/2
gusz3urcvtcpMEeJYSs31BV7QtTCCtZEpYlPzkYUTDLq7ENJuxmx6zggF+ecaXBv
ceWbeTMqT9EI0jNDNwLUpIiuyY2fkpDbpMvaviI00nAAmmi5Xhgvy08a1O7eOrP/
RlxgB8944KaG/UoN+8ija6Rrh29IWu2J/JfHW5NuqzfV90DAC+yryNwSKDPF5OwR
c6YPf60VaLfIS5IFgsGpZlqSzIn6NqDAVQgqbLcZqAZn5iGWsREdXhPiIP+oSzjR
v1YDSuv+JR7hLB1/QqHTGAeQB7T2DYa1HMWTr+B6hCAK6kxBFSBxFghCtExDPr8/
JZaMf9nakxrwH5Nih0xso6/vK4+imeT11Krsrct4cWsK1K5Ya3IZoSkqDRDkxQSk
3n6lR0ePxcSJOCV8yC2mQ7FDZyBe5DIaCnRrKQLuz2ATykqcus5u5YkSWUw0IJr6
XQ1RVrpiwQ6kI1oOJ7vPz7w1pfS9RlArhaCM2zEeA4WHfKSY0xWTD2qRfYVv1ycM
gIGQcp0fzrA=
=pUwf
-----END PGP SIGNATURE-----

--=-jXU39/LcpDlIRCpRV2oa--
