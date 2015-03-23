Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D3701A2A9E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Mar 2015 12:39:01 +1100 (AEDT)
Date: Mon, 23 Mar 2015 12:33:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/2] powerpc/eeh: Introduce eeh_pe_inject_err()
Message-ID: <20150323013340.GD25043@voom.fritz.box>
References: <1426881525-11044-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1426881525-11044-2-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5p8PegU4iirBW1oA"
In-Reply-To: <1426881525-11044-2-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, linuxppc-dev@ozlabs.org, alex.williamson@redhat.com,
 agraf@suse.de, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2015 at 06:58:44AM +1100, Gavin Shan wrote:
> The patch defines PCI error types and functions in eeh.h and
> exports function eeh_pe_inject_err(), which will be called by
> VFIO driver to inject the specified PCI error to the indicated
> PE for testing purpose.
>=20
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5p8PegU4iirBW1oA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVD210AAoJEGw4ysog2bOSOXoQALVPrPouyLwCJb9Vqx1hfJDx
pGsn237qSFj6KWsP6kspuh7qgZe+b2c09ndF+yRj1CL0aqjrwlG5jSuJwH+RgFM9
uUfZw6n3AvDo3LlwgeWObHYeciT+eMkkeA0E0bsFzTSYXlJvpsukITScv3hYIi+E
aA56yRVV0f7+FIpXf29F0lso9HClzBgWJ4lxyLnFn0bwrHvzboKXyVlf5yED+P25
fgAL+xh1wfYDtYwUoVpnH4V7LhNdjRMoLqS2iRGhX0iHkGUSx9jfwJ7QE6vNJDj3
Gq2jigUahS1IJdHV2zT2j4LMlUsYYJWzl8gnJxTUSgiIczNXbs9KaEkVAYoAqJat
1/QNqP9OjvmLSX8l3Co48JquZTSpPKvyThLdrLYPRjOwZqMbo4KdJHNXW9wUJJ3/
9JjsEA3mRT4Piyx4K7yaiAUKBnqh8o0a1nYIWGwEtk6PDmhUIbltFd7f4RXB98I5
tSy2TwoOZF5iIIZF/XWRoAcpfOSOvn6XhcfRf2Hkw5/VX///9jNYgUiJigqnI1d5
OU1+rixknv+9qWCQb223u64PhyQ+EO4hqNTvysbM1+RtrzgnXCsRajHUMc6BrGtw
RHhEnrQCqOOrLXnDRHSw3pDNACeNZCwcjCJmb6JjfOFEx684L+c6EiqAe3B5d2Ux
ttHDdJg0qv7We/LDGR/E
=b7e4
-----END PGP SIGNATURE-----

--5p8PegU4iirBW1oA--
