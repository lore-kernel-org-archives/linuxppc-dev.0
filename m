Date: Sat, 12 Aug 2000 04:02:51 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Paul Mackerras <paulus@linuxcare.com.au>
Cc: Gabriel Paubert <paubert@iram.es>, linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again...
Message-ID: <20000812040251.C1645@plato.local.lan>
References: <14735.25805.953473.825729@argo.linuxcare.com.au> <Pine.HPX.4.10.10008081055160.20140-100000@gra-ux1.iram.es> <14740.61112.962127.150660@argo.linuxcare.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4NAIfEpSjlXpZEyn"
In-Reply-To: <14740.61112.962127.150660@argo.linuxcare.com.au>; from paulus@linuxcare.com.au on Sat, Aug 12, 2000 at 04:29:12PM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--4NAIfEpSjlXpZEyn
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 12, 2000 at 04:29:12PM +1000, Paul Mackerras wrote:
>=20
> The get/set rtc stuff on powermac still needs work.  IMHO the way it
> should work on powermacs is this:
>=20
> - at boot, read the RTC and the xpram and apply the correction from
>   the xpram
>=20
> - /dev/rtc reads and writes the RTC value directly (no timezone
>   correction)
>=20
> - if the RTC is updated from other places in the kernel, read the
>   timezone recorded in xpram and apply that correction before writing
>   it to the RTC.

would this still allow for rtc in UTC?  for those of us who do not use MacO=
S..

--=20
Ethan Benson
http://www.alaska.net/~erbenson/

--4NAIfEpSjlXpZEyn
Content-Type: application/pgp-signature


--4NAIfEpSjlXpZEyn--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
