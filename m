Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2dP813D9zDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 21:07:08 +1000 (AEST)
Date: Wed, 5 Jul 2017 21:07:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC PATCH 1/2] powerpc/xive: guest exploitation of the XIVE
 interrupt controller
Message-ID: <20170705110702.GO2180@umbus.fritz.box>
References: <1498123757-18427-1-git-send-email-clg@kaod.org>
 <1498123757-18427-2-git-send-email-clg@kaod.org>
 <20170703035552.GQ13989@umbus.fritz.box>
 <1499055599.16202.23.camel@kernel.crashing.org>
 <18d0c283-3527-d599-36d8-4397a0a4d6db@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5G50dybFf3pRZKd7"
In-Reply-To: <18d0c283-3527-d599-36d8-4397a0a4d6db@kaod.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--5G50dybFf3pRZKd7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 03, 2017 at 09:11:18AM +0200, C=E9dric Le Goater wrote:
> On 07/03/2017 06:19 AM, Benjamin Herrenschmidt wrote:
> > On Mon, 2017-07-03 at 13:55 +1000, David Gibson wrote:
> >>> Calls that still need to be addressed :
> >>>
> >>>     H_INT_SET_OS_REPORTING_LINE
> >>>     H_INT_GET_OS_REPORTING_LINE
> >>>     H_INT_ESB
> >>>     H_INT_SYNC
> >>
> >> So, does this mean there's a PAPR update with the XIVE virtualization
> >> stuff?  Or at least an ACR?  Can we have that available please...
> >=20
> > There is, I will try to get it published.
>=20
> Until then, the QEMU support will have some documentation on the=20
> hcalls and on the device tree.
>=20
> I am still struggling with CAS on QEMU. POWER9 supports both the=20
> legacy XICS model and the newer one, XIVE, and we can switch from=20
> one another depending on the guest kernel. This is a serious=20
> headache for the model as the ICS/ICP objects are chosen after=20
> the guest has booted.

Ah.

I don't know if it helps, but we do have the ability to trigger a full
system reset from CAS, so possibly we can do the XICS/XIVE
instantiation in the reset path.

I don't think we use that CAS reset ability yet - we just adjust the
device tree and continue the boot.  But it's there if we need it.

Worst comes to worst, we might have to instantiate both XICS and XIVE
objects, with some flags in each indicating which is active.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5G50dybFf3pRZKd7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZXMhWAAoJEGw4ysog2bOSPRoP/1yDRpDNAfz5m1ADVmeSxb82
+7TJ6Y6eCejD1ysQ9eT0QFv0m1FLDbZa5Mb9dCU2Db6N5pzePxMyCx+vbhIiSL/u
lWAp6EOuzJwR+TLwLu1UKjf4DyTryXS8yhx4Sk780KlDF5AvNuS8a+0KDnNc+y8I
LDxSQqIBUQCj5wYVPAA5guzTH3NLyCeAXTpFIobyKf/D8YrPWzRE8693YVhO29no
SCTa4DJgK9WqU7ohcQtvo/PdFRbwR7D05JO3yo2rcD0+wX2HHkUxxJw3wWl0LCKc
6FhPVCj6uD5zFFsPQPzf09/J6if6qU4MrNgNRgjhEvd+9zcjAMmVw4OPUii4aM+J
Ukx68zfGEP+jB7jzQ7At874pgaBT4lY6CubRysejop0qhxUa90gYAZ7ketELuXbn
MBxorRa8yueFbShYI/5ptjWwtvK+RVAFAfKpdyscY4djwbwgWsdpKx9xGWBS+ZGC
tv8sWJza6NmO+BOtM0+2UQooWuh9K7yJdMy0iDnoN03dEb0PuFxXrAO7M5i8W7mG
366O8Ri4r+a4USt/vXEXQSWvmQzFjTH3eubNWy4Dgj43pM/5VJsMmVakteoJmgVD
c4ypnqQpjHs/9zw4eZiPPz5823EKXGn7BivDhSp4U12dIEFmA+P9Q89R/6MlkTUG
wbsBf7wheXEbgL2VliiL
=v2jY
-----END PGP SIGNATURE-----

--5G50dybFf3pRZKd7--
