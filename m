Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D7488DDEDF
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 05:38:18 +1000 (EST)
Date: Wed, 4 Apr 2007 21:31:33 +0200
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: my powerbook fails to resume if backlight control is disabled
Message-ID: <20070404193133.GA21755@hansmi.ch>
References: <1175700040.3600.14.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
In-Reply-To: <1175700040.3600.14.camel@johannes.berg>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Johannes

On Wed, Apr 04, 2007 at 05:20:40PM +0200, Johannes Berg wrote:
> The thing is that I had turned off some options to the point where I
> had /sys/class/backlight but nothing in it. I don't know for sure what
> exactly these options were, but I do know that CONFIG_PMAC_BACKLIGHT and
> CONFIG_PMAC_BACKLIGHT_LEGACY were off, though that alone shouldn't
> cause /sys/class/backlight/radeonbl0 to disappear.

It can:
config FB_RADEON_BACKLIGHT
    bool "Support for backlight control"
    depends on FB_RADEON && PMAC_BACKLIGHT
    [=E2=80=A6]

Maybe I can try it during the next weekend.

Greets,
Michael

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGE/0V6J0saEpRu+oRArRoAJ9rh/rm6O+ETtmbs526Kge83tZtGACfZnsv
jNaSWaHUAnVAUKEKzF/LIPk=
=T2x+
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
