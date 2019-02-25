Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D342C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 04:09:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D9932084D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 04:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Vh6DU34D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D9932084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4477kY4myhzDq7h
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 15:09:41 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4477Rl5hCxzDqFF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 14:56:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="Vh6DU34D"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4477Rl3sHKz9sNC; Mon, 25 Feb 2019 14:56:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1551067011;
 bh=OxqUgYqixz5eRc5k2/9vJTdTqlbej47J2Rsrn8zSUjI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Vh6DU34DO1r5xYuUjtfEzH0IhiBevfMiqR0li29Exlza722iaWiIWRSwtL653Alu+
 4DpaZQa7cOOlkpb3qnVjM4QVjU4VnvzXwf6Opd3BDleY6IBf8Qc9BnzBFzf06/mZM+
 WUyRiry2/5taNQjeza9rW0rld7GMP6X2nJwkP5v4=
Date: Mon, 25 Feb 2019 13:45:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 08/16] KVM: PPC: Book3S HV: XIVE: add a control to
 sync the sources
Message-ID: <20190225024558.GL7668@umbus.fritz.box>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-9-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dfmC41YZQlborXoK"
Content-Disposition: inline
In-Reply-To: <20190222112840.25000-9-clg@kaod.org>
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


--dfmC41YZQlborXoK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 12:28:32PM +0100, C=E9dric Le Goater wrote:
> This control will be used by the H_INT_SYNC hcall from QEMU.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/include/uapi/asm/kvm.h        |  1 +
>  arch/powerpc/kvm/book3s_xive_native.c      | 34 ++++++++++++++++++++++
>  Documentation/virtual/kvm/devices/xive.txt |  9 ++++++
>  3 files changed, 44 insertions(+)
>=20
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index 7ae8cb22af7d..289c504b7c1d 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -681,6 +681,7 @@ struct kvm_ppc_cpu_char {
>  #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source attributes */
>  #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source attributes */
>  #define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit eq attributes */
> +#define KVM_DEV_XIVE_GRP_SOURCE_SYNC	5       /* 64-bit source attributes=
 */
> =20
>  /* Layout of 64-bit XIVE source attribute values */
>  #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index bb3e121c918a..dd2a9d411fe7 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -341,6 +341,36 @@ static int kvmppc_xive_native_set_source_config(stru=
ct kvmppc_xive *xive,
>  						       priority, eisn);
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
> +
> +	pr_devel("%s irq=3D0x%lx", __func__, irq);
> +
> +	sb =3D kvmppc_xive_find_source(xive, irq, &src);
> +	if (!sb)
> +		return -ENOENT;
> +
> +	state =3D &sb->irq_state[src];
> +
> +	if (!state->valid)

Is testing this before you take the lock safe?

> +		return -EINVAL;
> +
> +	arch_spin_lock(&sb->lock);
> +
> +	kvmppc_xive_select_irq(state, &hw_num, &xd);
> +	xive_native_sync_source(hw_num);
> +
> +	arch_spin_unlock(&sb->lock);
> +
> +	return 0;
> +}
> +
>  static int xive_native_validate_queue_size(u32 qsize)
>  {
>  	switch (qsize) {
> @@ -631,6 +661,9 @@ static int kvmppc_xive_native_set_attr(struct kvm_dev=
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
> @@ -660,6 +693,7 @@ static int kvmppc_xive_native_has_attr(struct kvm_dev=
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
> index f1d007f485a9..267634eae9e0 100644
> --- a/Documentation/virtual/kvm/devices/xive.txt
> +++ b/Documentation/virtual/kvm/devices/xive.txt
> @@ -86,3 +86,12 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
>      -EFAULT: Invalid user pointer for attr->addr.
>      -ENOMEM: Invalid queue address
>      -EIO:    Configuration of the underlying HW failed
> +
> +  5. KVM_DEV_XIVE_GRP_SOURCE_SYNC (write only)
> +  Synchronize the source to flush event notification
> +  Attributes:
> +    Interrupt source number  (64-bit)
> +  Errors:
> +    -ENOENT: Unknown source number
> +    -EINVAL: Not initialized source number, invalid priority or
> +             invalid CPU number.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dfmC41YZQlborXoK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxzVuYACgkQbDjKyiDZ
s5L75hAA3drltyqWykuj2I7WUHVA6yu7c9gxx2H7zV/zvsqeCHRG7zIb5s9n7CT3
oA55T7FYVlZLw/C0FpzOJIVDNDGOFkr1VP1Tp6kyWOS5lc35EwG1/o6YN3ygNH+E
+oxWnzVMyGaSFeNeMW9UQe012Y4CQ8TiBqkN8gUYgBtx+P9eCGAgfuAJaKDSM2Vd
mwe3xk7GgNS/myYe+d2IGM0Ipcucdmmec7gLFfVD3C36FgqPQZsjF0VJQSaX8Ye8
JR/yVqIbjh5i8RXaRDZRDHBReIhTYvtvyRcmGr5UL+UOiUQo248LWtqrJQTNIS56
ok4ANvpI4H0SKB6kUmOW6oPvojzwY5QAazo+um8Cp+/4wYyfY+E31GO4HE3fFXN6
a5NB8MLnk2JvO1iUSl+cxUjxNwv2+FQi13KHTkea4FIcg/ilnbvug5uLzcI47h5m
61lsQAgSZFTCGGAMya+qzHGt44dkyR+kWvQs+ht6B167x73dOcghdUHN0OqLT0kF
jXKRY4OFWmgITZkVWZfuhSrYytXtN2I5oOr1mHc+e0jnzaB7yGRaTFRonSoK7KHE
YRrsmu7+Xa5jmPP38jT5ZDuQ6mjkfZ/HTItb3iElU5+l0r0noqZCPB9Zt6g+ZykV
8bFmoSXPovK6Z9hBRiOQHOMpj1D3cHewNrJTo8deIijVRfH+/uM=
=Jevn
-----END PGP SIGNATURE-----

--dfmC41YZQlborXoK--
