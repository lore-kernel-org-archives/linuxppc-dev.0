Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B193CDDF33
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Apr 2007 22:40:53 +1000 (EST)
Subject: Re: [PATCH v2] powerpc: fix suspend states again
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17973.13523.57567.352585@cargo.ozlabs.ibm.com>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1177710095.3565.64.camel@johannes.berg>
	<20070427215338.GB17224@lixom.net>
	<1177710883.3565.66.camel@johannes.berg>
	<1177711372.3565.73.camel@johannes.berg>
	<17973.13523.57567.352585@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-r/otn/428mgF2/4HzkPj"
Date: Mon, 30 Apr 2007 13:35:41 +0200
Message-Id: <1177932942.5102.30.camel@johannes.berg>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-r/otn/428mgF2/4HzkPj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> It would be good to avoid this duplication, or at least to use the
> flush_* calls instead of the enable_kernel_* calls.

I don't like calling prepare_to_copy() since I doubt somebody changing
prepare_to_copy will be aware that it is called there, but using the
flush calls seems appropriate. I had it this way because the original
code used enable_kernel_* and I was mostly copying around the code,
should have looked closer.

johannes

--=-r/otn/428mgF2/4HzkPj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGNdSN/ETPhpq3jKURAhAuAJsHCyVlInaPtdG89tOxEFHeD8HbhwCeMywC
LfxKNrxNKdtWUY/xiwAx4cw=
=M/uN
-----END PGP SIGNATURE-----

--=-r/otn/428mgF2/4HzkPj--
