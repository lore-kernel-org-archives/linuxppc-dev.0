Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C9FC169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 01:56:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F6620836
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 01:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fWPA5z+r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F6620836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43z5NX3T6BzDqRB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 12:56:12 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43z5JK14yrzDqMM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 12:52:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="fWPA5z+r"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43z5JJ6VQtz9s3l; Tue, 12 Feb 2019 12:52:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549936352;
 bh=HOiukM/lhgvJtfbxzNQhOiS6pyn4m/xWB0w7MIx1QYs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fWPA5z+rVPysUo75UZ4LTU5wxN/GKmAo3hEapVI5gI/diAAWLe9Qic+Fmcw4CxCcq
 xPqXZFvvnHuUTwnAU/d/qrmwyobZdovkngg//bXSGTwkuFfRhajuliTq2HNwwbKSId
 P1UpiymjxIn0HhOkTqa29RcV1sb9PaP0ukTJ+mzk=
Date: Tue, 12 Feb 2019 11:20:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel] powerpc/powernv/ioda: Store correct amount of
 memory used for table
Message-ID: <20190212002049.GC1884@umbus.fritz.box>
References: <20190211074801.125646-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline
In-Reply-To: <20190211074801.125646-1-aik@ozlabs.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11, 2019 at 06:48:01PM +1100, Alexey Kardashevskiy wrote:
> We store 2 multilevel tables in iommu_table - one for the hardware and
> one with the corresponding userspace addresses. Before allocating
> the tables, the iommu_table_group_ops::get_table_size() hook returns
> the combined size of the two and VFIO SPAPR TCE IOMMU driver adjusts
> the locked_vm counter correctly. When the table is actually allocated,
> the amount of allocated memory is stored in iommu_table::it_allocated_size
> and used to adjust the locked_vm counter when we release the memory used
> by the table; .get_table_size() and .create_table() calculate it
> independently but the result is expected to be the same.

Any way we can remove that redundant calculation?  That seems like
begging for bugs.

> Unfortunately the allocator does not add the userspace table size to
> ::it_allocated_size so when we destroy the table because of VFIO PCI
> unplug (i.e. VFIO container is gone but the userspace keeps running),
> we decrement locked_vm by just a half of size of memory we are releasing.
> As the result, we leak locked_vm and may not be able to allocate more
> IOMMU tables after few iterations of hotplug/unplug.
>=20
> This adjusts it_allocated_size if the userspace addresses table was
> requested (total_allocated_uas is initialized by zero).
>=20
> Fixes: 090bad39b "powerpc/powernv: Add indirect levels to it_userspace"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/platforms/powernv/pci-ioda-tce.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/powerpc=
/platforms/powernv/pci-ioda-tce.c
> index 697449a..58146e1 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> @@ -313,7 +313,7 @@ long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 b=
us_offset,
>  			page_shift);
>  	tbl->it_level_size =3D 1ULL << (level_shift - 3);
>  	tbl->it_indirect_levels =3D levels - 1;
> -	tbl->it_allocated_size =3D total_allocated;
> +	tbl->it_allocated_size =3D total_allocated + total_allocated_uas;
>  	tbl->it_userspace =3D uas;
>  	tbl->it_nid =3D nid;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxiEWEACgkQbDjKyiDZ
s5JatRAAguPzBBR6ZUHl+YwhgcN/apPEQ2UTh/Ox9mC8c5ZtguX1CNX6OiuhZ0/I
QZ4o7wgQPhX63ifLzRWL/5hX2IkJ6F+weQ+lJj14ePW+YawqSBrxsaIUBlRRNzfS
yczSixeYWVL7XfWpjBgQDfBrYVJzuxfs5sWLqCYn6asKlDQ+/SSqisu7Hh1AZMbi
wwXRJHBMbZnMJ1ESOb4OmuAIc/LRLu28Z9218gkPFjR9pqS2TSvpkqNsvK+45dqA
//OKXzxTQ7Lnh4LvyIoINfQVPxyDIwWaFVpRsDsiHUY2glb46uWy/Brs3L5MpVwZ
Zv3Oc1g4UaSk8LCiqCzIreWAcIgyx79CLeNnEbqc6ECVHxaykqmumUnm8AdLTBan
eikYKCnMDN2tROBQbOtYnNJWSw5TLofKOF5dJ1YMLI2Fpb1kA+/pvoKzBhbRe/ng
opym1avukvhU5l69ydnqN0MeYZXidRPHtgDyct8f3LQir0emRa8rZ3gI9swYM0Ar
1PlGGnZM0aqC/O2pyiQQF2PotNM67wdjYWMx7y4IYAfmqQjS+2SrW/yY/00z4BFU
856yy7WZ673Bujw7iSQCY2H4wlPTZgf8JoSD5T4JG2tvie2jBKsiQJjqW3tSdw3E
ghGOa8Hatb7q8wIIpNsA47eL+iTVlAB0QnmzKu7zTPfYXQ90vxY=
=Nmzp
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--
