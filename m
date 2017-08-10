Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSd6B2jj4zDqrP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 16:10:26 +1000 (AEST)
Date: Thu, 10 Aug 2017 15:54:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 02/10] powerpc/xive: guest exploitation of the XIVE
 interrupt controller
Message-ID: <20170810055426.GV13670@umbus.fritz.box>
References: <1502182579-990-1-git-send-email-clg@kaod.org>
 <1502182579-990-3-git-send-email-clg@kaod.org>
 <20170809035306.GC13670@umbus.fritz.box>
 <f82c1111-3dd3-f378-0ff6-222bffc07a35@kaod.org>
 <20170810042849.GU13670@umbus.fritz.box>
 <1502340360.2563.53.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="X6f5cqjOqKjuoPgI"
In-Reply-To: <1502340360.2563.53.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--X6f5cqjOqKjuoPgI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2017 at 02:46:00PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2017-08-10 at 14:28 +1000, David Gibson wrote:
> >=20
> > Also, will POWER9 always have doorbells?  In which case you could
> > reduce it to 3 options.
>=20
> The problem with doorbells on POWER9 guests is that they may have
> to trap and be emulated by the hypervisor, since the guest threads
> on P9 don't have to match the HW threads of the core.
>=20
> Thus it's quite possible that using XIVE for IPIs is actually faster
> than doorbells in that case.

Ok, well unless there's a compelling reason to use doorbells you can
instead make it 3 cases with POWER9 never using doorbells.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--X6f5cqjOqKjuoPgI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmL9QwACgkQbDjKyiDZ
s5LaORAAzqfoo64K3ZYcMtqQ8f13n9CpgqxsCSSc/nxMzhnMB2ynehZzLJtFbypu
CIoKUJPJGzES+6lOrv4zj9oiQEwBwBWrI/tEYDx/5UVVeo1AcDvpt3U2z8PfTjB6
ldBXAiQ5MpLX79nsZaFsjK/z8+sNeV+LDGeV7lu8InD1GaDkjnq8Eg/QKbx4KVl7
+eNlQSrWjnYd6Lie4bUJ0bPbSRvIPSRs1f/n/NvmiZ1qgr0DxigKV1UXFgpikDgV
zudUYGvWtxey7fO2P8cxjnhF+m3C5xW/woaY5kR8PjjLogzGtfz7URXt/vsFhiuJ
UvXBMlDVRAOl7oJPWupNBD0s90BCdcdbVaqpXSQqv6s8elNISiHD2hCqwp2SgD0Q
x32qeOALMGceqbBbEEWu+W0QFO0G1n11+ixi9g4Y0hlMwM8jMLnCfU179w6pFBFo
heNr8gGxvnB/kpEY+l7XI/tlMqfCAByJ05gS51SshiuhQHKlIZxtKwG6HLDq9dw2
bhQDzaJHM3QKubwZ1trayh95S7ITtQrvDb0d19vhSa8LS7GL+fZPiOBaZJ89ewYJ
dZOF6Vsa60DnoTjfto4H9uShzk+j5meQQMfkTr0ZqGazowehLl5Y3fhRh4+1gd7k
jzYpGXiJJix/ZBIuP6qvucYSJNFktXSznZG4s9UQ1xhqPCHrWfc=
=DLs6
-----END PGP SIGNATURE-----

--X6f5cqjOqKjuoPgI--
