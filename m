Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC82BC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 04:11:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B8BD2084D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 04:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CzHCXh4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B8BD2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4477mK1rsKzDq7w
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 15:11:13 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4477Rm0FfJzDqFv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 14:56:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="CzHCXh4t"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4477Rl5LCjz9sNF; Mon, 25 Feb 2019 14:56:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1551067011;
 bh=adD19x+9TM+OKBwxkLsUvBrViBM+ybZbGyOOIozzkgs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CzHCXh4tBX8obnqeWXld77UvjmWBcOAnbpUN28jwk6uJZwjWS1EnJ3Jevx+H1BbC2
 7zgr+YsLPYkQk4BkA6R5jG9adTYiddZv/WfqUPD9J438LYq5SGQ9W7qmnGf1Vpbim1
 LWHysidmJZqOQMkN7Zlqd9F7K0uMqEyRGesdlQ4c=
Date: Mon, 25 Feb 2019 13:53:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 09/16] KVM: PPC: Book3S HV: XIVE: add a control to
 dirty the XIVE EQ pages
Message-ID: <20190225025329.GM7668@umbus.fritz.box>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-10-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sMkrXc3gAYLRVOjR"
Content-Disposition: inline
In-Reply-To: <20190222112840.25000-10-clg@kaod.org>
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


--sMkrXc3gAYLRVOjR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 12:28:33PM +0100, C=E9dric Le Goater wrote:
> When migration of a VM is initiated, a first copy of the RAM is
> transferred to the destination before the VM is stopped, but there is
> no guarantee that the EQ pages in which the event notification are
> queued have not been modified.
>=20
> To make sure migration will capture a consistent memory state, the
> XIVE device should perform a XIVE quiesce sequence to stop the flow of
> event notifications and stabilize the EQs. This is the purpose of the
> KVM_DEV_XIVE_EQ_SYNC control which will also marks the EQ pages dirty
> to force their transfer.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/include/uapi/asm/kvm.h        |  1 +
>  arch/powerpc/kvm/book3s_xive_native.c      | 67 ++++++++++++++++++++++
>  Documentation/virtual/kvm/devices/xive.txt | 29 ++++++++++
>  3 files changed, 97 insertions(+)
>=20
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index 289c504b7c1d..cd78ad1020fe 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -678,6 +678,7 @@ struct kvm_ppc_cpu_char {
>  /* POWER9 XIVE Native Interrupt Controller */
>  #define KVM_DEV_XIVE_GRP_CTRL		1
>  #define   KVM_DEV_XIVE_RESET		1
> +#define   KVM_DEV_XIVE_EQ_SYNC		2
>  #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source attributes */
>  #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source attributes */
>  #define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit eq attributes */
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index dd2a9d411fe7..3debc876d5a0 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -640,6 +640,70 @@ static int kvmppc_xive_reset(struct kvmppc_xive *xiv=
e)
>  	return 0;
>  }
> =20
> +static void kvmppc_xive_native_sync_sources(struct kvmppc_xive_src_block=
 *sb)
