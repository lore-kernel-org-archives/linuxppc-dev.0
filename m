Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26DAFDDF08
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 23:26:02 +1100 (EST)
Subject: Re: [RFC 07/10] powermac: support G5 CPU hotplug
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20070205185837.640324000@sipsolutions.net>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185837.640324000@sipsolutions.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/Vyw/k4wGB0BAb05OPNU"
Date: Wed, 07 Feb 2007 13:23:08 +0100
Message-Id: <1170850988.6798.31.camel@johannes.berg>
Mime-Version: 1.0
Cc: Torrance <torrance123@gmail.com>, linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/Vyw/k4wGB0BAb05OPNU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-02-05 at 19:30 +0100, Johannes Berg wrote:

> This patch allows "hotplugging" of CPUs on G5 machines. CPUs that are
> disabled are put into an idle loop with interrupts hard-disabled, to wake
> them up again we kick them just like when bringing them up.

testing with forced preemption revealed that the preempt count is messed
up. Will resend with the fix. The hardirq count is still strange...

johannes

--=-/Vyw/k4wGB0BAb05OPNU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFycSs/ETPhpq3jKURAuExAJ4hTToa16FXWkg1+kMcHRoc84lRmwCeKWL+
cYNXlPKJBenJLgR3abzuj4Q=
=J8VI
-----END PGP SIGNATURE-----

--=-/Vyw/k4wGB0BAb05OPNU--
