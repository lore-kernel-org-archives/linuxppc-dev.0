Return-Path: <nico-linux-ppc@schottelius.org>
Received: from scice.schottelius.org (ns.schottelius.org [213.146.113.242])
	by ozlabs.org (Postfix) with SMTP id 6ABC167A8E
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Feb 2005 01:56:47 +1100 (EST)
Date: Fri, 18 Feb 2005 15:57:52 +0100
From: Nico Schottelius <nico-linux-ppc@schottelius.org>
To: Joerg Dorchain <joerg@dorchain.net>
Message-ID: <20050218145752.GA11139@schottelius.org>
References: <20050118094216.GB25470@Redstar.dorchain.net>
	<20050126113554.GD19633@schottelius.org>
	<20050127163606.GN14866@Redstar.dorchain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
In-Reply-To: <20050127163606.GN14866@Redstar.dorchain.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: ibook-led (finished) (was: [PATCH] Heartbeat LED for iBook)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello everybody!

Thank you everybody for the help.

I found the correct bytes in the beginning of this thread and wrote
ibook-led (should work with powerbooks, too).

The program works as following:

ei nico # ./ibook-led =20
ibook-led <0,1,2> <delay>
   0: switch led off
   1: switch led on
   2: switch led on for <delay> useconds


The source code can be found on http://linux.schottelius.org/hacks/.

Sincerly,

Nico

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iQIVAwUBQhYCbrOTBMvCUbrlAQI/xw//XDlIwNY9MG16HpnmrrPMEnYoD2Oh7vlB
F9IxzaCKrwCiA/660K4k/5Ov/q6+Cwhqy+DYYVynf+SxxkXntD197w95S6HTd8GO
SKSDJOyfUBv97fuEGYFt2vKZdXaArA/vD1F5I4hAv9a7dhZbXozPAjiUxMakA+o2
JVGBBS1NJi5O3d2MI/Zdozdsh9knK87aseHxL28WG79vEyLZXjVEN9PzENNnGJtL
KiUGivZLOHbIQ+S1gh3FiyaTws81JVDynucQiEPhGWfW+eTGEd/yc6rNfAAaAZmk
+ykQG1X+8eQOdgOOfmUQDhwWXvupZ5vVh3KpNLaZkkBKgnktzMES1c4ZscHzUdnQ
PL3RhMUxDkrLsmYXqimST+SCOc1vPWl/16R+W7ayO6fC4bJCu5ITmqO+eTUvI3Jh
I40XaCINpbQ4wUZaXQkltiw55tckI6xelYWIF/NiZvv85m/FFgU0biM7i1KAlpbI
IXC14gHp4zDQhI0nTNUOR+AGQpejjC3ksObgdY2e6jZbbnYU24dBOFVHqmQcrhYE
RNc2s6YdA6KsEMy7uWD9V2aDNTcPsXSlm64zKYHTGrSHHK40VH3kDoi7Z5t0wcsl
2CR0OwZu27yQg/VQeOgIUv7jBXrF2HxJIBMvkbd9DaorxAaqEzGeKbIZohYcqlnM
YZbPd2syVYI=
=qpvB
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
