Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CDA07DE077
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 22:47:16 +1000 (EST)
Subject: Re: [PATCH] powerpc: dart iommu suspend
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1178195447.6353.40.camel@localhost.localdomain>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1178195106.13233.108.camel@johannes.berg>
	<1178195312.13233.111.camel@johannes.berg>
	<1178195447.6353.40.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-cczf5sC6HSlPwFa8CpJP"
Date: Thu, 03 May 2007 14:48:11 +0200
Message-Id: <1178196492.8233.1.camel@johannes.berg>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-cczf5sC6HSlPwFa8CpJP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-05-03 at 22:30 +1000, Benjamin Herrenschmidt wrote:
> That would make it "just work" with the normal code path.

We still need the iommu restore hook to invalidate the entries, so that
API I add there is needed anyway. Who actually saves the code doesn't
really matter at that point. The save hook isn't strictly necessary then
but I guess it should be there for symmetry anyway.

Maybe somebody can offer opinions on other iommus?

johannes

--=-cczf5sC6HSlPwFa8CpJP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOdoL/ETPhpq3jKURAs/9AKCMxfYJGIyeKdcCUQ05zJC8SsRHTQCglrf7
/SnZudKkRLA2LLaLtuMkvT0=
=8RBR
-----END PGP SIGNATURE-----

--=-cczf5sC6HSlPwFa8CpJP--
