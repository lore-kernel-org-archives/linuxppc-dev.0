Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5497AC282D7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:25:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C236720820
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KnV/VMS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C236720820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tHkR5n1YzDq5Z
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 17:25:03 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tHSK64RgzDqGc
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 17:12:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="KnV/VMS8"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43tHSK2lJHz9sN6; Mon,  4 Feb 2019 17:12:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549260769;
 bh=3QOLjCbJ4USjrFAVvz9TBc9JgkPjwJBQIrl4dxsYlaE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KnV/VMS8a/3Mrranpkhz14gU4T/mCavCYMmpfK8N45jygcWAPOMG1JGRdBqeHh507
 ht31pfWX4+e1uyeoTsJJIpTi+/TunZCupabQBbaWRMd1RF75b9p/rx4NQcM5A6dDVS
 8Iuc9rQsCSikoCGSGAQZetq5j547hSMr7iiFrFvg=
Date: Mon, 4 Feb 2019 16:17:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 13/19] KVM: PPC: Book3S HV: add a SYNC control for the
 XIVE native migration
Message-ID: <20190204051739.GF1927@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-14-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mrJd9p1Ce66CJMxE"
Content-Disposition: inline
In-Reply-To: <20190107184331.8429-14-clg@kaod.org>
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


--mrJd9p1Ce66CJMxE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:43:25PM +0100, C=E9dric Le Goater wrote:
> When migration of a VM is initiated, a first copy of the RAM is
> transferred to the destination before the VM is stopped. At that time,
> QEMU needs to perform a XIVE quiesce sequence to stop the flow of
> event notifications and stabilize the EQs. The sources are masked and
> the XIVE IC is synced with the KVM ioctl KVM_DEV_XIVE_GRP_SYNC.
>

Don't you also need to make sure the guests queue pages are marked
dirty here, in case they were already migrated?

> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/include/uapi/asm/kvm.h   |  1 +
>  arch/powerpc/kvm/book3s_xive_native.c | 32 +++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
>=20
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index 6fc9660c5aec..f3b859223b80 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -681,6 +681,7 @@ struct kvm_ppc_cpu_char {
>  #define   KVM_DEV_XIVE_GET_TIMA_FD	2
>  #define   KVM_DEV_XIVE_VC_BASE		3
>  #define KVM_DEV_XIVE_GRP_SOURCES	2	/* 64-bit source attributes */
> +#define KVM_DEV_XIVE_GRP_SYNC		3	/* 64-bit source attributes */
> =20
>  /* Layout of 64-bit XIVE source attribute values */
>  #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index 4ca75aade069..a8052867afc1 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -459,6 +459,35 @@ static int kvmppc_xive_native_set_source(struct kvmp=
pc_xive *xive, long irq,
>  	return 0;
>  }
> =20
> +static int kvmppc_xive_native_sync(struct kvmppc_xive *xive, long irq, u=
64 addr)
> +{
> +	struct kvmppc_xive_src_block *sb;
> +	struct kvmppc_xive_irq_state *state;
> +	struct xive_irq_data *xd;
> +	u32 hw_num;
> +	u16 src;
> +
> +	pr_devel("%s irq=3D0x%lx\n", __func__, irq);
> +
> +	sb =3D kvmppc_xive_find_source(xive, irq, &src);
> +	if (!sb)
> +		return -ENOENT;
> +
> +	state =3D &sb->irq_state[src];
> +
> +	if (!state->valid)
> +		return -ENOENT;
> +
> +	arch_spin_lock(&sb->lock);
> +
> +	kvmppc_xive_select_irq(state, &hw_num, &xd);
> +	xive_native_sync_source(hw_num);
> +	xive_native_sync_queue(hw_num);
> +
> +	arch_spin_unlock(&sb->lock);
> +	return 0;
> +}
> +
>  static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>  				       struct kvm_device_attr *attr)
>  {
> @@ -474,6 +503,8 @@ static int kvmppc_xive_native_set_attr(struct kvm_dev=
ice *dev,
>  	case KVM_DEV_XIVE_GRP_SOURCES:
>  		return kvmppc_xive_native_set_source(xive, attr->attr,
>  						     attr->addr);
> +	case KVM_DEV_XIVE_GRP_SYNC:
> +		return kvmppc_xive_native_sync(xive, attr->attr, attr->addr);
>  	}
>  	return -ENXIO;
>  }
> @@ -511,6 +542,7 @@ static int kvmppc_xive_native_has_attr(struct kvm_dev=
ice *dev,
>  		}
>  		break;
>  	case KVM_DEV_XIVE_GRP_SOURCES:
> +	case KVM_DEV_XIVE_GRP_SYNC:
>  		if (attr->attr >=3D KVMPPC_XIVE_FIRST_IRQ &&
>  		    attr->attr < KVMPPC_XIVE_NR_IRQS)
>  			return 0;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--mrJd9p1Ce66CJMxE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxXyvMACgkQbDjKyiDZ
s5J1dRAAhddqLxbQkHRNL/bXlRecEGLkvDyG5ayWbhlI1VHU0NUtugAMM1/m2WRO
vbM2GYkmVPp0uX/9jq+xgl6dE/xhTz8GdQeKvkBZFZzmoVZCOxsUGCgGzk4kxNLY
h9oQY0oJj5iJALC3XW6E5EEeol4G5cnyHv7N8gsoSwkSzK5PbiFgkc+5WelgotgO
GLsSujTyi24vX9QJSEPAB1QXYUfyInrXs4xca3f4s/YulK7a3+T1kk0Vlv3JpRbP
Blkxy3E1SLh1rLTk+ZI1r+p2VRKFr/o9hRlCmWudraU/uUTlyIMR0Oj6dUFEOfNW
8G2ZUFculV58ud7EteFD7Wc6VTLim8paCfIOWRAQ+fg5qkv7o+hK1J7AO2JsWe5S
rtlSNXJ9Ce52STvtVJZwi2oudIa/LFctpMWoYTub6j1wHJd0H+R8C0w/QY+V1Zk1
s8nrjKWqeFBVcyy0zRF1ytXIQDqsxQqGnlSwPdv0O20E/afhxUkTL2s4X3OP9cLY
nbiFq7kRyYnSxPL4o+7dCydPz72R1TW++wP74QleaeGysL09Y0d/buawLwXeRBIY
Dg/gkL8HqtOr/yj1AuaeRvnpKb1Et46e6WFswR2dqAju71YsIKj1Nijvq72DrBnI
AqPjk1hBZZ8GXiuVtJqIa/arEoK0uoXxGkUb9HEpBGCWdwgnKrc=
=kyra
-----END PGP SIGNATURE-----

--mrJd9p1Ce66CJMxE--
