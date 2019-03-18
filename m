Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB8AC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 06:46:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C5AC20643
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 06:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oQOVAXp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5AC20643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44N6Cf1r1czDqJW
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 17:46:22 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44N67f6BSRzDqJT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 17:42:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="oQOVAXp9"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44N67d5gv3z9s9N; Mon, 18 Mar 2019 17:42:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552891373;
 bh=H60BjCMmU9tYl0FXi8Q1ni8TjhzgFMix1CHsFS2z6Fs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oQOVAXp9sSSYgQNON7hwtxablml5Nu8ucQIIS7W/GrAfS3/Uj0DvWVYW9ANiZ2Tz0
 aJwqMZLogh24ULDG21UXqdwt4VUuMagCi3pGUETL7NR8vpj2tyEXcLtSTBo/geh/WD
 lJxKc3NabxiJcPZm6ibHwgu1M/2v7ZWc9RtPx7sM=
Date: Mon, 18 Mar 2019 17:42:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 16/17] KVM: introduce a KVM_DESTROY_DEVICE ioctl
Message-ID: <20190318064242.GN6874@umbus.fritz.box>
References: <20190315120609.25910-1-clg@kaod.org>
 <20190315120609.25910-17-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fpolVoprVozDR81Y"
Content-Disposition: inline
In-Reply-To: <20190315120609.25910-17-clg@kaod.org>
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


