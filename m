Return-Path: <florian.fainelli@int-evry.fr>
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by ozlabs.org (Postfix) with ESMTP id 6D0C0DDDE4
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 04:35:30 +1100 (EST)
From: Florian Fainelli <florian.fainelli@int-evry.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Front LED on Mac mini G4
Date: Tue, 20 Feb 2007 18:35:06 +0100
References: <200702201433.12851.florian.fainelli@int-evry.fr>
	<1171987020.15489.177.camel@johannes.berg>
In-Reply-To: <1171987020.15489.177.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1350704.zYqndmjSl0";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200702201835.14882.florian.fainelli@int-evry.fr>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1350704.zYqndmjSl0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Johannes,

Le mardi 20 f=E9vrier 2007, Johannes Berg a =E9crit=A0:
> On Tue, 2007-02-20 at 14:33 +0100, Florian Fainelli wrote:
> > I would like to know whether it is possible or not to modify the
> > via-pmu-led driver to make it work with the Mac mini G4 front LED, is
> > there anything particular with this model ?
>
> Not sure. If it's a PowerMac10,1 I think it should work.

It is a PowerMac10,1. After bypassing some device checks in via_pmu_led_ini=
t,=20
I tried : echo 0 > /sys/class/leds/pmu-front-led/brightness

which resulted in : PMU: bad reply len 85 and the brightness not changed of=
=20
course.

the check is in via-pmu.c line 1500

Do you know what could cause this reply ?
>
> > By the way, why is this driver only available as in-kernel and not modu=
le
> > ?
>
> Because it's just an option of the via-pmu driver.
>
> johannes



=2D-=20
Cordialement, Florian Fainelli
=2D--------------------------------------------
5, rue Charles Fourier
Chambre 1202
91011 Evry
http://www.alphacore.net
(+33) 01 60 76 64 21
(+33) 06 09 02 64 95
=2D--------------------------------------------
Association MiNET
http://www.minet.net
=2D--------------------------------------------
Institut National des T=E9l=E9communication
http://www.int-evry.fr/telecomint
=2D--------------------------------------------

--nextPart1350704.zYqndmjSl0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)

iD8DBQBF2zFSQ/Yr6D8A81kRAuTAAJ9+YTawTmOxYa9rfWjtFLRlbLS2AgCfT0Ms
BF6vxuMCoQcUzMdv3tHVCyw=
=qTWK
-----END PGP SIGNATURE-----

--nextPart1350704.zYqndmjSl0--