> +{
> +	int j;
> +
> +	for (j =3D 0; j < KVMPPC_XICS_IRQ_PER_ICS; j++) {
> +		struct kvmppc_xive_irq_state *state =3D &sb->irq_state[j];
> +		struct xive_irq_data *xd;
> +		u32 hw_num;
> +
> +		if (!state->valid)
> +			continue;
> +		if (state->act_priority =3D=3D MASKED)

Is this correct?  If you masked an irq, then immediately did a sync,
couldn't there still be some of the irqs in flight?  I thought the
reason we needed a sync was that masking and other such operations
_didn't_ implicitly synchronize.

> +			continue;
> +
> +		arch_spin_lock(&sb->lock);
> +		kvmppc_xive_select_irq(state, &hw_num, &xd);
> +		xive_native_sync_source(hw_num);
> +		xive_native_sync_queue(hw_num);
> +		arch_spin_unlock(&sb->lock);
> +	}
> +}
> +
> +static int kvmppc_xive_native_vcpu_eq_sync(struct kvm_vcpu *vcpu)
> +{
> +	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> +	unsigned int prio;
> +
> +	if (!xc)
> +		return -ENOENT;
> +
> +	for (prio =3D 0; prio < KVMPPC_XIVE_Q_COUNT; prio++) {
> +		struct xive_q *q =3D &xc->queues[prio];
> +
> +		if (!q->qpage)
> +			continue;
> +
> +		/* Mark EQ page dirty for migration */
> +		mark_page_dirty(vcpu->kvm, gpa_to_gfn(q->guest_qpage));
> +	}
> +	return 0;
> +}
> +
> +static int kvmppc_xive_native_eq_sync(struct kvmppc_xive *xive)
> +{
> +	struct kvm *kvm =3D xive->kvm;
> +	struct kvm_vcpu *vcpu;
> +	unsigned int i;
> +
> +	pr_devel("%s\n", __func__);
> +
> +	for (i =3D 0; i <=3D xive->max_sbid; i++) {
> +		if (xive->src_blocks[i])
> +			kvmppc_xive_native_sync_sources(xive->src_blocks[i]);
> +	}
> +
> +	mutex_lock(&kvm->lock);
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		kvmppc_xive_native_vcpu_eq_sync(vcpu);
> +	}
> +	mutex_unlock(&kvm->lock);
> +
> +	return 0;
> +}
> +
>  static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>  				       struct kvm_device_attr *attr)
>  {
> @@ -650,6 +714,8 @@ static int kvmppc_xive_native_set_attr(struct kvm_dev=
ice *dev,
>  		switch (attr->attr) {
>  		case KVM_DEV_XIVE_RESET:
>  			return kvmppc_xive_reset(xive);
> +		case KVM_DEV_XIVE_EQ_SYNC:
> +			return kvmppc_xive_native_eq_sync(xive);
>  		}
>  		break;
>  	case KVM_DEV_XIVE_GRP_SOURCE:
> @@ -688,6 +754,7 @@ static int kvmppc_xive_native_has_attr(struct kvm_dev=
ice *dev,
>  	case KVM_DEV_XIVE_GRP_CTRL:
>  		switch (attr->attr) {
>  		case KVM_DEV_XIVE_RESET:
> +		case KVM_DEV_XIVE_EQ_SYNC:
>  			return 0;
>  		}
>  		break;
> diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/v=
irtual/kvm/devices/xive.txt
> index 267634eae9e0..a26be635cff9 100644
> --- a/Documentation/virtual/kvm/devices/xive.txt
> +++ b/Documentation/virtual/kvm/devices/xive.txt
> @@ -23,6 +23,12 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
>      queues. To be used by kexec and kdump.
>      Errors: none
> =20
> +    1.2 KVM_DEV_XIVE_EQ_SYNC (write only)
> +    Sync all the sources and queues and mark the EQ pages dirty. This
> +    to make sure that a consistent memory state is captured when
> +    migrating the VM.
> +    Errors: none
> +
>    2. KVM_DEV_XIVE_GRP_SOURCE (write only)
>    Initializes a new source in the XIVE device and mask it.
>    Attributes:
> @@ -95,3 +101,26 @@ the legacy interrupt mode, referred as XICS (POWER7/8=
).
>      -ENOENT: Unknown source number
>      -EINVAL: Not initialized source number, invalid priority or
>               invalid CPU number.
> +
> +* Migration:
> +
> +  Saving the state of a VM using the XIVE native exploitation mode
> +  should follow a specific sequence. When the VM is stopped :
> +
> +  1. Mask all sources (PQ=3D01) to stop the flow of events.
> +
> +  2. Sync the XIVE device with the KVM control KVM_DEV_XIVE_EQ_SYNC to
> +  flush any in-flight event notification and to stabilize the EQs. At
> +  this stage, the EQ pages are marked dirty to make sure they are
> +  transferred in the migration sequence.
> +
> +  3. Capture the state of the source targeting, the EQs configuration
> +  and the state of thread interrupt context registers.
> +
> +  Restore is similar :
> +
> +  1. Restore the EQ configuration. As targeting depends on it.
> +  2. Restore targeting
> +  3. Restore the thread interrupt contexts
> +  4. Restore the source states
> +  5. Let the vCPU run

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sMkrXc3gAYLRVOjR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxzWKkACgkQbDjKyiDZ
s5Lr0A//fUXC+7/R0iXsUiNrjC7POUBKrtPxZ/D2ZGVtYj7gpgNjig95oQrRZZxf
EE70xR0h0Z5TfJ8kBQB70uwlSWKh87Am9AQs1mrj64JGWKKy6kx1YEZ5ro8JomvX
xEogZTVFeqX10n/E+54+tkPJgKBEW+dGNDunhubCPwmzChSzTsfHZJDAqtxxV4vz
PluvZ4WrT1ltWDP8rnBSYBXGL0210A1UJ8an277bfPeBUVl0Gswp4SJumkLJQ7Ry
wF/XASSFQQDU3SbDEx/9UMIKr8vgV9SWjiazyRsslBNnuUYMS0mLclIKfXhGB9ow
8xLkNe1CEdcPjqcnmqv4KEKXAjOSY37kKbMqDH95nL4YjICXkgjCjuoFlHC1LoV4
zXFExesRv5CQqzUNQNSo8XQn0rM9hzStK5gNoTKlBPKYUyK05i5ZL3N5SJTkBgAg
GWR4sFSfSuHAitHR9+CHN15VSEvdaIWQrWA1g9ZiHg+d1Bhczo1dWOx7nPJ699VU
7L3qCHYZCsXL+YOefPWl+sCM7Nl0a9eyyhrBUPxoX8iIAZ07fMcgF4I6kqmRyYJQ
nu5XSszY1r0l9yfCH5WUKwNLZZWzy+wS//RVuiaUv8JBx/h2JrmuXrgSd2h5Av6C
9elM4JSGsd18VfTBVmIo8gy8WPotFlkO/9ipjNuOd0ByPaVPbsU=
=3Fxf
-----END PGP SIGNATURE-----

--sMkrXc3gAYLRVOjR--
