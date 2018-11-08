Return-Path: <SRS0=TQYx=NT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FA2C32789
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 06:41:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 307102081C
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 06:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="g53cDv96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307102081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42rDG20STczF3MM
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 17:41:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="g53cDv96";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42rDCX5lKfzF3J3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 17:39:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="g53cDv96"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42rDCX4dmkz9sBZ; Thu,  8 Nov 2018 17:39:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1541659160;
 bh=VJs/GCYi0UoHAVyqUDEoO6WrNTCgUY1L+n9djq+WIRY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g53cDv96j/mZwpBo0tC6sWWzTMDoMnV5TDVQfHEdSPf9XQnjrQl7dOixYuWN1LOHb
 moUvhwFinNdhUjrUCYYEsk+DSjo1cWHco5NybG80yceQOTtOJ19z93I7cerw1BBd6r
 r+lZuEDOxqHvjJgfFfETfRyFUM0tDM3rU6zCshIg=
Date: Thu, 8 Nov 2018 17:21:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel 2/3] vfio_pci: Allow regions to add own capabilities
Message-ID: <20181108062139.GQ5575@umbus.fritz.box>
References: <20181015094233.1324-1-aik@ozlabs.ru>
 <20181015094233.1324-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7a4X6VOqfbl9xMrG"
Content-Disposition: inline
In-Reply-To: <20181015094233.1324-3-aik@ozlabs.ru>
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


--7a4X6VOqfbl9xMrG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2018 at 08:42:32PM +1100, Alexey Kardashevskiy wrote:
> VFIO regions already support region capabilities with a limited set of
> fields. However the subdriver might have to report to the userspace
> additional bits.
>=20
> This adds an add_capability() hook to vfio_pci_regops.
>=20
> This is aiming Witherspoon POWER9 machines which have multiple
> interconnected NVIDIA V100 GPUs with coherent RAM; each GPU's RAM
> is mapped to a system bus and to each of GPU internal system bus and
> the GPUs use this for DMA routing as DMA trafic can go via any
> of many NVLink2 (GPU-GPU or GPU-CPU) or even stay local within a
> GPU.

This description doesn't really make clear how per-region capabilities
are relevant to these devices.

>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>=20
> This is based on top of "vfio_pci: Allow mapping extra regions"
> ---
>  drivers/vfio/pci/vfio_pci_private.h | 3 +++
>  drivers/vfio/pci/vfio_pci.c         | 6 ++++++
>  2 files changed, 9 insertions(+)
>=20
> diff --git a/drivers/vfio/pci/vfio_pci_private.h b/drivers/vfio/pci/vfio_=
pci_private.h
> index 86aab05..93c1738 100644
> --- a/drivers/vfio/pci/vfio_pci_private.h
> +++ b/drivers/vfio/pci/vfio_pci_private.h
> @@ -62,6 +62,9 @@ struct vfio_pci_regops {
>  	int	(*mmap)(struct vfio_pci_device *vdev,
>  			struct vfio_pci_region *region,
>  			struct vm_area_struct *vma);
> +	int	(*add_capability)(struct vfio_pci_device *vdev,
> +				  struct vfio_pci_region *region,
> +				  struct vfio_info_cap *caps);
>  };
> =20
>  struct vfio_pci_region {
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 7923314..4a3b93e 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -759,6 +759,12 @@ static long vfio_pci_ioctl(void *device_data,
>  			if (ret)
>  				return ret;
> =20
> +			if (vdev->region[i].ops->add_capability) {
> +				ret =3D vdev->region[i].ops->add_capability(vdev,
> +						&vdev->region[i], &caps);
> +				if (ret)
> +					return ret;
> +			}
>  		}
>  		}
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7a4X6VOqfbl9xMrG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvj1fAACgkQbDjKyiDZ
s5IsJw/+LPzZslooDphqPB3Ez7PKgBnYySUUxfAzjZAUjhObVCYLKF6Prprrr2u8
iH+nSGHXWyLyvPm9JBMubiyjcV8Uuwm6DZpBL+OkSmCNJxRfuFYQXa5IPbFHcj/p
F8vSjn+kdhp5Yabp8GM+82GqjGnPnYEQJjxTAhgBdIHLBzZPZMb2fXNWTLj4q2pP
Kp5hdx5z8H3J19Aln4Dw2vT3KQz1k6eXpp3XDeHmI+xg7B17HdKOxkdzukO1sy3W
ZLrVtWGcdvfSabWflPEx1tuQTjJiQMUHmakf4lyjfVnqK8H/VX0YiUnU2gBcp65Y
gfdaRzEMEDIA1ky8M32+baLXy8TjXoo58rOpWuTfc2JbxoVnh83xZ8IQ7GU+G/Ob
fOGtOXp191Dp/ygJ75ViZukLM1M+CXDMqVzssVCJi1LnBRhuTAYYskXgZsaPzXFN
gO3BN21LD75pJCJtP47O/8h4OW51ULHWIBiVRDS+re91B47s0NtSNY842QjzTGDe
yVP6hiA300XvHD0vjtWsyO5AKRZUZHABG9jJPSDWCrES4MwyMUOdLh6ikn6tESiQ
c+d27Rg/Xd3yCI6iZ/gLmmmjYnvtqreQbmhwCly1jYBPEN+ibuG81sgnPzzey36q
YmcbVDGtU/3R5FarRMZbCMM+V1jdNGJaMe4GIt9sEUqR/IAhuiY=
=TRHB
-----END PGP SIGNATURE-----

--7a4X6VOqfbl9xMrG--
