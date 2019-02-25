Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB46C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 04:17:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 896192087C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 04:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OueWVVYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 896192087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4477vF4hjhzDqCF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 15:17:13 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4477Rn1GvszDqF6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 14:56:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="OueWVVYU"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4477Rm6Ktcz9sNg; Mon, 25 Feb 2019 14:56:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1551067012;
 bh=xc91Wq4FCC/DBBmg9VaEPeG9GGkAx5vmzSWJfLeIVBI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OueWVVYUwL2adRc6YNMHJoAT2z4JG6W4gDas5CJhzsWOmAckyAcV/ar+RPIaBGI6D
 hIHoUR1uL0+VvHXSuoxd0GnXmqX6aqU/qiy+irPskfUbLHeGgg+6yNKM7e92a4THNq
 NMvv+JNUH68fHYWEsm/cmEKVW72V6SFAISZr5UpE=
Date: Mon, 25 Feb 2019 14:42:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 12/16] KVM: PPC: Book3S HV: XIVE: add a TIMA mapping
Message-ID: <20190225034251.GP7668@umbus.fritz.box>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-13-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LpcCHpaCAbC4X43d"
Content-Disposition: inline
In-Reply-To: <20190222112840.25000-13-clg@kaod.org>
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


--LpcCHpaCAbC4X43d
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 12:28:36PM +0100, C=E9dric Le Goater wrote:
> Each thread has an associated Thread Interrupt Management context
> composed of a set of registers. These registers let the thread handle
> priority management and interrupt acknowledgment. The most important
> are :
>=20
>     - Interrupt Pending Buffer     (IPB)
>     - Current Processor Priority   (CPPR)
>     - Notification Source Register (NSR)
>=20
> They are exposed to software in four different pages each proposing a
> view with a different privilege. The first page is for the physical
> thread context and the second for the hypervisor. Only the third
> (operating system) and the fourth (user level) are exposed the guest.
>=20
> A custom VM fault handler will populate the VMA with the appropriate
> pages, which should only be the OS page for now.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Subject to possible modification depending on whether we go with the
generic change to allow mmap() on kvm devices.

