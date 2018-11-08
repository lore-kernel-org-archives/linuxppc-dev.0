Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C71C32789
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 06:19:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 539BC20827
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 06:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZGecsgN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 539BC20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rCn90VKNzF3Ld
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 17:19:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZGecsgN5";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rCkT27x1zF3J1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 17:17:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="ZGecsgN5"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42rCkS6SRSz9sBk; Thu,  8 Nov 2018 17:17:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1541657856;
 bh=9aMtEMZOJeWZocuVMX9YvCGvp/AQSrx89Fkb+hrN9gY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZGecsgN56wII3Lp5I+7FlI+VeAFNNGRhUa1eiUibh7XNVdaXSnimfVqe6CjphSeW3
 NAg1e1AXPUKJf1YSynoJu6f7FBYS6ErVuTQd9ZyYVXxN6f4wPras2u3DE3AVKnBZQc
 fcNrdVFZKkNXOMzcklHG1A0F5B+4KlUDkU04t6qM=
Date: Thu, 8 Nov 2018 17:04:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel 1/3] vfio_pci: Allow mapping extra regions
Message-ID: <20181108060422.GP5575@umbus.fritz.box>
References: <20181015094233.1324-1-aik@ozlabs.ru>
 <20181015094233.1324-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AwNVUpjOmSj7UnwZ"
Content-Disposition: inline
In-Reply-To: <20181015094233.1324-2-aik@ozlabs.ru>
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
Cc: kvm@vger.kernel.org, Alistair Popple <alistair@popple.id.au>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, Reza Arbab <arbab@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--AwNVUpjOmSj7UnwZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 08:42:31PM +1100, Alexey Kardashevskiy wrote:
65;5402;1c> So far we only allowed mapping of MMIO BARs to the userspace. H=
owever
> there there are GPUs with on-board coherent RAM accessible via side
> channels which we also want to map to the userspace. The first client
> for this is NVIDIA V100 GPU with NVLink2 direct links to a POWER9
> NPU-enabled CPU; such GPUs have 16GB RAM which is coherently mapped
> to the system address space, we are going to export these as an extra
> PCI region.
>=20
> We already support extra PCI regions and this adds support for mapping
> them to the userspace.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> Changes:
> v2:
> * reverted one of mistakenly removed error checks
> ---
>  drivers/vfio/pci/vfio_pci_private.h | 3 +++
>  drivers/vfio/pci/vfio_pci.c         | 8 ++++++++
>  2 files changed, 11 insertions(+)
>=20
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_=
pci_private.h
> index cde3b5d..86aab05 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -59,6 +59,9 @@ struct vfio_pci_regops {
>  		      size_t count, loff_t *ppos, bool iswrite);
>  	void	(*release)(struct vfio_pci_device *vdev,
>  			   struct vfio_pci_region *region);
> +	int	(*mmap)(struct vfio_pci_device *vdev,
> +			struct vfio_pci_region *region,
> +			struct vm_area_struct *vma);
>  };
> =20
>  struct vfio_pci_region {
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index d9af440..7923314 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1126,6 +1126,14 @@ static int vfio_pci_mmap(void *device_data, struct=
 vm_area_struct *vma)
>  		return -EINVAL;
>  	if ((vma->vm_flags & VM_SHARED) =3D=3D 0)
>  		return -EINVAL;
> +	if (index >=3D VFIO_PCI_NUM_REGIONS) {
> +		int regnum =3D index - VFIO_PCI_NUM_REGIONS;
> +		struct vfio_pci_region *region =3D vdev->region + regnum;
> +
> +		if (region && region->ops && region->ops->mmap)
> +			return region->ops->mmap(vdev, region, vma);
> +		return -EINVAL;
> +	}
>  	if (index >=3D VFIO_PCI_ROM_REGION_INDEX)
>  		return -EINVAL;
>  	if (!vdev->bar_mmap_supported[index])

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AwNVUpjOmSj7UnwZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvj0eIACgkQbDjKyiDZ
s5Kh/Q/9EDTEywNiv2jB25o+GG9jDesXxhv2omzhGl/zfTYBKecgx0yaL5adZqNi
mVvnWIF+HaQvKzrSoJ2Lc/ebEHNwLF84hpepoHBY4V6jI3O5xmsuwdZNGYmKtrYt
1Ga7iMFmLHnDggm9NHJIENXCb3aSrGczMNDHrso2Pbf7XbAc4RVdI6AvENG8da4e
9ub0n/XeyqxAMEVLDKn8hjpSFa+eL2QtqVyIpz1pr/QeEDZ+/IF4c76a+d19Nk3n
ilcQkVOHvvaGp9BL2JypZ2NiKDHhEQwNZSE6BKP7HtjoSkqDeUcsJgurEPJzgQ1C
SH1ae9XLahVUwq/V3NIf2uu9hLVG/nfkuLPmM3QIDr6gg151LjA4+5FTHXzSSwDs
s8xoqzFbA01tl8EFJ1CihfsiaoxC3glZlrHTYgVafBvhj0dH/xgZ228MY4diuiq1
8S0AzD0TeLraralYTdJL/IgO3orXOsmrroqZVStG6NxAX3YlIlAoA6geAJ3I5U+C
2h+Xeg3fy2DKHRkD7J/2/vN3yQL8iHRU4Sp1qyS2GQ4/xamALL4u+Z5SA0YVABPB
oIf5vgRKzvUzQUvbwsCsbumXb7/ehLyFH5lAS3OITz4JtCRPK6J/HFfmDE3rgTjZ
LZ5b8buJbPOIzKQzuG6tRmmwk4MV4DNO8KF85+Km7nTqB7YyaSA=
=za5f
-----END PGP SIGNATURE-----

--AwNVUpjOmSj7UnwZ--
