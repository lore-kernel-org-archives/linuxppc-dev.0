Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A0AB2DDDEA
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 08:46:02 +1000 (EST)
Subject: Re: [Bugme-new] [Bug 11629] New: quad G5 fails to shut down
From: Johannes Berg <johannes@sipsolutions.net>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080923143057.e3e54536.akpm@linux-foundation.org>
References: <bug-11629-10286@http.bugzilla.kernel.org/>
	<20080923143057.e3e54536.akpm@linux-foundation.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-plru16xli6mcg45UuKrV"
Date: Wed, 24 Sep 2008 00:45:15 +0200
Message-Id: <1222209915.18015.51.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@elte.hu>, bugme-daemon@bugzilla.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-plru16xli6mcg45UuKrV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-09-23 at 14:30 -0700, Andrew Morton wrote:

> > http://johannes.sipsolutions.net/files/dsc_2274.jpg
> >=20
>=20
> That went splat in the clockevents code.
>=20
> I saw a pull request with several fixes float past this morning:
>=20
> From: Ingo Molnar <mingo@elte.hu>
> To: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "=
H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>
> Subject: [git pull] timer fixes
> Date: Tue, 23 Sep 2008 21:41:00 +0200
>=20
> Fingers crossed..

Well, that does seem to fix the regression. That is, it no longer
crashes. It still doesn't shut down, but that seems older and possibly
partially my fault as I wrote the CPU hotplug implementation (thought it
works fine for hibernate, never mind the fact that resuming from
hibernate hangs)

johannes

--=-plru16xli6mcg45UuKrV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJI2XF3AAoJEKVg1VMiehFYB1kP/2v2kSIVI4CUX9JKatdxR0pz
0EIeGpDaBUkV7EouBfwB5t9HSobDKLYYX9rAIiK52o+Ihuab66L0uYQinCfrl4eg
CjN8Z/IWBKxI6U2aVClZQDKTunof8OFau219BJAWq8qppojYEkBD8/okNgr+4LC7
DF0SlOnd+9jgM+jkWg/pWl2MbaYYoQcjLBaMEY/QpkswS9B6QIvaseGOnFRAQ2+b
mwC3trWh+4I2yEcLTWTF6ZdRAyw6JY8NJH9sSDqbINXhMMYmD2MAwN/rbP0QJLfM
M3qQUk2U16P69H8LGfptEqkXxsMpzKyTytKxMjabdbxJANVG20eiTwEbf3SAGpGR
+uurZexmpEo99lySkxif0bLocFA/tyVmn9Ctg4Nu4mRH7n7n/mrUii9IRMLFIOBX
CTmT2Ieym+RsqepubhW5hGoEqqTl9EFWZhk0lO0CnYlw5pCtYPyAm2O4Msd2WYVJ
/3N+J6e9VbN3qrJG/WVXnORqDsmkG1/tjfAiqWYTYrrHTcSNMTfRzIg55s6nAmYF
IPStJjWOUB0AQuEmeU39IgghxrCJ0U7gt9oivAdG8cm80Hoh/VkWLC6UpO0ab1/6
y5fuy83CNoWEtjkAWRCezU7aMp9/MGSJsLkN4iTWR1s4BXSZfqJWTxqpfC7qyaIC
wZphz0xrLXgOo8sfjW1P
=4orc
-----END PGP SIGNATURE-----

--=-plru16xli6mcg45UuKrV--
