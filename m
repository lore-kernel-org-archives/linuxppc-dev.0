Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AFCCEDDE41
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 22:23:40 +1000 (EST)
Subject: Re: [PATCH] powermac: proper sleep management
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17975.12087.73762.795635@cargo.ozlabs.ibm.com>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1177746562.3448.10.camel@johannes.berg>
	<17971.14223.435220.418649@cargo.ozlabs.ibm.com>
	<1177767996.5102.9.camel@johannes.berg>
	<17973.32577.253554.707441@cargo.ozlabs.ibm.com>
	<1177934887.5102.65.camel@johannes.berg>
	<17975.12087.73762.795635@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-bSsgLdoXg+Jp1oSTglC8"
Date: Tue, 01 May 2007 14:24:16 +0200
Message-Id: <1178022256.3483.29.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-bSsgLdoXg+Jp1oSTglC8
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-05-01 at 22:14 +1000, Paul Mackerras wrote:

> Bottom line is I'm not going to apply a patch that makes pmu_ioctl
> call pm_suspend.

Alright, I'll drop the patch. What about suspend to disk for G5?

johannes

--=-bSsgLdoXg+Jp1oSTglC8
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGNzFw/ETPhpq3jKURAg+9AKCQa59thZQ5Z8NzgRja2S1yfSofggCfQFs+
Gca1d5hjUlB4g0mXMMjJOu4=
=ssx+
-----END PGP SIGNATURE-----

--=-bSsgLdoXg+Jp1oSTglC8--
