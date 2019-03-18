Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE43C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 05:18:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC4A20872
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 05:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KUqA6+L3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC4A20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44N4Fz2GrCzDqKV
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 16:18:15 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44N48g0K5PzDqJl
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 16:13:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="KUqA6+L3"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44N48f62YKz9sDX; Mon, 18 Mar 2019 16:13:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552886018;
 bh=wDw/02/7GDhA2b96PcdMy2E9xpE966hHzzt3orWQN+g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KUqA6+L3ph7DUC98F23Z8R8efVupGBBABlYfxq9u77EneUXYzhaHiXXw0Pxr1krD3
 hY6iJaT8nqserqG8DI3VpErv+/WQzOtdd7oZ6x/2QaRVtZGO5RW+cu7ycBphlTUsTv
 nbChrWgniSeyPmCkSbcxSd7Px2xNtwuHqYL2WUyg=
Date: Mon, 18 Mar 2019 14:31:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 09/17] KVM: PPC: Book3S HV: XIVE: add a control to
 dirty the XIVE EQ pages
Message-ID: <20190318033110.GK6874@umbus.fritz.box>
References: <20190315120609.25910-1-clg@kaod.org>
 <20190315120609.25910-10-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="sdEQJo40s7ofW8iR"
Content-Disposition: inline
In-Reply-To: <20190315120609.25910-10-clg@kaod.org>
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


--sdEQJo40s7ofW8iR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2019 at 01:06:01PM +0100, C=E9dric Le Goater wrote:
> When migration of a VM is initiated, a first copy of the RAM is
> transferred to the destination before the VM is stopped, but there is
> no guarantee that the EQ pages in which the event notifications are
> queued have not been modified.
>=20
> To make sure migration will capture a consistent memory state, the
> XIVE device should perform a XIVE quiesce sequence to stop the flow of
> event notifications and stabilize the EQs. This is the purpose of the
> KVM_DEV_XIVE_EQ_SYNC control which will also marks the EQ pages dirty
> to force their transfer.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
>  Changes since v2 :
>=20
>  - Extra comments
>  - fixed locking on source block
>=20
>  arch/powerpc/include/uapi/asm/kvm.h        |  1 +
>  arch/powerpc/kvm/book3s_xive_native.c      | 85 ++++++++++++++++++++++
>  Documentation/virtual/kvm/devices/xive.txt | 29 ++++++++
>  3 files changed, 115 insertions(+)
>=20
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index fc9211dbfec8..caf52be89494 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -678,6 +678,7 @@ struct kvm_ppc_cpu_char {
>  /* POWER9 XIVE Native Interrupt Controller */
>  #define KVM_DEV_XIVE_GRP_CTRL		1
>  #define   KVM_DEV_XIVE_RESET		1
> +#define   KVM_DEV_XIVE_EQ_SYNC		2
>  #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source identifier */
>  #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source identifier */
>  #define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit EQ identifier */
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index 26ac3c505cd2..ea091c0a8fb6 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -669,6 +669,88 @@ static int kvmppc_xive_reset(struct kvmppc_xive *xiv=
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
> +
> +		/*
> +		 * The struct kvmppc_xive_irq_state reflects the state
> +		 * of the EAS configuration and not the state of the
> +		 * source. The source is masked setting the PQ bits to
> +		 * '-Q', which is what is being done before calling
> +		 * the KVM_DEV_XIVE_EQ_SYNC control.
> +		 *
> +		 * If a source EAS is configured, OPAL syncs the XIVE
> +		 * IC of the source and the XIVE IC of the previous
> +		 * target if any.
> +		 *
> +		 * So it should be fine ignoring MASKED sources as
> +		 * they have been synced already.
> +		 */
> +		if (state->act_priority =3D=3D MASKED)
> +			continue;
> +
> +		kvmppc_xive_select_irq(state, &hw_num, &xd);
> +		xive_native_sync_source(hw_num);
> +		xive_native_sync_queue(hw_num);
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
> +	mutex_lock(&kvm->lock);
> +	for (i =3D 0; i <=3D xive->max_sbid; i++) {
> +		struct kvmppc_xive_src_block *sb =3D xive->src_blocks[i];
> +
> +		if (sb) {
> +			arch_spin_lock(&sb->lock);
> +			kvmppc_xive_native_sync_sources(sb);
> +			arch_spin_unlock(&sb->lock);
> +		}
> +	}
> +
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
> @@ -679,6 +761,8 @@ static int kvmppc_xive_native_set_attr(struct kvm_dev=
ice *dev,
>  		switch (attr->attr) {
>  		case KVM_DEV_XIVE_RESET:
>  			return kvmppc_xive_reset(xive);
> +		case KVM_DEV_XIVE_EQ_SYNC:
> +			return kvmppc_xive_native_eq_sync(xive);
>  		}
>  		break;
>  	case KVM_DEV_XIVE_GRP_SOURCE:
> @@ -717,6 +801,7 @@ static int kvmppc_xive_native_has_attr(struct kvm_dev=
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
> index 055aed0c2abb..e6a984592189 100644
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
> @@ -97,3 +103,26 @@ the legacy interrupt mode, referred as XICS (POWER7/8=
).
>    Errors:
>      -ENOENT: Unknown source number
>      -EINVAL: Not initialized source number
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

--sdEQJo40s7ofW8iR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyPEP4ACgkQbDjKyiDZ
s5IEKw//Yx4yJHDNrLC5wDyiu9PjJnk/CUwCd3L1h1FyNW06jAqWp70w22MZQrts
ITVgsy+uPZNSNCC1VGneE03hUo/+4YFeEuJQVuV4VL1Q7FrKt2AdbiLMeit3IBtZ
NbFjXLrDqtuqkuFTlFKgdeV011GTiUscXROtRUJMWoJZ7bU3v/ZL1184n6U1u+Yq
7qzUcT9r6sn7lnWU3CWjFrrFNbCdW+ACmLxqLdKq7+VbbSNEl99kVm/4ShCe9RAE
0f29neRhZdKGHco6LJpvSUHB/oI5xL2XVjgPebJOW3I6PdNsntH1/nA6AkdGPdjw
2hrBoVFRgeKC3PCvTUUotuFjnCHV8lFvrUSlwqhvk4PeZAYKSNTyJcWZ3o1aawVf
LvpB1YqyqhaZy8MnKreoRwrmHTJBaO4ozANkWuIfJnFAbTUDwFKkS1hf7ldZ9NK/
aypG57QG6ExMG2vcBd1j2vlAXHrewvR1Xa0LWFm3rHsE7v5U4FROj4HE0R9e8uMZ
i/BE3ZVYfZdXAzQrA40BRlj5aOvxOeU3VcC2Wqx4uYfdDP92TVbw1BpF5Bq0zDGc
O1CjhlpIMGKLF5TwiZ0OPPaSvhg5KZiRAkP6vPJCO3c4wEYnvhyQHSWQAXsyqTFQ
IBIWxrDF6HYZKRQEp++5ruG7H55Gzv9QwvGWaKxnNlNfaG0Gwo8=
=ePLL
-----END PGP SIGNATURE-----

--sdEQJo40s7ofW8iR--
