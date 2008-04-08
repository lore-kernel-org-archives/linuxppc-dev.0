Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84CFADDE21
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 02:04:15 +1000 (EST)
Subject: Re: [PATCH v3] powerpc: Add irqtrace support for 32-bit powerpc
From: Johannes Berg <johannes@sipsolutions.net>
To: Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <20080407171428.GA14900@farnsworth.org>
References: <20080404213932.GA15847@farnsworth.org>
	<20080407171428.GA14900@farnsworth.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-EEZ9fBvHG1fnjpnE+F8c"
Date: Tue, 08 Apr 2008 18:04:03 +0200
Message-Id: <1207670643.5550.11.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-EEZ9fBvHG1fnjpnE+F8c
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Mon, 2008-04-07 at 10:14 -0700, Dale Farnsworth wrote:
> Add the low level irq tracing hooks for 32-bit powerpc needed
> to enable full lockdep functionality.
>=20
> Dale Farnsworth <dale@farnsworth.org>
> ---
> This version fixes the clobbering of r12 by the call to
> trace_hardirqs_off() that was pointed out by BenH.
>=20
> Johannes, I'd appreciate your trying this version if/when
> you get the chance.

Thanks Dale, this version seems to work. I'll stress it a bit more
later, but so far it has survived *much* longer than both previous
versions.

johannes

--=-EEZ9fBvHG1fnjpnE+F8c
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR/uXcqVg1VMiehFYAQL+vg//U9Jvj22bjt7006uc98lKEjMBbUrhlMHt
lIKuxkv28/BjYAiqq3dyMwIiXaTQ8Xv2nk8akcj7zjqvUzVk1DmCDGGV6JtDTqXF
uRr2U7i/S+UVdA8EpAsMQ5apzDyeCMuiDfVVC3BJkxBFQN2nlbbWtOZ/PVEW8T1w
RfI1Cu0Ei7+76cbKXiNKPHLvlIT3NM0Pgs2FYoz/a702pYuG7qfVr7KM1gvbWUCz
fuTQEk2tyKUGJY5Y6O+r/tHRLrr3KiX1ELvyjX15ZXe/oYve/zw0UnYXe6CgrS4B
ux1JAySk8FzwuXnV7XUYHdq2RcIZP1b9D06i5X+zCpgft8u79nFdZvcXeMQ4yUUC
9uefNFVWvcOqb7F3YOmhws2NeTKiBnjsthcMrOutApR5OOs4MGxIuwPCkXIObKOo
QtCJ49EwEWK+kmu/O7CBuu0DKQCXQh+6IV2R5wXI+krz0HLuL7OueW+Ef4s4UFvk
OHIQbA4J7DGvyt2/Z8Ag4WZAiMEo0kNyMWAd1qv6GndBud9sP6FtSWOBdxsxomyy
SgwSpRUE8L7HMfpLR9D4Vs9r/cFO60VyjEutrPnwzQEtW1nfDYMMO5+zGe6Ja2m0
CX2ai3LCvIN5TG5/474OOwtldRkxJJUmMOWSMUOp/Ys6P4Lm+NAq9AvFidso9Svb
GsLgrXlpnHU=
=3aTn
-----END PGP SIGNATURE-----

--=-EEZ9fBvHG1fnjpnE+F8c--
