Return-Path: <jason.mcmullan@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.202])
	by ozlabs.org (Postfix) with ESMTP id 13C5767BFD
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  2 Jul 2005 04:56:35 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id 12so198966nzp
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 01 Jul 2005 11:56:34 -0700 (PDT)
From: Jason McMullan <jason.mcmullan@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20050701101713.GC11121@logos.cnet>
References: <42C1AAC1.4060702@gmail.com> <20050629085913.GA2153@logos.cnet>
	<faba7798050630071347d4ad63@mail.gmail.com>
	<20050701094438.GA11121@logos.cnet>
	<1120229717.21507.9.camel@jmcmullan.timesys>
	<20050701101713.GC11121@logos.cnet>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-CzaLJDghWujDXiD5QFqJ"
Date: Fri, 01 Jul 2005 14:56:30 -0400
Message-Id: <1120244191.18872.3.camel@jmcmullan.timesys>
Mime-Version: 1.0
Cc: Anton =?ISO-8859-1?Q?W=F6llert?= <a.woellert@gmail.com>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: mpc8xx and ld.so problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-CzaLJDghWujDXiD5QFqJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-07-01 at 07:17 -0300, Marcelo Tosatti wrote:
> That was a quick response - thanks.
>=20
> Two questions:
>=20
> - Do you happen to know about details of dcbz's (mis)behaviour on 8xx?=20
>=20
> I ask that mainly because I worry about in-kernel dcbz users.

    IIRC, it isn't used in any 8xx code paths.

> - Shouldnt upstream glibc have that fixed for 8xx by now?

    Ha. Funny. The glibc powerpc maintainer doesn't want any embedded
fixes in the mainline. Last I checked, that was for 'the tools
vendors' to fix.

    "We won't work around processor bugs" is their philosophy.

    I went through a similar (unsuccessful) battle with the
amcc 440ep's "blrl" errata and gcc/glibc.

    It would be nice if the politics there have changed
(maybe they just didn't like me personally), but I don't have
much hope.

--=20
Jason McMullan <jason.mcmullan@gmail.com>
"Sure, send me the latest Knoppix DVD as an attachment..."

--=-CzaLJDghWujDXiD5QFqJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCxZHe8/0vJ5szK6kRAlNHAJ4mGNMtCYRKTwU3JHKiMol0FypowwCeObiW
7KM184wGoKL4obTIZh1ScIQ=
=0ZmU
-----END PGP SIGNATURE-----

--=-CzaLJDghWujDXiD5QFqJ--
