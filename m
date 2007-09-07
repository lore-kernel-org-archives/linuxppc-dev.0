Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C3030DDEDC
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Sep 2007 00:04:21 +1000 (EST)
Subject: Re: [RFC/PATCH 2/2] Generic clockevents and no-idle-HZ for PowerPC
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18144.4702.673658.336384@cargo.ozlabs.ibm.com>
References: <18144.4702.673658.336384@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-AK6xz3yVKv86NFgej42/"
Date: Fri, 07 Sep 2007 16:04:51 +0200
Message-Id: <1189173891.28781.162.camel@johannes.berg>
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


--=-AK6xz3yVKv86NFgej42/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-09-07 at 00:44 +1000, Paul Mackerras wrote:
> This creates a clockevent for the PowerPC decrementer and registers it
> with the generic clock/timer system, and implements the dynamic ticks
> (no idle HZ) option for PowerPC.

I tried both patches applied and with/without CONFIG_NOHZ but my quad G5
won't boot. Anybody else have more luck?

johannes

--=-AK6xz3yVKv86NFgej42/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBG4VqD/ETPhpq3jKURAj/yAJ47TVDRv+P+dVxBjab7c4nu4VpXqgCgnNPE
srB6p7mAdXwEqnBIxTXUCvI=
=Gp+r
-----END PGP SIGNATURE-----

--=-AK6xz3yVKv86NFgej42/--
