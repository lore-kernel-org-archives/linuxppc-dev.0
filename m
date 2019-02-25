Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52014C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 04:14:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF4152087C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 04:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fu6H+rwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4152087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4477qc68wSzDq6J
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 15:14:04 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4477Rm3ZwzzDqFF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 14:56:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="fu6H+rwe"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4477Rm1lJRz9sNK; Mon, 25 Feb 2019 14:56:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1551067012;
 bh=p8ezU6M4jszLeLTiIbWtAq+sTb5HxGmLaGhL/iqvtAs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fu6H+rwerTmxJD1Jfb2QlnupmwZ0ck26zXoFJujWwaLI8mb5pfXeIrEsdUXYFQBWY
 lMxr+t00pdgav3JaWuX6PGMp2JAiRbPxlnPz3cexWfvE9XZN0AaXWw9/5Rb+9+2vBG
 f1udkfZdvu+INDJqABYz83wrnUi/BR204LtQgY1E=
Date: Mon, 25 Feb 2019 14:33:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 11/16] KVM: introduce a 'mmap' method for KVM devices
Message-ID: <20190225033309.GO7668@umbus.fritz.box>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-12-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MdEjg5WkSuUg8x46"
Content-Disposition: inline
In-Reply-To: <20190222112840.25000-12-clg@kaod.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--MdEjg5WkSuUg8x46
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 12:28:35PM +0100, C=E9dric Le Goater wrote:
> Some KVM devices will want to handle special mappings related to the
> underlying HW. For instance, the XIVE interrupt controller of the
> POWER9 processor has MMIO pages for thread interrupt management and
> for interrupt source control that need to be exposed to the guest when
> the OS has the required support.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Ah, when I suggested mmap() on the base device fd, I hadn't realized
there wasn't a facility for that yet.

Have you discussed this with Paolo?  We'll need some core KVM buy in
to merge this.

> ---
>  include/linux/kvm_host.h |  1 +
>  virt/kvm/kvm_main.c      | 11 +++++++++++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index c38cc5eb7e73..cbf81487b69f 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1223,6 +1223,7 @@ struct kvm_device_ops {
>  	int (*has_attr)(struct kvm_device *dev, struct kvm_device_attr *attr);
>  	long (*ioctl)(struct kvm_device *dev, unsigned int ioctl,
>  		      unsigned long arg);
> +	int (*mmap)(struct kvm_device *dev, struct vm_area_struct *vma);
>  };
> =20
>  void kvm_device_get(struct kvm_device *dev);
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 585845203db8..84717d8cb5e4 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2878,6 +2878,16 @@ static long kvm_vcpu_compat_ioctl(struct file *fil=
p,
>  }
>  #endif
> =20
> +static int kvm_device_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	struct kvm_device *dev =3D filp->private_data;
> +
> +	if (dev->ops->mmap)
> +		return dev->ops->mmap(dev, vma);
> +
> +	return -ENODEV;
> +}
> +
>  static int kvm_device_ioctl_attr(struct kvm_device *dev,
>  				 int (*accessor)(struct kvm_device *dev,
>  						 struct kvm_device_attr *attr),
> @@ -2927,6 +2937,7 @@ static const struct file_operations kvm_device_fops=
 =3D {
>  	.unlocked_ioctl =3D kvm_device_ioctl,
>  	.release =3D kvm_device_release,
>  	KVM_COMPAT(kvm_device_ioctl),
> +	.mmap =3D kvm_device_mmap,
>  };
> =20
>  struct kvm_device *kvm_device_from_filp(struct file *filp)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MdEjg5WkSuUg8x46
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxzYfUACgkQbDjKyiDZ
s5JP/A/9E2eVjzW3hIpObywCYF59PrShr4U3oPk+MgINMc39o5VpZNPU8KbGV8AR
duGV33Vtv5+mBrY4hzGH0n1KVxf5hnRAGn0fVDXZcYG/1HcDMbCbNJClafOjn3Qu
xI7jFQ6zbLbVSL7B7IQR9nvSu3xFp0gss16SEgw+KccfMV4RJ+COHKfRd6V4vzg0
HZ+rHvr0136ipued9dl9zJ00KqP/GOgMTJR4nFe83DgaYhhR63tP9E5gdqe3zlfG
D5BoP3LDQBTLKGZfYEXvVa1VoCZCUxhW2uFGzmdjA3Ext1HrgyQ/A5Y8Hq363vT8
FTAsbbbpTmAHrVdom2EZo2m0a2j9sRNaYcFPnEOhfuOkp65eqOTDDeAp40LBGa3l
fFEovLumIJFBfMQ8WN5Sl+irc8v9e1BdAA6ZH7IYiAaEH6bnIt9Q2UEcU1500rXy
j0FrO+iiOb+4XVQ9lO5MhYusxl/mzawRcGqjhi6O1HmgOJjUluCywWq31ANkwEcS
ymPk/R5qcGgSfvplvvY+dnpRj8FLBiezbbEl4vdYDW3hQV7BchUDybm00HaJQ/PN
rDgYT+2nqgjnBUUPwmBvS3CIrbfiQchNAhRMdR4op9fIM77RipzxffHbbX20MP2b
KF/Yjc4okuWGMnOhdoiJh+B47W3IujZX9YTnMe25hO45EiVc1YU=
=U2aO
-----END PGP SIGNATURE-----

--MdEjg5WkSuUg8x46--