--fpolVoprVozDR81Y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2019 at 01:06:08PM +0100, C=E9dric Le Goater wrote:
> The 'destroy' method is currently used to destroy all devices when the
> VM is destroyed after the vCPUs have been freed.
>=20
> This new KVM ioctl exposes the same KVM device method. It acts as a
> software reset of the VM to 'destroy' selected devices when necessary
> and perform the required cleanups on the vCPUs. Called with the
> kvm->lock.
>=20
> The 'destroy' method could be improved by returning an error code.
>=20
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
>   Changes since v2 :
>=20
>  - checked that device is owned by VM
> =20
>  include/uapi/linux/kvm.h          |  7 ++++++
>  virt/kvm/kvm_main.c               | 42 +++++++++++++++++++++++++++++++
>  Documentation/virtual/kvm/api.txt | 20 +++++++++++++++
>  3 files changed, 69 insertions(+)
>=20
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 52bf74a1616e..d78fafa54274 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1183,6 +1183,11 @@ struct kvm_create_device {
>  	__u32	flags;	/* in: KVM_CREATE_DEVICE_xxx */
>  };
> =20
> +struct kvm_destroy_device {
> +	__u32	fd;	/* in: device handle */
> +	__u32	flags;	/* in: unused */
> +};
> +
>  struct kvm_device_attr {
>  	__u32	flags;		/* no flags currently defined */
>  	__u32	group;		/* device-defined */
> @@ -1331,6 +1336,8 @@ struct kvm_s390_ucas_mapping {
>  #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
>  #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
> =20
> +#define KVM_DESTROY_DEVICE	  _IOWR(KVMIO,  0xf0, struct kvm_destroy_devi=
ce)
> +
>  /*
>   * ioctls for vcpu fds
>   */
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index e4881a8c2a6f..7b616a1d48cf 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3026,6 +3026,34 @@ static int kvm_ioctl_create_device(struct kvm *kvm,
>  	return 0;
>  }
> =20
> +static int kvm_ioctl_destroy_device(struct kvm *kvm,
> +				    struct kvm_destroy_device *dd)
> +{
> +	struct fd f;
> +	struct kvm_device *dev;
> +
> +	f =3D fdget(dd->fd);
> +	if (!f.file)
> +		return -EBADF;
> +
> +	dev =3D kvm_device_from_filp(f.file);
> +	fdput(f);
> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	if (dev->kvm !=3D kvm)
> +		return -EPERM;
> +
> +	mutex_lock(&kvm->lock);
> +	list_del(&dev->vm_node);
> +	dev->ops->destroy(dev);
> +	mutex_unlock(&kvm->lock);
> +
> +	/* TODO: kvm_put_kvm() crashes the host on some occasion ? */
> +	return 0;
> +}
> +
>  static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long a=
rg)
>  {
>  	switch (arg) {
> @@ -3270,6 +3298,20 @@ static long kvm_vm_ioctl(struct file *filp,
>  		r =3D 0;
>  		break;
>  	}
> +	case KVM_DESTROY_DEVICE: {
> +		struct kvm_destroy_device dd;
> +
> +		r =3D -EFAULT;
> +		if (copy_from_user(&dd, argp, sizeof(dd)))
> +			goto out;
> +
> +		r =3D kvm_ioctl_destroy_device(kvm, &dd);
> +		if (r)
> +			goto out;
> +
> +		r =3D 0;
> +		break;
> +	}
>  	case KVM_CHECK_EXTENSION:
>  		r =3D kvm_vm_ioctl_check_extension_generic(kvm, arg);
>  		break;
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kv=
m/api.txt
> index 1db1435769b4..914471494602 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -3857,6 +3857,26 @@ number of valid entries in the 'entries' array, wh=
ich is then filled.
>  'index' and 'flags' fields in 'struct kvm_cpuid_entry2' are currently re=
served,
>  userspace should not expect to get any particular value there.
> =20
> +4.119 KVM_DESTROY_DEVICE
> +
> +Capability: KVM_CAP_DEVICE_CTRL
> +Type: vm ioctl
> +Parameters: struct kvm_destroy_device (in)
> +Returns: 0 on success, -1 on error
> +Errors:
> +  ENODEV: The device type is unknown or unsupported
> +  EPERM: The device does not belong to the VM
> +
> +  Other error conditions may be defined by individual device types or
> +  have their standard meanings.
> +
> +Destroys an emulated device in the kernel.
> +
> +struct kvm_destroy_device {
> +	__u32	fd;	/* in: device handle */
> +	__u32	flags;	/* unused */
> +};
> +
>  5. The kvm_run structure
>  ------------------------
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fpolVoprVozDR81Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyPPeIACgkQbDjKyiDZ
s5Kwsg/9Gq3ACtHKIt7mBbv7yoZnfTZiLmK0j9G98Cp/jvKgf7QOPHj0iov+2FxT
NUlRXC4Jd3cDheyorfYVd0rZx1Iygow7SO8E+m6h7ljpeiBuAQ9kacUIyTO3GFi4
kEBJAgQEm/vK5qK0staITyjVavQ7jUB1i2MmZKZIA8fARbHQuefHInsf+jSng0al
s+4ItsN324eeQRLcbeHPOldm2dVC4T9PFF5YhVdY2U3OWMoEU5rvywtZczljjXC+
Hz7toZP8tdT1MWrzD6BOiQC1FDO21mZmeXFmq1koG01QP0Ir0+x3HKtIuY8O0/DY
RldGyuhwl02pSDL0bxgGdLjrUeek2w268t7pLdQZO7ZdUKgdjTieHqsrhdnaF8F+
cDfMBR4fEoHenlqz6XPWD/ogLCjvA/uBFoLqSXqFRGRcaQkQR5/VG95uYOsSNuev
3GVnpKzwBLv3I/nQAVzAsa8WI5omKX+C6wX3E6U1NZFcqHlf3o4asn774h/RUcZ1
rC2Qdo1cZGIGnRg6W2aD+2Ujr4+IW6SF87tP86n9388ZyxYQ0pn9gIV8DK8hj9x8
HOco3MTw1p4kdYvuEeWg0kptkV+2YlTHITfiKSZuvftSjJmNemKQ1W+fxxuSEOwR
umejT+ii3b6TlMFLF17KEpdsAjJiEbfO9iYpA7nn0mfG6SrJZcQ=
=8unw
-----END PGP SIGNATURE-----

--fpolVoprVozDR81Y--
