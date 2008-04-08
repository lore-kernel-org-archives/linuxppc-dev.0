Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 020E1DDEDD
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 23:42:21 +1000 (EST)
Subject: Re: [PATCH v3] powerpc: Add irqtrace support for 32-bit powerpc
From: Johannes Berg <johannes@sipsolutions.net>
To: Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <1207670643.5550.11.camel@johannes.berg>
References: <20080404213932.GA15847@farnsworth.org>
	<20080407171428.GA14900@farnsworth.org>
	<1207670643.5550.11.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-PBOCrc4OfCsZf4+c5UJx"
Date: Tue, 08 Apr 2008 23:36:14 +0200
Message-Id: <1207690574.7442.4.camel@johannes.berg>
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


--=-PBOCrc4OfCsZf4+c5UJx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> > This version fixes the clobbering of r12 by the call to
> > trace_hardirqs_off() that was pointed out by BenH.
> >=20
> > Johannes, I'd appreciate your trying this version if/when
> > you get the chance.
>=20
> Thanks Dale, this version seems to work. I'll stress it a bit more
> later, but so far it has survived *much* longer than both previous
> versions.

Hmm. Bad news. I got a crash in console_callback() again where
apparently r28 had a bogus value. That, however, doesn't make sense, so
maybe that register value was calculated from another register.

johannes

--=-PBOCrc4OfCsZf4+c5UJx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR/vlTaVg1VMiehFYAQIUzg/+I01l8m4LxaLWFSw7ejUIoUt9NSGiGIjn
vFWR4cLbPIjKKQ2W+wKaODm5pVGYvE96Rw/tnsccWb0kbZ87A7eUX2RnIZAJH2Ca
WQjDZsEQTQsNfKqNT5/23YLttvlUy9QE4nMGHcmc0kub66Teyq7P8ERIzoVXekkI
BsqdQ88QBukf+GyJ+640qM6TAyl1dVFxbTng2R+wWDamnfR6nv1NOhbxg5dHoYN2
QLWjuDYyTFppJBBQmmlACenB478lCvB9WEwV1uLYDi2QhvQSpL5QB8KYwT9B0VRH
zvYLTw3N+/pTUQmuMPR3v6Hr7SkGUUHQYWISs+Y6hMfqOR/NKIE4KtSP1pjP5Kvf
L9g29klS2JiTikeOb+1kLrzHTpd6Xj/EbzYtKNE4o5V7yANQnff8AYLQXG+4RtkN
FD40RwpJ0DKBBjBgGUmtT6v3iGHah2ckIRnKgl2JkvQgfL6DFJ1yw/b93xyx39IW
fO0wUFifFtnhwd3NlrJx/POBj/TsuTqvmxbMJQySK7gj0Z8q1jbcL+UmTibqwOEJ
tHaJ6xnjnRNsS7fOp79Lsp/S8c8LME0JgryFRDv1AeL5k+j+pySZjnvkWNHL0t53
MtfkR1EhsH5m3dpezMkNIkkBiP0MWnVvLM8ZvV/nFEStoKQCJ55kXBay3QrVd+UY
Q9yqJqvsvvg=
=94MH
-----END PGP SIGNATURE-----

--=-PBOCrc4OfCsZf4+c5UJx--
