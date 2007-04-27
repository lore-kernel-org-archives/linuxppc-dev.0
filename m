Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BC900DDF70
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 22:00:12 +1000 (EST)
Subject: Re: patches for 2.6.22
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/SlWR0LSMK0YUT6V6ogP"
Date: Fri, 27 Apr 2007 14:00:14 +0200
Message-Id: <1177675214.6024.3.camel@johannes.berg>
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


--=-/SlWR0LSMK0YUT6V6ogP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-04-27 at 21:25 +1000, Paul Mackerras wrote:

> If anyone has patches that I haven't picked up yet which they think
> should go into 2.6.22, please send me either a pointer to the
> patches if previously posted to linuxppc-dev, or post them to
> linuxppc-dev.

I'd love to have a bunch of the suspend work in 2.6.22, and even if it's
not the suspend to disk implementation for my G5 but just the suspend to
ram with /sys/power/state for pmu-based machines. However, that depends
on some patches that are still in -mm, what's the way forward with that?
Should I poke akpm to send them out?

johannes

--=-/SlWR0LSMK0YUT6V6ogP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGMeXO/ETPhpq3jKURAnZ5AJ0e5fENg8z/fT1nUgaNT6s2Igl0/wCeMR6m
y7yLMpfWVf21+d4LGlakHPA=
=rkz1
-----END PGP SIGNATURE-----

--=-/SlWR0LSMK0YUT6V6ogP--
