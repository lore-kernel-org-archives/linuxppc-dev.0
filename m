Return-Path: <nico-linux-ppc@schottelius.org>
Received: from scice.schottelius.org (ns.schottelius.org [213.146.113.242])
	by ozlabs.org (Postfix) with SMTP id A72F267A7A
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Feb 2005 22:11:58 +1100 (EST)
Date: Fri, 18 Feb 2005 12:13:04 +0100
From: Nico Schottelius <nico-linux-ppc@schottelius.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Message-ID: <20050218111304.GH5801@schottelius.org>
References: <20050118094216.GB25470@Redstar.dorchain.net>
	<20050126113554.GD19633@schottelius.org>
	<20050127163606.GN14866@Redstar.dorchain.net>
	<20050118094216.GB25470@Redstar.dorchain.net>
	<20050126113554.GD19633@schottelius.org>
	<1106746946.6250.56.camel@gaston>
	<20050208075421.GB21154@schottelius.org>
	<8f293b6dbedd2ae1a825608a48a0604b@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HkMjoL2LAeBLhbFV"
In-Reply-To: <8f293b6dbedd2ae1a825608a48a0604b@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Heartbeat LED for iBook
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--HkMjoL2LAeBLhbFV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Segher Boessenkool [Mon, Feb 14, 2005 at 02:14:40PM +0100]:
> >Btw, howto control it via /dev/adb? Can you point me to a document
> >which explains that?
>=20
> Write a byte 0x06 followed by the PMU packet (all in one write());
> read back the PMU reply (all in one read()).

What exactly does 0x06 mean? Flash led? Isn't there some kind of
"bright-led" "5V,12V,24V" settings available? I mean I want to be able
to change the brightness.

And what is the PMU packet? One Byte, two byte, value 0x2342?

Please point me to a FM about adb.

Nico

--=20
Keep it simple & stupid, use what's available.
Please use pgp encryption: 8D0E 27A4 is my id.
http://nico.schotteli.us | http://linux.schottelius.org

--HkMjoL2LAeBLhbFV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iQIVAwUBQhXNvrOTBMvCUbrlAQK4ZxAAns1BPcb9rgZPNXBNQXiKZQVUldgSo73d
Mqvsw3Q6rdViOV83SuTOxGtlLyVDjDfb4IgYG37q/aJ9E5ZZCPwIF6XgXClVtiJD
awxnVD4Aos3C4astWuN2plgvxasmmRBFrLobehDLZWH80hkkM8ofnQa+Le8qJhIR
9hVhGbDouydI31a03PKUQvL+NQSMx0TQxR0f2PDAnBN/ofUVnemCBGIF9gZ32483
Z1ekCDyKQl3tWIaIqY383HpasqM2jHVXnE7q+vI7ihdM+C+iBLQ30VAPs+7saAtF
dXh22WSUxbv7Z8wyufaeAFcOR/cSi9oXtbv9xBbUE2L/edeOTCHakOs07/CDc0Na
t9PSayXPJKfL4Wp/U7F0h1gmh/aLA6iOeFX3/UgyCb7399otO55JcVKcmx62NyjO
0RgYcHDrXIl5CiEJYY8ouEJaUl28YoXYFfRR+SjWGu+/FVS7FzyAkTLckHx0CTXj
DqYejnypuUgPisr7PHG9gAUyhh7zmxEX1+Pak5yFLUX5em5IjV2pPCgHsg8IfLjp
SaawGWq5P7yHTZq9KmvbbuCEVUJVENfbZnZ8957bEzZDmSBKJU+f2BYg3cJ3ANwa
lLpwTa3L2eaF67EPpN3uprGqzR2fWGw63fwLdP8dA75Srm0uVY6Y+g99xuIj+GTd
QpiO+7m1EXY=
=Cm60
-----END PGP SIGNATURE-----

--HkMjoL2LAeBLhbFV--
