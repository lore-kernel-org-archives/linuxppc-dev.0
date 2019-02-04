Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE09EC282D7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:16:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A80C218FD
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MEUun9QB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A80C218FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tHXN3P0gzDqGn
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 17:16:20 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tHSJ62PKzDqGW
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 17:12:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="MEUun9QB"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43tHSJ49Qfz9sML; Mon,  4 Feb 2019 17:12:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549260768;
 bh=sgz9t3nlk4YYj+KpGLIi9b1WPD/nzlxC12wnwO/55fs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MEUun9QBQ3VotNwUIXZ0tZBY+NS/8E1+iHTs8ESv0xWgsCfvts+fix5S/mKsLHgpc
 47topIg1FbzaHTpR7QnWSf36+gH9FIHYkQ3XVtyRwQRo2LneZPZGoQurax96kHsV2v
 7HPVBIRvwzZkPq4CbNZ8r8EA+HAmnCd+S+0DnqX8=
Date: Mon, 4 Feb 2019 15:45:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 06/19] KVM: PPC: Book3S HV: add a GET_ESB_FD control to
 the XIVE native device
Message-ID: <20190204044531.GB1927@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-7-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
In-Reply-To: <20190107184331.8429-7-clg@kaod.org>
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:43:18PM +0100, C=E9dric Le Goater wrote:
> This will let the guest create a memory mapping to expose the ESB MMIO
> regions used to control the interrupt sources, to trigger events, to
> EOI or to turn off the sources.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/include/uapi/asm/kvm.h   |  4 ++
>  arch/powerpc/kvm/book3s_xive_native.c | 97 +++++++++++++++++++++++++++
>  2 files changed, 101 insertions(+)
>=20
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index 8c876c166ef2..6bb61ba141c2 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -675,4 +675,8 @@ struct kvm_ppc_cpu_char {
>  #define  KVM_XICS_PRESENTED		(1ULL << 43)
>  #define  KVM_XICS_QUEUED		(1ULL << 44)
> =20
> +/* POWER9 XIVE Native Interrupt Controller */
> +#define KVM_DEV_XIVE_GRP_CTRL		1
> +#define   KVM_DEV_XIVE_GET_ESB_FD	1

Introducing a new FD for ESB and TIMA seems overkill.  Can't you get
to both with an mmap() directly on the xive device fd?  Using the
offset to distinguish which one to map, obviously.

>  #endif /* __LINUX_KVM_POWERPC_H */
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index 115143e76c45..e20081f0c8d4 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -153,6 +153,85 @@ int kvmppc_xive_native_connect_vcpu(struct kvm_devic=
e *dev,
>  	return rc;
>  }
> =20
> +static int xive_native_esb_fault(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma =3D vmf->vma;
> +	struct kvmppc_xive *xive =3D vma->vm_file->private_data;
> +	struct kvmppc_xive_src_block *sb;
> +	struct kvmppc_xive_irq_state *state;
> +	struct xive_irq_data *xd;
> +	u32 hw_num;
> +	u16 src;
> +	u64 page;
> +	unsigned long irq;
> +
> +	/*
> +	 * Linux/KVM uses a two pages ESB setting, one for trigger and
> +	 * one for EOI
> +	 */
> +	irq =3D vmf->pgoff / 2;
> +
> +	sb =3D kvmppc_xive_find_source(xive, irq, &src);
> +	if (!sb) {
> +		pr_err("%s: source %lx not found !\n", __func__, irq);
> +		return VM_FAULT_SIGBUS;
> +	}
> +
> +	state =3D &sb->irq_state[src];
> +	kvmppc_xive_select_irq(state, &hw_num, &xd);
> +
> +	arch_spin_lock(&sb->lock);
> +
> +	/*
> +	 * first/even page is for trigger
> +	 * second/odd page is for EOI and management.
> +	 */
> +	page =3D vmf->pgoff % 2 ? xd->eoi_page : xd->trig_page;
> +	arch_spin_unlock(&sb->lock);
> +
> +	if (!page) {
> +		pr_err("%s: acessing invalid ESB page for source %lx !\n",
> +		       __func__, irq);
> +		return VM_FAULT_SIGBUS;
> +	}
> +
> +	vmf_insert_pfn(vma, vmf->address, page >> PAGE_SHIFT);
> +	return VM_FAULT_NOPAGE;
> +}
> +
> +static const struct vm_operations_struct xive_native_esb_vmops =3D {
> +	.fault =3D xive_native_esb_fault,
> +};
> +
> +static int xive_native_esb_mmap(struct file *file, struct vm_area_struct=
 *vma)
> +{
> +	/* There are two ESB pages (trigger and EOI) per IRQ */
> +	if (vma_pages(vma) + vma->vm_pgoff > KVMPPC_XIVE_NR_IRQS * 2)
> +		return -EINVAL;
> +
> +	vma->vm_flags |=3D VM_IO | VM_PFNMAP;
> +	vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
> +	vma->vm_ops =3D &xive_native_esb_vmops;
> +	return 0;
> +}
> +
> +static const struct file_operations xive_native_esb_fops =3D {
> +	.mmap =3D xive_native_esb_mmap,
> +};
> +
> +static int kvmppc_xive_native_get_esb_fd(struct kvmppc_xive *xive, u64 a=
ddr)
> +{
> +	u64 __user *ubufp =3D (u64 __user *) addr;
> +	int ret;
> +
> +	ret =3D anon_inode_getfd("[xive-esb]", &xive_native_esb_fops, xive,
> +				O_RDWR | O_CLOEXEC);
> +	if (ret < 0)
> +		return ret;
> +
> +	return put_user(ret, ubufp);
> +}
> +
>  static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>  				       struct kvm_device_attr *attr)
>  {
> @@ -162,12 +241,30 @@ static int kvmppc_xive_native_set_attr(struct kvm_d=
evice *dev,
>  static int kvmppc_xive_native_get_attr(struct kvm_device *dev,
>  				       struct kvm_device_attr *attr)
>  {
> +	struct kvmppc_xive *xive =3D dev->private;
> +
> +	switch (attr->group) {
> +	case KVM_DEV_XIVE_GRP_CTRL:
> +		switch (attr->attr) {
> +		case KVM_DEV_XIVE_GET_ESB_FD:
> +			return kvmppc_xive_native_get_esb_fd(xive, attr->addr);
> +		}
> +		break;
> +	}
>  	return -ENXIO;
>  }
> =20
>  static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
>  				       struct kvm_device_attr *attr)
>  {
> +	switch (attr->group) {
> +	case KVM_DEV_XIVE_GRP_CTRL:
> +		switch (attr->attr) {
> +		case KVM_DEV_XIVE_GET_ESB_FD:
> +			return 0;
> +		}
> +		break;
> +	}
>  	return -ENXIO;
>  }
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxXw2kACgkQbDjKyiDZ
s5K50Q/7BNfoGH3G0e/oi3kfFiDZQyrRUKpq31HIoi4agl8DtCrMgTDmaKBQYyue
DuNK3eFhRcI/BLQF1SrFtp3n5ShcWOT3B0mVom2lYcFCf6rwPWaYWdu/bu+Vq500
2K4dJoYpP1Pe1H/CP2ip13WznlGL+V86rIOb5l4qb0ZgdNp73N1s6wwl2tUbNbDE
l1bUg93LAQuF3Z0IX6gGtVx2s8MWC0oXSLnm1CjALH9jAKfA63AHEaDezMGh4jih
q7Wb0O1e4UR2uAEj/idXnszc8uLnu7FUyZU/iq/rrbuHVvIXJgRnYhht7D+ncIuY
JUmlREkHbsa9AvqHn371+nPXQU+03DU9PoJDR750r6aarD1QVSBHkZIiOCGky8kD
JBuGNIcXt7KaxarIwJbNw7EPouJcQVdoqQXTxgrGQrPEl4uqJ4UT0dJ793r6KL0T
ZAp1dCUUCyCQqYRBU72lLb0EKEGUD6wgR7dph3biaecK7WCzos70Q4FaR0LYK447
sdtUbBqzS+Fr4bcKv+DArfbToicW/zmWWWll2NxC9trJlIpeYuJM3LGhUGkqfvxa
vH657VMrL1tKsC1iXPS41yK6JchBi1UWjlhMhESZo+ZS0BPJG9Esgl2gWVyGX9vT
bXagRYxJOcstLZ7H+U9PxTN8iID2U2SVxBFOY9SjIcg4bmRwJu8=
=/sPs
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
