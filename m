Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 96CA2DDFAC
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 18:54:24 +1000 (EST)
Subject: Re: [PATCH v3] powermac: proper sleep management
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1177933488.5102.41.camel@johannes.berg>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1177746562.3448.10.camel@johannes.berg>
	<1177933488.5102.41.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-E+COgnFiJxjI2ctX8uQr"
Date: Tue, 01 May 2007 10:55:01 +0200
Message-Id: <1178009702.3483.6.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-E+COgnFiJxjI2ctX8uQr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-04-30 at 13:44 +0200, Johannes Berg wrote:

>  and will break suspend to disk until
> "rework-pm_ops-pm_disk_mode-kill-misuse.patch" from -mm is merged
> (which
> should be soon, I asked akpm to send it early if possible.)

This has now happened, commit fe0c935a6cbf25d72a27c7a345df8a2151de0b74

johannes

--=-E+COgnFiJxjI2ctX8uQr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGNwBl/ETPhpq3jKURAi7pAJ4jx2XYj4a8BsL1ZrbcDjgEzYh03ACcC2f4
M5M12iKcMBlnycNDg68g5Pg=
=nKrR
-----END PGP SIGNATURE-----

--=-E+COgnFiJxjI2ctX8uQr--
