Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0FAC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 05:21:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9659F20872
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 05:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IRWN/XSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9659F20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44N4KP4JXBzDqKf
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 16:21:13 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44N48f5QnhzDqDs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 16:13:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="IRWN/XSo"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44N48f1sQNz9s5c; Mon, 18 Mar 2019 16:13:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552886018;
 bh=57Ug2qyze5z+PhuOJRHqCXW6crZEzZhIJAGh2LhBdhM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IRWN/XSoxewn6ym9X8Az/aGIgJULhHDWoI5FfAxl4QZXYEswR78CUOmzyCzWggXWq
 32At1hqGGVWQQalUGul2M2IOL7G3z5yhMiU5+3MnQjFG0gpEdDp/lLXv91pdLjoxth
 2BOHBW6uN94z9q+OIHauGmBp8UaR9vb8MTbyGJl0=
Date: Mon, 18 Mar 2019 14:28:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 08/17] KVM: PPC: Book3S HV: XIVE: add a control to
 sync the sources
Message-ID: <20190318032802.GJ6874@umbus.fritz.box>
References: <20190315120609.25910-1-clg@kaod.org>
 <20190315120609.25910-9-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8jNwmpfkpox/fiJK"
Content-Disposition: inline
In-Reply-To: <20190315120609.25910-9-clg@kaod.org>
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--8jNwmpfkpox/fiJK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2019 at 01:06:00PM +0100, C=E9dric Le Goater wrote:
> This control will be used by the H_INT_SYNC hcall from QEMU to flush
> event notifications on the XIVE IC owning the source.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
>  Changes since v2 :
>=20
>  - fixed locking on source block
>=20
>  arch/powerpc/include/uapi/asm/kvm.h        |  1 +
>  arch/powerpc/kvm/book3s_xive_native.c      | 36 ++++++++++++++++++++++
>  Documentation/virtual/kvm/devices/xive.txt |  8 +++++
>  3 files changed, 45 insertions(+)
>=20
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index 95e82ab57c03..fc9211dbfec8 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -681,6 +681,7 @@ struct kvm_ppc_cpu_char {
>  #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source identifier */
>  #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source identifier */
>  #define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit EQ identifier */
> +#define KVM_DEV_XIVE_GRP_SOURCE_SYNC	5       /* 64-bit source identifier=
 */
> =20
>  /* Layout of 64-bit XIVE source attribute values */
>  #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index 3385c336fd89..26ac3c505cd2 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -340,6 +340,38 @@ static int kvmppc_xive_native_set_source_config(stru=
ct kvmppc_xive *xive,
>  						       priority, masked, eisn);
>  }
> =20
> +static int kvmppc_xive_native_sync_source(struct kvmppc_xive *xive,
> +					  long irq, u64 addr)
> +{
> +	struct kvmppc_xive_src_block *sb;
> +	struct kvmppc_xive_irq_state *state;
> +	struct xive_irq_data *xd;
> +	u32 hw_num;
> +	u16 src;
> +	int rc =3D 0;
> +
> +	pr_devel("%s irq=3D0x%lx", __func__, irq);
> +
> +	sb =3D kvmppc_xive_find_source(xive, irq, &src);
> +	if (!sb)
> +		return -ENOENT;
> +
> +	state =3D &sb->irq_state[src];
> +
> +	rc =3D -EINVAL;
> +
> +	arch_spin_lock(&sb->lock);
> +
> +	if (state->valid) {
> +		kvmppc_xive_select_irq(state, &hw_num, &xd);
> +		xive_native_sync_source(hw_num);
> +		rc =3D 0;
> +	}
> +
> +	arch_spin_unlock(&sb->lock);
> +	return rc;
> +}
> +
>  static int xive_native_validate_queue_size(u32 qsize)
>  {
>  	/*
> @@ -658,6 +690,9 @@ static int kvmppc_xive_native_set_attr(struct kvm_dev=
ice *dev,
>  	case KVM_DEV_XIVE_GRP_EQ_CONFIG:
>  		return kvmppc_xive_native_set_queue_config(xive, attr->attr,
>  							   attr->addr);
> +	case KVM_DEV_XIVE_GRP_SOURCE_SYNC:
> +		return kvmppc_xive_native_sync_source(xive, attr->attr,
> +						      attr->addr);
>  	}
>  	return -ENXIO;
>  }
> @@ -687,6 +722,7 @@ static int kvmppc_xive_native_has_attr(struct kvm_dev=
ice *dev,
>  		break;
>  	case KVM_DEV_XIVE_GRP_SOURCE:
>  	case KVM_DEV_XIVE_GRP_SOURCE_CONFIG:
> +	case KVM_DEV_XIVE_GRP_SOURCE_SYNC:
>  		if (attr->attr >=3D KVMPPC_XIVE_FIRST_IRQ &&
>  		    attr->attr < KVMPPC_XIVE_NR_IRQS)
>  			return 0;
> diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/v=
irtual/kvm/devices/xive.txt
> index e1893d303ab7..055aed0c2abb 100644
> --- a/Documentation/virtual/kvm/devices/xive.txt
> +++ b/Documentation/virtual/kvm/devices/xive.txt
> @@ -89,3 +89,11 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
>      -EINVAL: Invalid queue address
>      -EFAULT: Invalid user pointer for attr->addr.
>      -EIO:    Configuration of the underlying HW failed
> +
> +  5. KVM_DEV_XIVE_GRP_SOURCE_SYNC (write only)
> +  Synchronize the source to flush event notifications
> +  Attributes:
> +    Interrupt source number  (64-bit)
> +  Errors:
> +    -ENOENT: Unknown source number
> +    -EINVAL: Not initialized source number

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8jNwmpfkpox/fiJK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyPEEIACgkQbDjKyiDZ
s5LOHRAAm/1OJMnnMlsAQMMkHiPG1D3B7ax4dGF31b6Y+9XhsmEri/1ncNwj6jnh
KAErjVPnNuMME8MSql0JVYj4lYdFrwYK1h7kpEqEljVfqTnzPkVBLkXxZJzeNcoD
PelmAJiNy83HEHfGHOqfNdltRsY3DFwFFqt2YdBhGV6K9psx5fVUd/U6mSc8VeNu
wvR6TfSSSPzRXEp9MDxC0UiwyGGpe7JX0Rs4mSB6qv8j+LI28JnTHANy8u6aPJ9t
gJV1eKz2jsIRRHJf9ttw+KxTbRHuV+MNhBkRYRwYCYc0mV4CPbieDzPJkpSr0sYF
Hai2M8618waZlCBXxAxGc+3sQaCEJEpiKtBvxIuKopjm9fpyes6FijsUEQL44QC/
QaEjeU8p5Dz9JJdEZIlLzj5rHdnfSHenIepwnR0i+4vOdFL/nORJx9ygT511KYoU
w/5YdLcVetrUXoByKvAZol63oucBbFFOvTJ+SLfMvvbDtdzWpkDky4B8c9tdxVf2
/OKy34Zh+TZwq0sEqumhUzso5gWYCVLR9MTAxIP9x/NaGjho3MXcftRO3nTiaJLh
ycxRc2wMdCCxcJoLqbV1zVqMuUuDvVUCJvtHUhKaD4SZyKkCHa4K0HrWAMB2qn8A
Nptt8fLwUuot4TqpJwja+6YBX2Tswhav4UsIfsK/VrFufbtpx5Y=
=49c/
-----END PGP SIGNATURE-----

--8jNwmpfkpox/fiJK--
