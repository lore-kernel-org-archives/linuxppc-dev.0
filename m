Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7B439DE162
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 06:21:18 +1100 (EST)
Subject: Re: [PATCH/RFC] via-pmu: remove mdelays from suspend/resume code
From: Johannes Berg <johannes@sipsolutions.net>
To: Brad Boyer <flar@allandria.com>
In-Reply-To: <20080404172006.GA13980@cynthia.pants.nu>
References: <1207237484.3797.2.camel@johannes.berg>
	<20080404172006.GA13980@cynthia.pants.nu>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-r280dCMwKLhPj6C4NJIn"
Date: Fri, 04 Apr 2008 21:21:04 +0200
Message-Id: <1207336864.19189.74.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-r280dCMwKLhPj6C4NJIn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Fri, 2008-04-04 at 10:20 -0700, Brad Boyer wrote:
> On Thu, Apr 03, 2008 at 05:44:44PM +0200, Johannes Berg wrote:
> > I don't see a reason for either of those mdelay()s, is there any? Works
> > fine for me without them...
>=20
> Which hardware revisions did you test? I suspect the mdelay calls were
> added to work around timing issues in one of the older PMU chips. Some
> of them are very timing sensitive, and sleep in particular is basically
> a pile of steps that got hacked until they worked on older systems.

Mine's a 5,6 powerbook with PMU firmware 0x0c. The mdelay(100) seems
fairly large though for a point where we're out of pmu code already, and
the other one doesn't really seem too pmu related anyway. In any case,
just wanted to float that, don't see a particular need for it.

johannes

--=-r280dCMwKLhPj6C4NJIn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR/Z/n6Vg1VMiehFYAQKUaxAAh4YypFieyg0A8wFocj4RkcMxXJiUjE8Z
mDHQ1dEw75g6qU9PrE2RTjwhPgcXgCCI63RIObXRjHQS6AWm26jHAtuAcfDwVdqU
A8JakGRPDAofOUoIdK8E4EONxbbixonsAAh1xgQ9gr4pYSoO6E+X1CzcJovZ+D9o
UCExeua7uEz/wEQmHQIDuudb6qhvN8PRV1LJBPNPw4xroOROwdcx2GauO+g5AD51
zzDGVAvdAKyWRqizKIIbTkXyQ8hADqMj3OTmBQoROOjBu8v4EcN9uJkFQS9SATo7
39UFHsIYpvLFJ3+2chgH1ow4IM6la9/3eh9DurLKVMksxdtu8iVCBey5hho4/wOb
1hp/ZChEPuxca9w6r533hMSr+2Q8sCya9fentM0RICcKHbjl454Gi6dxM7fHwD4k
NJJkbVMiTQBbDKf5rQYCxEL16Z+O1+rexfc5swV9crdYBOrf4PX1evVKNwx87hYl
mvLtnywwQnhMlEe7suHfTp6dWe+vy2L2Q2FzOFsXvHvFZ3DbJm4ZrOAdPtWq5bvA
G0hDsLkU3p3/c8TOUfUNNJhYwCAOOUj85Frrs2a5Bm0f3FOvsPml4c2/hBYZEVa+
uHmFLdWlvCuYGUW1WOxgRorWb+gRBfheCSOLj44OuE7xYZOuOC5A7IdCmd4lBcbQ
q4NPdH/eIXM=
=50kf
-----END PGP SIGNATURE-----

--=-r280dCMwKLhPj6C4NJIn--
