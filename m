Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 23AA71A0CBC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 16:50:02 +1000 (AEST)
Date: Thu, 16 Apr 2015 16:42:35 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 19/31] powerpc/powernv/ioda2: Introduce
 pnv_pci_ioda2_create_table/pnc_pci_free_table
Message-ID: <20150416064235.GJ3632@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-20-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tKy6e3LXpfmanBFM"
In-Reply-To: <1428647473-11738-20-git-send-email-aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--tKy6e3LXpfmanBFM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 04:31:01PM +1000, Alexey Kardashevskiy wrote:
> This is a part of moving TCE table allocation into an iommu_ops
> callback to support multiple IOMMU groups per one VFIO container.
>=20
> This enforce window size to be a power of two.
>=20
> This is a pretty mechanical patch.

???

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

But apart from that dubious comment in the commit message,

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tKy6e3LXpfmanBFM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVL1naAAoJEGw4ysog2bOS9UMP/if6b3o1+WOaeCrIZdQuBPVW
5CSWIvQaJqhudKLGBM7DSCpWsaC/gpGnBbLXV30+6TFtN04uv9vpPDjbwobucXat
mF2+U6py+Hi91w33pqP6b+lENPpXcXTz/PDG6ifhbryD2tgwgyuIe0kLc4xSGY5y
bz9GkbXrOwCcrL5mPexgJesW2LGPUrmgpE75Lo1y4zXK1XqMiN/Y92p4EpwgXSNb
ROndSYP+tPSPtxWt9UJTXlk7j2c4KV7BbupwXqRPFHIegv1LTYIQ7wDevBUI9aXA
MuNa+Z09CccccxAXyohIzpSWIJp9JTA4knPeBH6zBFoGzgkAAa9h1xDwcBvfypYZ
HbkINBuusTjorPT8W1TKsVpa0j33npwHu+7nhZI2tjVLm2uwAosKuIVXQK6w2sMJ
5/fF980DlkyArXWcrPAfPFWeyfzgV+uv7IMlEGevbToCayidvyvwNiVLKRJZxWTQ
NMK0QfDDpHxmoo/e0XMHzhOKZO0eBk15JIvLvpuVnKC+WQcIrnkhNJwJ2jasp+hK
nlK2iJLjYuvgRSpuwiNp3bKToIRqaRQInnuwwOTUy4Q3jx0fthHu6PJNpRDP3F1V
V06GhiL82/UGJMStqSY/ZaaLF3ZGoVAJw8CJteYRtet1BDs4ZnATNAYlimv5BPPf
DOeD+dfm+rSVSsbiJETf
=ZJKC
-----END PGP SIGNATURE-----

--tKy6e3LXpfmanBFM--
