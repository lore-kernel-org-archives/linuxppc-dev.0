Return-Path: <toojays@toojays.net>
Received: from smtp3.adl2.internode.on.net (smtp3.adl2.internode.on.net
	[203.16.214.203]) by ozlabs.org (Postfix) with ESMTP id 0AB8E2BC0F
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Oct 2004 18:58:52 +1000 (EST)
Received: from nev.toojays.net (ppp48-50.lns1.adl2.internode.on.net
	[150.101.48.50])
	by smtp3.adl2.internode.on.net (8.12.9/8.12.9) with ESMTP id
	i9K8wfOU073128
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Oct 2004 18:28:43 +0930 (CST)
From: John Steele Scott <toojays@toojays.net>
To: linuxppc-dev@ozlabs.org
Date: Wed, 20 Oct 2004 18:27:57 +0930
References: <20041018232004.0a9e0d5e@jack.colino.net>
	<1098168058.15029.45.camel@gaston>
	<20041020094651.5ceff814@pirandello>
In-Reply-To: <20041020094651.5ceff814@pirandello>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1154724.LK66ULBKAe";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200410201828.04655.toojays@toojays.net>
Subject: Re: PMU questions
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1154724.LK66ULBKAe
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> I can't find a logic in this stuff... Do you think there's a special
> reason why Apple uses such a complicated method instead of
> a) charging until voltage stays equals for a few minutes
> b) draining until voltage goes under 13.5 volts (or 13, or whatever)
>
> In my uninformed opinion that would work better, wouldn't it?

My opinion is only slightly more informed than yours, but I do know that th=
e=20
characteristics of modern rechargable batteries (lithium-ion or similar) ar=
e=20
quite complicated . . . for instance even the method of charging them=20
requires special controlling circuitry.

cheers,

John

--nextPart1154724.LK66ULBKAe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Messages with missing or bad signatures may have been forged or modified in transit!

iD8DBQBBdiic0BW7kPcXjRURAjnIAJ40t7HUMqY9quRnlhX4qeFoWb9WVwCg+p+M
pQeV0IxmzBdeyZ1CHXKhQSs=
=xQaV
-----END PGP SIGNATURE-----

--nextPart1154724.LK66ULBKAe--
