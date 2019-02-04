Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEED3C282D7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:22:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F09B2075D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nMG6BOVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F09B2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tHg42smWzDqGg
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 17:22:08 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tHSK68GKzDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 17:12:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="nMG6BOVe"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43tHSK4HpGz9sNC; Mon,  4 Feb 2019 17:12:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549260769;
 bh=ebDqE01IedxFfOwl5dPQst167+vsVZ3JeuhlsvFbABs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nMG6BOVewmo9awEQ+oKSZ95vvCwNSDFSOEGJZ9ASDq5txJEAfNxr0z16lR89vK9Cl
 mydIHQSWG5Rz2zfzbjjuc3yqWaro6ch79A2Mwa5ZBfEW18YOjkmmL9cR6q5tGhSCdi
 l53Lyp0MMnw1b7NgaGp+KZp0gOEDZIB1cb+T5Phk=
Date: Mon, 4 Feb 2019 16:21:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 15/19] KVM: PPC: Book3S HV: add get/set accessors for the
 source configuration
Message-ID: <20190204052148.GH1927@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-16-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oyqLL/JqMvClXZi1"
Content-Disposition: inline
In-Reply-To: <20190107184331.8429-16-clg@kaod.org>
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


--oyqLL/JqMvClXZi1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:43:27PM +0100, C=E9dric Le Goater wrote:
> Theses are use to capure the XIVE EAS table of the KVM device, the
> configuration of the source targets.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/include/uapi/asm/kvm.h   | 11 ++++
>  arch/powerpc/kvm/book3s_xive_native.c | 87 +++++++++++++++++++++++++++
>  2 files changed, 98 insertions(+)
>=20
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index 1a8740629acf..faf024f39858 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -683,9 +683,20 @@ struct kvm_ppc_cpu_char {
>  #define   KVM_DEV_XIVE_SAVE_EQ_PAGES	4
>  #define KVM_DEV_XIVE_GRP_SOURCES	2	/* 64-bit source attributes */
>  #define KVM_DEV_XIVE_GRP_SYNC		3	/* 64-bit source attributes */
> +#define KVM_DEV_XIVE_GRP_EAS		4	/* 64-bit eas attributes */
> =20
>  /* Layout of 64-bit XIVE source attribute values */
>  #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
>  #define KVM_XIVE_LEVEL_ASSERTED		(1ULL << 1)
> =20
> +/* Layout of 64-bit eas attribute values */
> +#define KVM_XIVE_EAS_PRIORITY_SHIFT	0
> +#define KVM_XIVE_EAS_PRIORITY_MASK	0x7
> +#define KVM_XIVE_EAS_SERVER_SHIFT	3
> +#define KVM_XIVE_EAS_SERVER_MASK	0xfffffff8ULL
> +#define KVM_XIVE_EAS_MASK_SHIFT		32
> +#define KVM_XIVE_EAS_MASK_MASK		0x100000000ULL
> +#define KVM_XIVE_EAS_EISN_SHIFT		33
> +#define KVM_XIVE_EAS_EISN_MASK		0xfffffffe00000000ULL
> +
>  #endif /* __LINUX_KVM_POWERPC_H */
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index f2de1bcf3b35..0468b605baa7 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -525,6 +525,88 @@ static int kvmppc_xive_native_sync(struct kvmppc_xiv=
e *xive, long irq, u64 addr)
>  	return 0;
>  }
> =20
> +static int kvmppc_xive_native_set_eas(struct kvmppc_xive *xive, long irq,
> +				      u64 addr)

I'd prefer to avoid the name "EAS" here.  IIUC these aren't "raw" EAS
values, but rather essentially the "source config" in the terminology
of the PAPR hcalls.  Which, yes, is basically implemented by setting
the EAS, but since it's the PAPR architected state that we need to
preserve across migration, I'd prefer to stick as close as we can to
the PAPR terminology.

