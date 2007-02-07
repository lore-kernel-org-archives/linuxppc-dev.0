Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A85D5DDEF8
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 23:24:19 +1100 (EST)
Subject: Re: [RFC 10/10] powermac: fix G5-cpufreq for cpu on/offline
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20070205185838.837935000@sipsolutions.net>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185838.837935000@sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-2ybR2Rnv/PhBoQo+DTyJ"
Date: Wed, 07 Feb 2007 13:21:23 +0100
Message-Id: <1170850883.6798.27.camel@johannes.berg>
Mime-Version: 1.0
Cc: cpufreq list <cpufreq@lists.linux.org.uk>, linux-pm@lists.osdl.org,
	Jacob Shin <jacob.shin@amd.com>, Torrance <torrance123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-2ybR2Rnv/PhBoQo+DTyJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-02-05 at 19:30 +0100, Johannes Berg wrote:

> The original code here is wrong, it applies "previous" knowledge.
> The way the cpufreq core is designed is that the policy for the
> secondary CPU that comes online says that it must in fact not
> use this policy but use the same as the other CPUs that are
> listed, which in fact is CPU#0.

> Not tested yet but from what Jacob said this should work.

Works great, will resend with proper signed-off-by etc. Thanks again
Jacob for explaining how it should work.

johannes

--=-2ybR2Rnv/PhBoQo+DTyJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFycRD/ETPhpq3jKURAsELAJ9iHqYVXP4qp1dc+mWyph5ivJoN5gCeMLQV
VtOydeOUEsZGrl/bNdg+vP4=
=MKhI
-----END PGP SIGNATURE-----

--=-2ybR2Rnv/PhBoQo+DTyJ--
