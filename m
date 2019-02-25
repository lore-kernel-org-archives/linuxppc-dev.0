Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C13FC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 04:15:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB442087C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 04:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Li+sKdGT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB442087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4477sD669szDqS0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 15:15:28 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4477Rm6fdzzDqFv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 14:56:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="Li+sKdGT"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4477Rm3FNQz9sNL; Mon, 25 Feb 2019 14:56:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1551067012;
 bh=1gGH6Kseb6ZnQeprKziQR6Xj+F0DiqK42i0/uGCdnts=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Li+sKdGTTQMkJHKl0BICwNkl0BCJzRz2UOJhwJGotCRSotmO4i8wiyv2ZZagHsBNa
 u4IrnXNUNcRsWn0WlIn665aVx1LK5PC2TaK1n4i6QRJHTpZU68F4Biuny8JvNkgQcv
 1AmBA3zS7y/CuoWI8ttZUG05j3MPIRU+E2pgvRD0=
Date: Mon, 25 Feb 2019 14:47:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 13/16] KVM: PPC: Book3S HV: XIVE: add a mapping for
 the source ESB pages
Message-ID: <20190225034726.GQ7668@umbus.fritz.box>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-14-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mzmkN2k+aDjaU9Rr"
Content-Disposition: inline
In-Reply-To: <20190222112840.25000-14-clg@kaod.org>
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


--mzmkN2k+aDjaU9Rr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 12:28:37PM +0100, C=E9dric Le Goater wrote:
> Each source is associated with an Event State Buffer (ESB) with a
> even/odd pair of pages which provides commands to manage the source:
> to trigger, to EOI, to turn off the source for instance.
>=20
> The custom VM fault handler will deduce the guest IRQ number from the
> offset of the fault, and the ESB page of the associated XIVE interrupt
> will be inserted into the VMA using the internal structure caching
> information on the interrupts.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

With the same caveat as the previous patch.

> ---
>  arch/powerpc/include/uapi/asm/kvm.h        |  1 +
>  arch/powerpc/kvm/book3s_xive_native.c      | 57 ++++++++++++++++++++++
>  Documentation/virtual/kvm/devices/xive.txt |  7 +++
>  3 files changed, 65 insertions(+)
>=20
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index be9b255e061d..d8990e9044e3 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -721,5 +721,6 @@ struct kvm_ppc_xive_eq {
>  #define KVM_XIVE_EQ_FLAG_ESCALATE	0x00000004
> =20
>  #define KVM_XIVE_TIMA_PAGE_OFFSET	0
> +#define KVM_XIVE_ESB_PAGE_OFFSET	4
> =20
>  #endif /* __LINUX_KVM_POWERPC_H */
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index c6ac818a13b2..92cab6409e8e 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -176,6 +176,59 @@ int kvmppc_xive_native_connect_vcpu(struct kvm_devic=
e *dev,
>  	return rc;
>  }
> =20
> +static int xive_native_esb_fault(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma =3D vmf->vma;
> +	struct kvm_device *dev =3D vma->vm_file->private_data;
> +	struct kvmppc_xive *xive =3D dev->private;
> +	struct kvmppc_xive_src_block *sb;
> +	struct kvmppc_xive_irq_state *state;
> +	struct xive_irq_data *xd;
> +	u32 hw_num;
> +	u16 src;
> +	u64 page;
> +	unsigned long irq;
> +	u64 page_offset;
> +
> +	/*
> +	 * Linux/KVM uses a two pages ESB setting, one for trigger and
> +	 * one for EOI
> +	 */
> +	page_offset =3D vmf->pgoff - vma->vm_pgoff;
> +	irq =3D page_offset / 2;
> +
> +	sb =3D kvmppc_xive_find_source(xive, irq, &src);
> +	if (!sb) {
> +		pr_devel("%s: source %lx not found !\n", __func__, irq);
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
> +	page =3D page_offset % 2 ? xd->eoi_page : xd->trig_page;
> +	arch_spin_unlock(&sb->lock);
> +
> +	if (WARN_ON(!page)) {
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
>  static int xive_native_tima_fault(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma =3D vmf->vma;
> @@ -205,6 +258,10 @@ static int kvmppc_xive_native_mmap(struct kvm_device=
 *dev,
>  		if (vma_pages(vma) > 4)
>  			return -EINVAL;
>  		vma->vm_ops =3D &xive_native_tima_vmops;
> +	} else if (vma->vm_pgoff =3D=3D KVM_XIVE_ESB_PAGE_OFFSET) {
> +		if (vma_pages(vma) > KVMPPC_XIVE_NR_IRQS * 2)
> +			return -EINVAL;
> +		vma->vm_ops =3D &xive_native_esb_vmops;
>  	} else {
>  		return -EINVAL;
>  	}
> diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/v=
irtual/kvm/devices/xive.txt
> index 4d6b41609fd9..be5000b2eb5a 100644
> --- a/Documentation/virtual/kvm/devices/xive.txt
> +++ b/Documentation/virtual/kvm/devices/xive.txt
> @@ -36,6 +36,13 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
>    third (operating system) and the fourth (user level) are exposed the
>    guest.
> =20
> +  2. Event State Buffer (ESB)
> +
> +  Each source is associated with an Event State Buffer (ESB) with
> +  either a pair of even/odd pair of pages which provides commands to
> +  manage the source: to trigger, to EOI, to turn off the source for
> +  instance.
> +
>  * Groups:
> =20
>    1. KVM_DEV_XIVE_GRP_CTRL

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mzmkN2k+aDjaU9Rr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxzZU4ACgkQbDjKyiDZ
s5LLAA/7BwSS3balDu1I+2pzrekPl75En1rAboth5fLaxxN5/dQGUmz2Hv2OpCAt
5JP5xPi/F3/cS7WP2rMVDY/n/1pKvh9ylOkYY7iOcI4/x0vTOWEJNojJWxAHMaw8
0cxI/Yrgj9WJgy5wSd1vK2ipAt4IGW1ik43lAC8TxdQOemx11kMZcckLJJO1Jyop
zxr8CXP24B5hZOXGvbsyQjAf7pOWskcd2pcVvMYg72Fv+2J5Biiy34Klhd/HDOnn
H4qL355TNxkPbGX+I/5Lze39FS1pCgqE2teYpi7hzqewedJ9ocwahC0Sng2FG19X
jiB4PhS3c2KzkGA48bQaRvIgwDxIw5wS00MjnzxpH9fvlpw22Vzdc/lVtH9Cy+Tz
TyKCZIRabCbtA5XzqiZGekdloHXsnPuJzmXZyzHNr2PtB0Hy1XQAVfNVMgp+GDKH
w83nbU5cdzwTEpGsX315wFQJZuFJAtGad4mtDHZMSY72aTcQehvukch/ZcQwYQ95
WaQnkgPRMsHtzTatcabinNSFymtpK1eL83MCHjz0liKVr+/3TR5c8jq6pBtEjUci
p6VtJnEIS77Z94TcUPMXk+vbCW8BAnTb7LLCCiZOqdC3MG02fYB38+pI0S5Gh2xC
SAYK0q4cnX8g8Z9ACABk6QuLTMZ21Z9h9NDhOvZm/YGz0r+t1Vk=
=9e31
-----END PGP SIGNATURE-----

--mzmkN2k+aDjaU9Rr--