> +{
> +	struct kvmppc_xive_src_block *sb;
> +	struct kvmppc_xive_irq_state *state;
> +	u64 __user *ubufp =3D (u64 __user *) addr;
> +	u16 src;
> +	u64 kvm_eas;
> +	u32 server;
> +	u8 priority;
> +	u32 eisn;
> +
> +	sb =3D kvmppc_xive_find_source(xive, irq, &src);
> +	if (!sb)
> +		return -ENOENT;
> +
> +	state =3D &sb->irq_state[src];
> +
> +	if (!state->valid)
> +		return -EINVAL;
> +
> +	if (get_user(kvm_eas, ubufp))
> +		return -EFAULT;
> +
> +	pr_devel("%s irq=3D0x%lx eas=3D%016llx\n", __func__, irq, kvm_eas);
> +
> +	priority =3D (kvm_eas & KVM_XIVE_EAS_PRIORITY_MASK) >>
> +		KVM_XIVE_EAS_PRIORITY_SHIFT;
> +	server =3D (kvm_eas & KVM_XIVE_EAS_SERVER_MASK) >>
> +		KVM_XIVE_EAS_SERVER_SHIFT;
> +	eisn =3D (kvm_eas & KVM_XIVE_EAS_EISN_MASK) >> KVM_XIVE_EAS_EISN_SHIFT;
> +
> +	if (priority !=3D xive_prio_from_guest(priority)) {
> +		pr_err("invalid priority for queue %d for VCPU %d\n",
> +		       priority, server);
> +		return -EINVAL;
> +	}
> +
> +	return kvmppc_xive_native_set_source_config(xive, sb, state, server,
> +						    priority, eisn);
> +}
> +
> +static int kvmppc_xive_native_get_eas(struct kvmppc_xive *xive, long irq,
> +				      u64 addr)
> +{
> +	struct kvmppc_xive_src_block *sb;
> +	struct kvmppc_xive_irq_state *state;
> +	u64 __user *ubufp =3D (u64 __user *) addr;
> +	u16 src;
> +	u64 kvm_eas;
> +
> +	sb =3D kvmppc_xive_find_source(xive, irq, &src);
> +	if (!sb)
> +		return -ENOENT;
> +
> +	state =3D &sb->irq_state[src];
> +
> +	if (!state->valid)
> +		return -EINVAL;
> +
> +	arch_spin_lock(&sb->lock);
> +
> +	if (state->act_priority =3D=3D MASKED)
> +		kvm_eas =3D KVM_XIVE_EAS_MASK_MASK;
> +	else {
> +		kvm_eas =3D (state->act_priority << KVM_XIVE_EAS_PRIORITY_SHIFT) &
> +			KVM_XIVE_EAS_PRIORITY_MASK;
> +		kvm_eas |=3D (state->act_server << KVM_XIVE_EAS_SERVER_SHIFT) &
> +			KVM_XIVE_EAS_SERVER_MASK;
> +		kvm_eas |=3D ((u64) state->eisn << KVM_XIVE_EAS_EISN_SHIFT) &
> +			KVM_XIVE_EAS_EISN_MASK;
> +	}
> +	arch_spin_unlock(&sb->lock);
> +
> +	pr_devel("%s irq=3D0x%lx eas=3D%016llx\n", __func__, irq, kvm_eas);
> +
> +	if (put_user(kvm_eas, ubufp))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
>  static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>  				       struct kvm_device_attr *attr)
>  {
> @@ -544,6 +626,8 @@ static int kvmppc_xive_native_set_attr(struct kvm_dev=
ice *dev,
>  						     attr->addr);
>  	case KVM_DEV_XIVE_GRP_SYNC:
>  		return kvmppc_xive_native_sync(xive, attr->attr, attr->addr);
> +	case KVM_DEV_XIVE_GRP_EAS:
> +		return kvmppc_xive_native_set_eas(xive, attr->attr, attr->addr);
>  	}
>  	return -ENXIO;
>  }
> @@ -564,6 +648,8 @@ static int kvmppc_xive_native_get_attr(struct kvm_dev=
ice *dev,
>  			return kvmppc_xive_native_get_vc_base(xive, attr->addr);
>  		}
>  		break;
> +	case KVM_DEV_XIVE_GRP_EAS:
> +		return kvmppc_xive_native_get_eas(xive, attr->attr, attr->addr);
>  	}
>  	return -ENXIO;
>  }
> @@ -583,6 +669,7 @@ static int kvmppc_xive_native_has_attr(struct kvm_dev=
ice *dev,
>  		break;
>  	case KVM_DEV_XIVE_GRP_SOURCES:
>  	case KVM_DEV_XIVE_GRP_SYNC:
> +	case KVM_DEV_XIVE_GRP_EAS:
>  		if (attr->attr >=3D KVMPPC_XIVE_FIRST_IRQ &&
>  		    attr->attr < KVMPPC_XIVE_NR_IRQS)
>  			return 0;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oyqLL/JqMvClXZi1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxXy+wACgkQbDjKyiDZ
s5ICiQ/+Nz+Y32mJRLldBY/usHeumK2HbfR1hJx0v9zql4CGwWEtMiF9nOZmt1Jz
MgQ5SgKB44e4cnnwiqIdS2Y4lNmaXvpw8mnt6lT63T1QQ+FsMG4b/IRqrp0ej25o
gSpSdJSeO5Lp9MdyfIsfQoTz/8kzFsINKHX7VU/EPfgVjCyjj/PjoTwNC9E5fFJM
ToEM7Ii/mylr4kh+U/M1rqIKk5bXk8oibmJDWtn24i8gpOcdQ9C08HOVsPmd3MKx
nS5pT3rfUzwn3KJtn6bHt+WL2c2eqsXaJmVu46V8pYcav25i4pxSM+0m70OwnOw0
AKnNa9fa2w8po7RioSNE6JTPjRrN7N1qEmTRFdOyYOsizLYQt4dezzKgVqHqgk/m
yhX1vi2ec9ienrUNqz2lmyQVaTaq5kDrPZIb3nLL6S6zoEiTwHqnOpAJ917B6woK
UOFc5Ya/HxYXqjiMDt9ABUFPO6xMMgdh5uoPix4MmJdOs5oqsKezyeacpvsKUKBL
7vqbhs+gsJlUUhxq9s6ZugL6szZULECnpjbDwioKsdLub0elPSOx2DLRgUTVt75k
m5CYAL+iOz39bp7IWiIBIZF4cUewxNbSWEF6Yol7jGyZEZ8v6nkcN/p8qyKEsNF3
H/kjFm/vBkkQ5xbu0hky/x2XKLXaTKagAZCwWvJ5WpbKllEsXDo=
=MnPg
-----END PGP SIGNATURE-----

--oyqLL/JqMvClXZi1--