> ---
>  arch/powerpc/include/asm/xive.h            |  1 +
>  arch/powerpc/include/uapi/asm/kvm.h        |  2 ++
>  arch/powerpc/kvm/book3s_xive_native.c      | 39 ++++++++++++++++++++++
>  arch/powerpc/sysdev/xive/native.c          | 11 ++++++
>  Documentation/virtual/kvm/devices/xive.txt | 23 +++++++++++++
>  5 files changed, 76 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/x=
ive.h
> index 46891f321606..eb6d302082da 100644
> --- a/arch/powerpc/include/asm/xive.h
> +++ b/arch/powerpc/include/asm/xive.h
> @@ -23,6 +23,7 @@
>   * same offset regardless of where the code is executing
>   */
>  extern void __iomem *xive_tima;
> +extern unsigned long xive_tima_os;
> =20
>  /*
>   * Offset in the TM area of our current execution level (provided by
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index 42d4ef93ec2d..be9b255e061d 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -720,4 +720,6 @@ struct kvm_ppc_xive_eq {
>  #define KVM_XIVE_EQ_FLAG_ALWAYS_NOTIFY	0x00000002
>  #define KVM_XIVE_EQ_FLAG_ESCALATE	0x00000004
> =20
> +#define KVM_XIVE_TIMA_PAGE_OFFSET	0
> +
>  #endif /* __LINUX_KVM_POWERPC_H */
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index 132bff52d70a..c6ac818a13b2 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -176,6 +176,44 @@ int kvmppc_xive_native_connect_vcpu(struct kvm_devic=
e *dev,
>  	return rc;
>  }
> =20
> +static int xive_native_tima_fault(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma =3D vmf->vma;
> +
> +	switch (vmf->pgoff - vma->vm_pgoff) {
> +	case 0: /* HW - forbid access */
> +	case 1: /* HV - forbid access */
> +		return VM_FAULT_SIGBUS;
> +	case 2: /* OS */
> +		vmf_insert_pfn(vma, vmf->address, xive_tima_os >> PAGE_SHIFT);
> +		return VM_FAULT_NOPAGE;
> +	case 3: /* USER - TODO */
> +	default:
> +		return VM_FAULT_SIGBUS;
> +	}
> +}
> +
> +static const struct vm_operations_struct xive_native_tima_vmops =3D {
> +	.fault =3D xive_native_tima_fault,
> +};
> +
> +static int kvmppc_xive_native_mmap(struct kvm_device *dev,
> +				   struct vm_area_struct *vma)
> +{
> +	/* We only allow mappings at fixed offset for now */
> +	if (vma->vm_pgoff =3D=3D KVM_XIVE_TIMA_PAGE_OFFSET) {
> +		if (vma_pages(vma) > 4)
> +			return -EINVAL;
> +		vma->vm_ops =3D &xive_native_tima_vmops;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	vma->vm_flags |=3D VM_IO | VM_PFNMAP;
> +	vma->vm_page_prot =3D pgprot_noncached_wc(vma->vm_page_prot);
> +	return 0;
> +}
> +
>  static int kvmppc_xive_native_set_source(struct kvmppc_xive *xive, long =
irq,
>  					 u64 addr)
>  {
> @@ -1005,6 +1043,7 @@ struct kvm_device_ops kvm_xive_native_ops =3D {
>  	.set_attr =3D kvmppc_xive_native_set_attr,
>  	.get_attr =3D kvmppc_xive_native_get_attr,
>  	.has_attr =3D kvmppc_xive_native_has_attr,
> +	.mmap =3D kvmppc_xive_native_mmap,
>  };
> =20
>  void kvmppc_xive_native_init_module(void)
> diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive=
/native.c
> index 0c037e933e55..7782201e5fe8 100644
> --- a/arch/powerpc/sysdev/xive/native.c
> +++ b/arch/powerpc/sysdev/xive/native.c
> @@ -521,6 +521,9 @@ u32 xive_native_default_eq_shift(void)
>  }
>  EXPORT_SYMBOL_GPL(xive_native_default_eq_shift);
> =20
> +unsigned long xive_tima_os;
> +EXPORT_SYMBOL_GPL(xive_tima_os);
> +
>  bool __init xive_native_init(void)
>  {
>  	struct device_node *np;
> @@ -573,6 +576,14 @@ bool __init xive_native_init(void)
>  	for_each_possible_cpu(cpu)
>  		kvmppc_set_xive_tima(cpu, r.start, tima);
> =20
> +	/* Resource 2 is OS window */
> +	if (of_address_to_resource(np, 2, &r)) {
> +		pr_err("Failed to get thread mgmnt area resource\n");
> +		return false;
> +	}
> +
> +	xive_tima_os =3D r.start;
> +
>  	/* Grab size of provisionning pages */
>  	xive_parse_provisioning(np);
> =20
> diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/v=
irtual/kvm/devices/xive.txt
> index 1b8957c50c53..4d6b41609fd9 100644
> --- a/Documentation/virtual/kvm/devices/xive.txt
> +++ b/Documentation/virtual/kvm/devices/xive.txt
> @@ -13,6 +13,29 @@ requires a POWER9 host and the guest OS should have su=
pport for the
>  XIVE native exploitation interrupt mode. If not, it should run using
>  the legacy interrupt mode, referred as XICS (POWER7/8).
> =20
> +* Device Mappings
> +
> +  The KVM device exposes different MMIO ranges of the XIVE HW which
> +  are required for interrupt management. These are exposed to the
> +  guest in VMAs populated with a custom VM fault handler.
> +
> +  1. Thread Interrupt Management Area (TIMA)
> +
> +  Each thread has an associated Thread Interrupt Management context
> +  composed of a set of registers. These registers let the thread
> +  handle priority management and interrupt acknowledgment. The most
> +  important are :
> +
> +      - Interrupt Pending Buffer     (IPB)
> +      - Current Processor Priority   (CPPR)
> +      - Notification Source Register (NSR)
> +
> +  They are exposed to software in four different pages each proposing
> +  a view with a different privilege. The first page is for the
> +  physical thread context and the second for the hypervisor. Only the
> +  third (operating system) and the fourth (user level) are exposed the
> +  guest.
> +
>  * Groups:
> =20
>    1. KVM_DEV_XIVE_GRP_CTRL

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--LpcCHpaCAbC4X43d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxzZDsACgkQbDjKyiDZ
s5K1bg//Z4tGUBDp8snDYFcVMbdfO/mqgRA0b37oUcYTkexqKVzGwDbBNDYugSps
p4iW3qgZJiP818M1IPkvR45bnhZq2jPWp5wALZYauINJoP2en1BN+ov7gtAFAVzL
eMeXJGn13Ifv3oWbrJ8/DTUozLUnNj8DELk/lsPqbAGD7rQh/qpz4pfG0QBZ1awr
QbZwGz2GNf0ilK4l7FAe2V9Pes7ciH/jEwIlxUI3Kex6hLk8VP1oFJEdiql3Gb2C
apVbVI8nJQQ2SIU/9mf4T4135zuE+sXCF+z937ADvUsA5cUNGaRk+9yfFCZKqAfc
5GPj3Vwv3/CiehDizjltEni6nKPJmxNflutYkUPBc08FBnSebPX+vL5Q7Z0DBdWo
5oriPTe5URRMN6NMtSt8nCVpBCJmI47BjfSzPT/dDFznu738qId8NTA57Nh+g/sb
OM6Mr0gtD7GkxlPksvPR/szLl8OjVGZrfs1yAwbS+rAD/LVJsOSMdDm+Jsys7Zo3
iZM06OwpGdOG/YBnNBRnADEF4V5kSNd3oZLffjke/5T9mt/p/VHmwnHxrTcvMgez
kz779LAlygcXtuBqQvhqLtDpAaeNgADXGjAz7pCdlYztgFWEnEiphG/Me3qEVlBb
rNETZPxhVub0j+BEiFuv0Ih5JTq93nMwdo7FBValMQFdjYz3Sok=
=E7+r
-----END PGP SIGNATURE-----

--LpcCHpaCAbC4X43d--
