Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477D7C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 05:16:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A691F20872
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 05:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Jdzvx2a8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A691F20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44N4DP5cXfzDqL7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 16:16:53 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44N48f6ZvnzDqJW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 16:13:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="Jdzvx2a8"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44N48f54x8z9sBV; Mon, 18 Mar 2019 16:13:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552886018;
 bh=DMoHwmKrxWGQ8CNo6lSB+qfGZtJJFKZ0j0AXWAc3INY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Jdzvx2a8y8GGuS8h6pHAzaK0/3kseTZ4oz2dO2Vf4hiQqtC30QCUEBNUEjhXuNqCj
 0p9xC9CHYxx416UYxgbf6KOFcrFvqXrTKkFuJZ5xYkJmCq1SqRDFmq5bQqx7CmI4W2
 ETqDyOF8bRYi9JxV6SABZ9Gm0UfFJFp3cxK6Wpqo=
Date: Mon, 18 Mar 2019 14:32:23 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 11/17] KVM: introduce a 'mmap' method for KVM devices
Message-ID: <20190318033223.GL6874@umbus.fritz.box>
References: <20190315120609.25910-1-clg@kaod.org>
 <20190315120609.25910-12-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4e5ZDkbgLEOfWmLx"
Content-Disposition: inline
In-Reply-To: <20190315120609.25910-12-clg@kaod.org>
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
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--4e5ZDkbgLEOfWmLx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2019 at 01:06:03PM +0100, C=E9dric Le Goater wrote:
> Some KVM devices will want to handle special mappings related to the
> underlying HW. For instance, the XIVE interrupt controller of the
> POWER9 processor has MMIO pages for thread interrupt management and
> for interrupt source control that need to be exposed to the guest when
> the OS has the required support.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

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
> index 076bc38963bf..e4881a8c2a6f 100644
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

--4e5ZDkbgLEOfWmLx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyPEUYACgkQbDjKyiDZ
s5JkcQ/9El5dCERRJqATuvBEvvEkUfnB0NRPUbd+j/EnMNG+S/J9fF+Lt7MjpLKR
UJ+kkidVuL69z41U3UM5yFsrGMtqgeP1aGZ+0ybw+daa6SXWVsPr7W3FWNfg1nI8
YDz0G6kcInq+3/wu0M8yQEFXL9W/MwxvtX3usY6IBNjFztyNavV/aQE/uzCDY0N+
H9q5sRZRNgE5JL+qlgcDhZNqzxm4ILKxQWiExghLazKrW3/+L1UctOc0/2lE8iB0
R4rdtANi5egwwg2mlXU025VpmSgNS3RBNZpZSZNb56sHvuktsnsPY7MTY7OHehVw
TJqBSmUEB+oGdfmbB3p2p7/2cHdIAQPYRozybrq69Ewd3csIqtnbGbJH3fJ5ScOZ
C5LJxUom7oQ4qcJUWf9X52n06UPst6aBhyNXv+40wl9TfHY18sk5d6K3kU4fYV1z
Fca3Az5t23FnHEFiZ5NiQKg06vBPo2Ay9BvnDZD/QmKeqx6ARoRrmATXUNb6bOiQ
/X6uTT016oqh6cPc1Uwr1qRjI0ZV9Pj7AFstHQO/LQ3MJ1Ff0CCozZgowgplB9Ps
3xCAvTwdultNfhmvxpsUih33MAzV855B0+VCPkDy4whlYjj1xz/LdVqF4252hBrj
rQPpVkTmZQbkZk+XzMVav7lVPulB9nJUwip0ik/iv4nctYU6WPs=
=OMfW
-----END PGP SIGNATURE-----

--4e5ZDkbgLEOfWmLx--
