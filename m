Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ADA39DDDD4
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 07:51:39 +1000 (EST)
Subject: Re: [Bugme-new] [Bug 11629] New: quad G5 fails to shut down
From: Johannes Berg <johannes@sipsolutions.net>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080923143057.e3e54536.akpm@linux-foundation.org>
References: <bug-11629-10286@http.bugzilla.kernel.org/>
	<20080923143057.e3e54536.akpm@linux-foundation.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-bZT6mzu6UiNw7XlROlBP"
Date: Tue, 23 Sep 2008 23:50:42 +0200
Message-Id: <1222206642.18015.47.camel@johannes.berg>
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


--=-bZT6mzu6UiNw7XlROlBP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-09-23 at 14:30 -0700, Andrew Morton wrote:

> > http://johannes.sipsolutions.net/files/dsc_2274.jpg
> >=20
>=20
> That went splat in the clockevents code.

Yup.

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

Ah, cool, I'll pull it in once I've verified this other problem I have
with ftrace on the same box.

> I'll mark this as a post-2.6.26 regression, although you seem a bit
> wobbly on that.

I was fairly sure it was ok with 2.6.26 but after checking it appears
that the crash is a post-2.6.26 regression, but the failure to shutdown
is not. Sorry, I've been following wireless-testing.git on this box for
so long it slipped my mind.

johannes

--=-bZT6mzu6UiNw7XlROlBP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJI2WSsAAoJEKVg1VMiehFYg3wP/RHMwWPcPyYn2jIk9v9JTmqP
xvv2mijZFKXAffQXecpJTZ1YLUVRE6F22QmvOOo8uMFBEvtOp6MpvKUuPd24Ko4N
n149cV2JFU08ikbnD+w5Xl3aoz8NWZEHRvyht+qAJcfPvHxuqiFBDcdUd3EjpM7C
mVaCTKt5ZjW7bM1jm99ucCmBQCdvHxIEL9FseZIzOV2+Gk6mT2HFo5BgJAzJSD5/
5N49YgbQYTP8fMBerz48BS+JRNkiwCqlqnlEXZW9Xi/l2GrdaPtGMniO3imCSo7M
aRlh0EhBQLVjWVupjHie8wXOU4H1aO+VAeYsYOxngwCT7Ng5vsTs2hW3yPVsC6GA
PeRasYyQa3GeIfN8VW45B1+91htwKe4bzDoX/O48TrkfbBnrqndtsCHf07KisdLM
i1yJ7VFayIKms7ARwXt8+VnvcPQCL6XaJ1zzP+0TL//saARYip5Wo+l8WRI0mbLo
VjoV4Gg6SQrxpDA0vLazHaX23xdCFBc8oB41tBNQVAm1XGokgyxljVdAWOj7egyH
t+1AhCo3H2aX7EgKymACDVA1BcJWQCx80NdDfqtzFcSMwv0wTpN0UFisKd5LJmtj
lYl8YRWUXc3ABv9Qd0TjI3G04DyN7ViEiEKHdTTi2OsnUKvmKg7mvQGBfMOcNMVu
ga+EUr2Ah9i2/sf6G6Ec
=vYpz
-----END PGP SIGNATURE-----

--=-bZT6mzu6UiNw7XlROlBP--
