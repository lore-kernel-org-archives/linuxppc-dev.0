Return-Path: <albrecht.dress@arcor.de>
Received: from smtp4.netcologne.de (smtp4.netcologne.de [194.8.194.137])
	by ozlabs.org (Postfix) with ESMTP id 284D5DDFC7
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 03:43:05 +1000 (EST)
Received: from antares (xdsl-84-44-252-246.netcologne.de [84.44.252.246])
	by smtp4.netcologne.de (Postfix) with ESMTP id 8E45CDA918
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 19:43:02 +0200 (CEST)
Received: from antares (localhost [127.0.0.1])
	by antares (Postfix) with ESMTPS id 62419BA04B
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Apr 2009 19:43:02 +0200 (CEST)
Date: Wed, 22 Apr 2009 19:42:55 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: [OT] Lite5200B w/ nfs root hangs after some time
To: Linux PPC Development <linuxppc-dev@ozlabs.org>
Message-Id: <1240422181.5492.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-VzMvo1SKumBo9NLAog9C"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=-VzMvo1SKumBo9NLAog9C
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this question is maybe off-topic on this list...

I use the Lite5200B board with stock kernel 2.6.29, and boot with the =20
root fs on nfs on an Ubuntu 8.10 PC.  Both the Lite5200B and the Ubuntu =20
PC are part of a corporate network.  On the root fs, I have busybox and =20
everything else needed.  Being connected with minicom to the serial =20
console, after some time I always see a message like

[ 4912.350855] nfs: server 10.16.10.29 not responding, still trying

an the the system is *completely* dead, i.e. it doesn't respond to =20
<ctrl>-<c>, it doesn't (as a desktop pc sometimes does) print more than =20
one of these or any other kernel messages, and it doesn't recover from =20
this condition.  Apparently it doesn't matter if just the busybox shell =20
is waiting or if an application is running.

Any idea what goes wrong here, and how I could fix it?

Thanks, Albrecht.

--=-VzMvo1SKumBo9NLAog9C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBJ71cln/9unNAn/9ERAjQ9AKCFkrM/M+98KtGDGeJEig1NVh/6AgCfbn4C
jVvnYqzxPNACyPQXZ5N/GpQ=
=OGMZ
-----END PGP SIGNATURE-----

--=-VzMvo1SKumBo9NLAog9C--
