Return-Path: <federico@gamio.net>
Received: from mail.rootway.com (mail.rootway.com [66.193.175.41])
	by ozlabs.org (Postfix) with ESMTP id 3895D2BDF2
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Dec 2004 04:33:26 +1100 (EST)
From: Federico Gamio <federico@gamio.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1101877409.5672.2.camel@gaston>
References: <1101877409.5672.2.camel@gaston>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-9HGmrBrv/tQkqPbWoch9"
Date: Fri, 03 Dec 2004 15:06:05 -0200
Message-Id: <1102093565.4272.6.camel@eva>
Mime-Version: 1.0
Cc: fedora-ppc@lists.infradead.org, gentoo-ppc-user@gentoo.org,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Debian PowerPC <debian-powerpc@lists.debian.org>
Subject: Re: TEST: Sleep patch #6
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-9HGmrBrv/tQkqPbWoch9
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

With patch #6 in some random situations, my PowerBook G4 (ATI 9600)
doesn't goes to sleep.
One situation is:
 - Turn PB
 - Work
 - Sleep
 - 14 hours of sleep
 - Turn back from sleep (perfect, no problem at all)
 - Work for 4 hours (mails, www, no USB, Bluetooth, etc)
 - Try to sleep and problem...

When I try to make sleep my PB, nothing happens (in X), and I can't
switch from X to console.
Sorry, I can't help you more with this bug, I will keep trying to
establish which are the events that trigger this bug.

Federico

On Wed, 2004-12-01 at 16:03 +1100, Benjamin Herrenschmidt wrote:
> (As usual, I'm cross posting several lists, please don't reply to all of =
them,
> and CC me as I'm not subscribed to all of them neither)
>=20
> Ok, here's the 6th version of the sleep patch for ATI based albooks &
> iBook G4. Other machine users, please test too as it may cause
> regressions (or improvements) as well.
>=20
> This one fixes finally the cache flush problem that made cpufreq (on mach=
ines
> using the PMU for the switch) and sleep/wake unreliable occasionally (mem=
ory
> corruption would occur on some CPUs at least). It improves bits here or t=
here
> too, and adds the sungem wake-on-lan feature.=20
>=20
> There are still pending issues, like cpufreq on some machines will
> "think" it's running at full speed on wakeup while it's in fact running
> at slow speed (thankfully not the opposite). I don't think I'll fix this =
one
> in 2.6.9, but rather in 2.6.10.
>=20
> http://gate.crashing.org/~benh/albook-ibookg4-sleep-6.diff
>=20
> I'll post a 2.6.10-rc2-bk* based version of the patch soon.
>=20
> Ben.
>=20
>=20
>=20
--=20
My software never has bugs.       | ASCII Ribbon Campaign         /"\
It just develops random features. | For Standards-Complaint Email \ /
Public GnuPG key available at: http://www.keyserver.net            X
1024D/203E154B 2003-10-03 Federico Gamio <federico@gamio.net>     / \
Key fingerprint =3D 0B9E 3A19 C88B EBAC 5422  C05F 76B5 B922 203E 154B
sub  2048g/32D2F465 2003-10-03

--=-9HGmrBrv/tQkqPbWoch9
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBsJz9drW5IiA+FUsRApmQAJ9JfggWKqwadLtMUCLPJ2zWiDbeywCfQEpt
3uVj1bVqEmt7/b5w4m3n3iI=
=dS3z
-----END PGP SIGNATURE-----

--=-9HGmrBrv/tQkqPbWoch9--
