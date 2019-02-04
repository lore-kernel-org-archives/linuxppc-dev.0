Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD68C282D7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:23:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16BC52075D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UU3OepPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BC52075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tHhj1dLGzDqGW
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 17:23:33 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tHSK653gzDqGg
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 17:12:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="UU3OepPs"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43tHSK3WN9z9sN1; Mon,  4 Feb 2019 17:12:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549260769;
 bh=zh0EA6TM9/R/53yu4JOV1pkpWotHO/a7V2RsgXF6+IQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UU3OepPskznGMYSa33FwZpdYBCMR1cmsLIHjcm01Ii9s704aJDSBD028DYGWNN/1p
 GMf1h3/YWCYs9vKou4ex5Xpy2TUaetB6WK2GqA9E5DvG0X7QY8Lq84/lv6LdnSykwO
 M7rrEPDxieZiP8ugN29aRN3bdI+3jdIEiCzNcZ+w=
Date: Mon, 4 Feb 2019 16:24:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 16/19] KVM: PPC: Book3S HV: add get/set accessors for the
 EQ configuration
Message-ID: <20190204052436.GI1927@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-17-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TKDEsImF70pdVIl+"
Content-Disposition: inline
In-Reply-To: <20190107184331.8429-17-clg@kaod.org>
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


