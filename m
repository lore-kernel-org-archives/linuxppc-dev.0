Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1Cx21mjQzDqjF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 13:56:22 +1000 (AEST)
Date: Mon, 3 Jul 2017 13:55:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH 1/2] powerpc/xive: guest exploitation of the XIVE
 interrupt controller
Message-ID: <20170703035552.GQ13989@umbus.fritz.box>
References: <1498123757-18427-1-git-send-email-clg@kaod.org>
 <1498123757-18427-2-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Vsi50HYs5tPfr+1I"
In-Reply-To: <1498123757-18427-2-git-send-email-clg@kaod.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Vsi50HYs5tPfr+1I
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2017 at 11:29:16AM +0200, C=E9dric Le Goater wrote:
> This is the framework for using XIVE in a PowerVM guest. The support
> is very similar to the native one in a much simpler form.
>=20
> Instead of OPAL calls, a set of Hypervisors call are used to configure
> the interrupt sources and the event/notification queues of the guest:
>=20
>    H_INT_GET_SOURCE_INFO
>    H_INT_SET_SOURCE_CONFIG
>    H_INT_GET_SOURCE_CONFIG
>    H_INT_GET_QUEUE_INFO
>    H_INT_SET_QUEUE_CONFIG
>    H_INT_GET_QUEUE_CONFIG
>    H_INT_RESET
>=20
> Calls that still need to be addressed :
>=20
>    H_INT_SET_OS_REPORTING_LINE
>    H_INT_GET_OS_REPORTING_LINE
>    H_INT_ESB
>    H_INT_SYNC

So, does this mean there's a PAPR update with the XIVE virtualization
stuff?  Or at least an ACR?  Can we have that available please...

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Vsi50HYs5tPfr+1I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZWcBFAAoJEGw4ysog2bOS4fQP/10BnDdzOOCB3L9EHkq10jV5
tzl0wtjXCz3FAgfOI3xIpB0pb/74KJv9nUzuuFvSyrca8Vq6W7XGqkYKcK8+N7Oz
lDIVRzVCLexMREDSddERTmgofZYhQANnqQRlSgcvljdSJIzFAjWU/doINasX+dA5
D0ylE++f7/EOFOFqAhbZQDsnJNpdD6Y84cDvwehKI09/67ZDE0x6G0oaQld0Yt/G
MRp71/LcjdVFvSr0CtGMnGJrs/IP2rYBsSlO6iQ0gHRqXkwvzDjSDmvJpHDzT5mD
eT/cdD14kIC+yNXJao9Uw21CGckg1Hofn+oOQEI3ZA1I9QPt7X3o3v7dKNfI98MZ
2QkgEcK0bat04NvJNHn9EyxybeDgOHukwKgrp2zXd/RF28xnXHvEr/stpjv06GeO
WzKd8o+zQz9LDYJYr15SEklGECf2Iv3JPyKJqo4ujvp2mgQxghy4HUM/ZYQI9w5R
gh0QGryo+8ViP3APzSz4i4v/bIOtfpPtH7xHRkS5Ud4JIebPG4yQlPWg56TnfdZh
kjsubFsGFAo4jDmt3pg1lLubWvP+0SPDV1NO+TR7UCQOO7Ujh14DVxLSuxHXjZbQ
oCG6Ddu12uPWrUZmp3FPhMJVZfoW9bYsNg6NnDUBtYEEYcenN56LuOjHH0vEFfDi
/FjZMjflSOJvOLGRUEcD
=T5GU
-----END PGP SIGNATURE-----

--Vsi50HYs5tPfr+1I--
