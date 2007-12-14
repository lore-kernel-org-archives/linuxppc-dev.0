Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C733BDDF6B
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 23:18:44 +1100 (EST)
Subject: Re: apm_emulation regression
From: Johannes Berg <johannes@sipsolutions.net>
To: benh@kernel.crashing.org
In-Reply-To: <1197590712.15741.197.camel@pasglop>
References: <1197427530.8385.59.camel@pasglop>
	<1197482587.6558.145.camel@johannes.berg>
	<200712140110.44406.rjw@sisk.pl>
	<1197590675.15741.195.camel@pasglop>
	<1197590712.15741.197.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-nCs1fOMHqIS+krGW+M/L"
Date: Fri, 14 Dec 2007 13:18:28 +0100
Message-Id: <1197634708.16079.46.camel@johannes.berg>
Mime-Version: 1.0
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-pm <linux-pm@lists.osdl.org>, ralf <ralf@linux-mips.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-nCs1fOMHqIS+krGW+M/L
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > It can use the new notifier that happens before freezing yes. Johannes,
> > I think that's pretty much what my old powermac implementation did
> > (using my private notifier scheme I had there), might be worth reviving
> > that bit and sticking it into the generic apm_emu ...
>=20
> Note that you may want to improve on it with a timeout in case userspace
> doesn't ack...

Yeah heh. I'll take a look, shouldn't be too hard. Except I'm not
exactly sure how to test it.

johannes

--=-nCs1fOMHqIS+krGW+M/L
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR2J0k6Vg1VMiehFYAQJUiw/+IILaLAb6tcHM+BQNEdo1tIxbrfW/ZfTQ
0H4kxHi35w7bbzWn6fyMI1kroaSuyOXNNlHy7LRTwy5ozJsvIUO8d+l9YjiuSnZT
KAIEJcQ4V4aOAVzgk8Tw2qr97RdzM1LZi2Lf7QQiuX4RxJekU12fVvmTw8+lomnw
6TZlA40LPPpZDEbooXnlou6FH5QdC3IlC2wOUAwtSXB5PEhZMl0s+nxv3rd7uIjl
lF97rWfew9QcJzty4U9ofRYnZfNWVbFCrs247IVP2o6LzsNIt8IN2MvlB8z1qTTE
ycEOMlqvMSvgyrmz6jmjh8sgSpGnCL2swc8+g6P7W7c6ggBhtoa9aoRzuebl7RRl
eZTCKg+W+JC51rILiHPjqwdqEj4j2zeHvZEenADmFtHAvdRt4uiVvrc16yH5PyBe
0fMbfGYhIk68upySpCrIGOPy/3DtJZ/iF1XsvbDM0x26xTxZY+SbzUyoJyEB7mUh
ztfj6BqgT1Ek31kKEFrsue2iZTJ7ftZR7XSmHPkSuiAs/oJ2dD2FECcCcOSL+yFL
Lf8p05Pri3GAI3WUWjHKy5aeD1Aw042rkR5ZKGTF2vmHlTb3x1l5QIbRqQD3CoVW
9ZkQAZsM2n/eKDeYEsdvC4YllyEFzpqz4hh+WYE/tR81W+RSw/x6fVBPJYTWin3/
NptJsp4sPh4=
=1bkV
-----END PGP SIGNATURE-----

--=-nCs1fOMHqIS+krGW+M/L--