--TKDEsImF70pdVIl+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:43:28PM +0100, C=E9dric Le Goater wrote:
> These are used to capture the XIVE END table of the KVM device. It
> relies on an OPAL call to retrieve from the XIVE IC the EQ toggle bit
> and index which are updated by the HW when events are enqueued in the
> guest RAM.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/include/uapi/asm/kvm.h   |  21 ++++
>  arch/powerpc/kvm/book3s_xive_native.c | 166 ++++++++++++++++++++++++++
>  2 files changed, 187 insertions(+)
>=20
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index faf024f39858..95302558ce10 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -684,6 +684,7 @@ struct kvm_ppc_cpu_char {
>  #define KVM_DEV_XIVE_GRP_SOURCES	2	/* 64-bit source attributes */
>  #define KVM_DEV_XIVE_GRP_SYNC		3	/* 64-bit source attributes */
>  #define KVM_DEV_XIVE_GRP_EAS		4	/* 64-bit eas attributes */
> +#define KVM_DEV_XIVE_GRP_EQ		5	/* 64-bit eq attributes */
> =20
>  /* Layout of 64-bit XIVE source attribute values */
>  #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
> @@ -699,4 +700,24 @@ struct kvm_ppc_cpu_char {
>  #define KVM_XIVE_EAS_EISN_SHIFT		33
>  #define KVM_XIVE_EAS_EISN_MASK		0xfffffffe00000000ULL
> =20
> +/* Layout of 64-bit eq attribute */
> +#define KVM_XIVE_EQ_PRIORITY_SHIFT	0
> +#define KVM_XIVE_EQ_PRIORITY_MASK	0x7
> +#define KVM_XIVE_EQ_SERVER_SHIFT	3
> +#define KVM_XIVE_EQ_SERVER_MASK		0xfffffff8ULL
> +
> +/* Layout of 64-bit eq attribute values */
> +struct kvm_ppc_xive_eq {
> +	__u32 flags;
> +	__u32 qsize;
> +	__u64 qpage;
> +	__u32 qtoggle;
> +	__u32 qindex;

Should we pad this in case a) we discover some fields in the EQ that
we thought weren't relevant to the guest actually are or b) future
XIVE extensions add something we need to migrate.

> +};
> +
> +#define KVM_XIVE_EQ_FLAG_ENABLED	0x00000001
> +#define KVM_XIVE_EQ_FLAG_ALWAYS_NOTIFY	0x00000002
> +#define KVM_XIVE_EQ_FLAG_ESCALATE	0x00000004
> +
> +
>  #endif /* __LINUX_KVM_POWERPC_H */
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index 0468b605baa7..f4eb71eafc57 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -607,6 +607,164 @@ static int kvmppc_xive_native_get_eas(struct kvmppc=
_xive *xive, long irq,
>  	return 0;
>  }
> =20
> +static int kvmppc_xive_native_set_queue(struct kvmppc_xive *xive, long e=
q_idx,
> +				      u64 addr)
> +{
> +	struct kvm *kvm =3D xive->kvm;
> +	struct kvm_vcpu *vcpu;
> +	struct kvmppc_xive_vcpu *xc;
> +	void __user *ubufp =3D (u64 __user *) addr;
> +	u32 server;
> +	u8 priority;
> +	struct kvm_ppc_xive_eq kvm_eq;
> +	int rc;
> +	__be32 *qaddr =3D 0;
> +	struct page *page;
> +	struct xive_q *q;
> +
> +	/*
> +	 * Demangle priority/server tuple from the EQ index
> +	 */
> +	priority =3D (eq_idx & KVM_XIVE_EQ_PRIORITY_MASK) >>
> +		KVM_XIVE_EQ_PRIORITY_SHIFT;
> +	server =3D (eq_idx & KVM_XIVE_EQ_SERVER_MASK) >>
> +		KVM_XIVE_EQ_SERVER_SHIFT;
> +
> +	if (copy_from_user(&kvm_eq, ubufp, sizeof(kvm_eq)))
> +		return -EFAULT;
> +
> +	vcpu =3D kvmppc_xive_find_server(kvm, server);
> +	if (!vcpu) {
> +		pr_err("Can't find server %d\n", server);
> +		return -ENOENT;
> +	}
> +	xc =3D vcpu->arch.xive_vcpu;
> +
> +	if (priority !=3D xive_prio_from_guest(priority)) {
> +		pr_err("Trying to restore invalid queue %d for VCPU %d\n",
> +		       priority, server);
> +		return -EINVAL;
> +	}
> +	q =3D &xc->queues[priority];
> +
> +	pr_devel("%s VCPU %d priority %d fl:%x sz:%d addr:%llx g:%d idx:%d\n",
> +		 __func__, server, priority, kvm_eq.flags,
> +		 kvm_eq.qsize, kvm_eq.qpage, kvm_eq.qtoggle, kvm_eq.qindex);
> +
> +	rc =3D xive_native_validate_queue_size(kvm_eq.qsize);
> +	if (rc || !kvm_eq.qsize) {
> +		pr_err("invalid queue size %d\n", kvm_eq.qsize);
> +		return rc;
> +	}
> +
> +	page =3D gfn_to_page(kvm, gpa_to_gfn(kvm_eq.qpage));
> +	if (is_error_page(page)) {
> +		pr_warn("Couldn't get guest page for %llx!\n", kvm_eq.qpage);
> +		return -ENOMEM;
> +	}
> +	qaddr =3D page_to_virt(page) + (kvm_eq.qpage & ~PAGE_MASK);
> +
> +	/* Backup queue page guest address for migration */
> +	q->guest_qpage =3D kvm_eq.qpage;
> +	q->guest_qsize =3D kvm_eq.qsize;
> +
> +	rc =3D xive_native_configure_queue(xc->vp_id, q, priority,
> +					 (__be32 *) qaddr, kvm_eq.qsize, true);
> +	if (rc) {
> +		pr_err("Failed to configure queue %d for VCPU %d: %d\n",
> +		       priority, xc->server_num, rc);
> +		put_page(page);
> +		return rc;
> +	}
> +
> +	rc =3D xive_native_set_queue_state(xc->vp_id, priority, kvm_eq.qtoggle,
> +					 kvm_eq.qindex);
> +	if (rc)
> +		goto error;
> +
> +	rc =3D kvmppc_xive_attach_escalation(vcpu, priority);
> +error:
> +	if (rc)
> +		xive_native_cleanup_queue(vcpu, priority);
> +	return rc;
> +}
> +
> +static int kvmppc_xive_native_get_queue(struct kvmppc_xive *xive, long e=
q_idx,
> +				      u64 addr)
> +{
> +	struct kvm *kvm =3D xive->kvm;
> +	struct kvm_vcpu *vcpu;
> +	struct kvmppc_xive_vcpu *xc;
> +	struct xive_q *q;
> +	void __user *ubufp =3D (u64 __user *) addr;
> +	u32 server;
> +	u8 priority;
> +	struct kvm_ppc_xive_eq kvm_eq;
> +	u64 qpage;
> +	u64 qsize;
> +	u64 qeoi_page;
> +	u32 escalate_irq;
> +	u64 qflags;
> +	int rc;
> +
> +	/*
> +	 * Demangle priority/server tuple from the EQ index
> +	 */
> +	priority =3D (eq_idx & KVM_XIVE_EQ_PRIORITY_MASK) >>
> +		KVM_XIVE_EQ_PRIORITY_SHIFT;
> +	server =3D (eq_idx & KVM_XIVE_EQ_SERVER_MASK) >>
> +		KVM_XIVE_EQ_SERVER_SHIFT;
> +
> +	vcpu =3D kvmppc_xive_find_server(kvm, server);
> +	if (!vcpu) {
> +		pr_err("Can't find server %d\n", server);
> +		return -ENOENT;
> +	}
> +	xc =3D vcpu->arch.xive_vcpu;
> +
> +	if (priority !=3D xive_prio_from_guest(priority)) {
> +		pr_err("invalid priority for queue %d for VCPU %d\n",
> +		       priority, server);
> +		return -EINVAL;
> +	}
> +	q =3D &xc->queues[priority];
> +
> +	memset(&kvm_eq, 0, sizeof(kvm_eq));
> +
> +	if (!q->qpage)
> +		return 0;
> +
> +	rc =3D xive_native_get_queue_info(xc->vp_id, priority, &qpage, &qsize,
> +					&qeoi_page, &escalate_irq, &qflags);
> +	if (rc)
> +		return rc;
> +
> +	kvm_eq.flags =3D 0;
> +	if (qflags & OPAL_XIVE_EQ_ENABLED)
> +		kvm_eq.flags |=3D KVM_XIVE_EQ_FLAG_ENABLED;
> +	if (qflags & OPAL_XIVE_EQ_ALWAYS_NOTIFY)
> +		kvm_eq.flags |=3D KVM_XIVE_EQ_FLAG_ALWAYS_NOTIFY;
> +	if (qflags & OPAL_XIVE_EQ_ESCALATE)
> +		kvm_eq.flags |=3D KVM_XIVE_EQ_FLAG_ESCALATE;
> +
> +	kvm_eq.qsize =3D q->guest_qsize;
> +	kvm_eq.qpage =3D q->guest_qpage;
> +
> +	rc =3D xive_native_get_queue_state(xc->vp_id, priority, &kvm_eq.qtoggle,
> +					 &kvm_eq.qindex);
> +	if (rc)
> +		return rc;
> +
> +	pr_devel("%s VCPU %d priority %d fl:%x sz:%d addr:%llx g:%d idx:%d\n",
> +		 __func__, server, priority, kvm_eq.flags,
> +		 kvm_eq.qsize, kvm_eq.qpage, kvm_eq.qtoggle, kvm_eq.qindex);
> +
> +	if (copy_to_user(ubufp, &kvm_eq, sizeof(kvm_eq)))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>  static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>  				       struct kvm_device_attr *attr)
>  {
> @@ -628,6 +786,9 @@ static int kvmppc_xive_native_set_attr(struct kvm_dev=
ice *dev,
>  		return kvmppc_xive_native_sync(xive, attr->attr, attr->addr);
>  	case KVM_DEV_XIVE_GRP_EAS:
>  		return kvmppc_xive_native_set_eas(xive, attr->attr, attr->addr);
> +	case KVM_DEV_XIVE_GRP_EQ:
> +		return kvmppc_xive_native_set_queue(xive, attr->attr,
> +						    attr->addr);
>  	}
>  	return -ENXIO;
>  }
> @@ -650,6 +811,9 @@ static int kvmppc_xive_native_get_attr(struct kvm_dev=
ice *dev,
>  		break;
>  	case KVM_DEV_XIVE_GRP_EAS:
>  		return kvmppc_xive_native_get_eas(xive, attr->attr, attr->addr);
> +	case KVM_DEV_XIVE_GRP_EQ:
> +		return kvmppc_xive_native_get_queue(xive, attr->attr,
> +						    attr->addr);
>  	}
>  	return -ENXIO;
>  }
> @@ -674,6 +838,8 @@ static int kvmppc_xive_native_has_attr(struct kvm_dev=
ice *dev,
>  		    attr->attr < KVMPPC_XIVE_NR_IRQS)
>  			return 0;
>  		break;
> +	case KVM_DEV_XIVE_GRP_EQ:
> +		return 0;
>  	}
>  	return -ENXIO;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TKDEsImF70pdVIl+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxXzJQACgkQbDjKyiDZ
s5LxmxAAjzyzUvUevio9cA9qABXXlteGccaOciMR5Yz/gZ52dmAMQSSxZAE03qAe
5vrhM6JXhvqwKHpLOu5pmHmLuvUG+YOAcA6CTSOzBEAsivVNBKbOJ5s3oQcDr1rr
Z0urF+Aq0pnknsF1rdxwOGla+D7Z5iUE+5bB1Mk0vEGf50qY1jBbdZ7ZuXkv/YNm
WVE9uW6GKk03WUHw/eInyIDR+Re5e4fWbgUiE/398ass97beg7UTcPUOeH2iXz5C
DeRpqPvFEXZpN1BP7sE37OBQ2M0FkO1NISg1TeydUxnhkBVM0v0iaODpA/8AW8AC
I5+kepWAjxezUzt22t1jt0aRqIp+zswlZGe1KmUUVbLveINIaqKenIQRsAqGhUEQ
/Y7mNfv/+Z/aqGWHTQmgf5ZvGoJOsO2KcFBchb33fl5EW+XY4KMrOFn/XGtqw3QD
9mSWBOv2/PZ2Dgi5lU5lW8esIM/wmeIziH5dOc1zpMGhNnHZzfesWcKjpb6zx7Vb
8pR7449G2p0u3SzlAn6XsoaVRAKxOrvPURTYKcpkwn/9fBY/p0nyQB/qN374fLDc
LCy2l3XH6XLGDPnf5Ldd43FetU6OSGlSZ+jWioLezO2N2CV1QNr4E5thOM3GSu/Z
ixo+jh6fYmDLGBCf5x9Gjsl76XMIodhfJVy2dD3ddpVTxZCMRWI=
=frZF
-----END PGP SIGNATURE-----

--TKDEsImF70pdVIl+--
