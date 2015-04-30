Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5C0F01A0415
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Apr 2015 14:37:59 +1000 (AEST)
Date: Thu, 30 Apr 2015 14:05:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 09/32] vfio: powerpc/spapr: Rework groups
 attaching
Message-ID: <20150430040525.GA15238@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-10-git-send-email-aik@ozlabs.ru>
 <20150429021618.GH32589@voom.redhat.com>
 <5541938A.6050803@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
In-Reply-To: <5541938A.6050803@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2015 at 12:29:30PM +1000, Alexey Kardashevskiy wrote:
> On 04/29/2015 12:16 PM, David Gibson wrote:
> >On Sat, Apr 25, 2015 at 10:14:33PM +1000, Alexey Kardashevskiy wrote:
> >>This is to make extended ownership and multiple groups support patches
> >>simpler for review.
> >>
> >>This should cause no behavioural change.
> >
> >Um.. this doesn't appear to be true.  Previously removing a group from
> >an enabled container would fail with EBUSY, now it forces a disable.
>=20
>=20
> This is the original tce_iommu_detach_group() where I cannot find EBUSY y=
ou
> are referring to; it did and does enforce disable. What do I miss
> here?

Sorry, my mistake.  I misread the patch.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQaoFAAoJEGw4ysog2bOSXssP/0RhHwQyTQnAvXYz0vGTuk/B
n97llIISOwYw+NArxTpD2cndYGzs/sZcJTGJFw6d3RiUmMAYPx0NvISjenWjuADe
BP4+K6gBxD1X1EZ58odRaDFIHHKL2rwOGFmPhF3gbmgJEo6Ezrz5n1M0JJy/V6js
FpisvjyrEYaAc//Soi5CMv4kfwSEs2sXG7AmKGS05yw71NqgjtybFn2E/1Mj0iPl
Op1j4BX3CBdZ4KVrOWYUYbnmylZ/QIYsWJFksAHSu+kRd8n/2e1UL7EBvJ+ZXCvK
tONkUst1zc6I9v8RWyQ1HlGaKgjFNp3B4Jp7JyV9vxjRZXaauUGZmf+r4A4POf+7
TOIwW77qV1tSW9ArAZk33JYn2IOJehoiU0eB6LxsMMEX+352/yCFDsUGKJaXZc06
VMcWUc2EJSf3ZA/sz5u9Z4HtX5oDIX+600px6aXp+h7QLNDE+airf2+B7+9Kcttc
aiLkFZo0OHED/8SYPSYHguuJPjCFVPIxUuaGvYKaaOGNMko17fuIMf8kAEe7wg25
XAltqO0fvKgH1rZQ1rPtN8RyatCGzANLT9PuQdZB6fBJkuhIo7vuO2D2vym4G48j
FYX8N5k62Zu4nRVz3DEZoi3frQF8lgfROuKG9lBwdt7kLaPbXHh/02qFFTga263i
s5Zbq7ZtmhyQy+v/jO6l
=W/tB
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
