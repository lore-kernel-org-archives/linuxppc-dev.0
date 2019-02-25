Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A314AC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 04:08:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F1B2084D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 04:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bXC33S+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F1B2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4477hw3fN7zDqS3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 15:08:16 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4477Rl4DLCzDqHG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 14:56:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="bXC33S+0"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4477Rl34rGz9sN8; Mon, 25 Feb 2019 14:56:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1551067011;
 bh=Q0DyX/D4zbE6qzIEHsUxJXE11LLsIsrZDEAnN+9B+Q0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bXC33S+0M1/TXH4QuCoghqaOHevSh6TNYSY7p00en2W++JF53CXpi3SPMqrr66ZZu
 p5d/muosx7opN9hpvrgxkZqHcs4j9pj/lflEYj4F6+gSzUx5oIiPyDr9Mc1DQNGwZF
 gzFVOZI496D9J+/bN44LVF7815z3ihqsnqq0JnPM=
Date: Mon, 25 Feb 2019 13:43:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 07/16] KVM: PPC: Book3S HV: XIVE: add a global reset
 control
Message-ID: <20190225024351.GK7668@umbus.fritz.box>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-8-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Rex5+51txc1ort/q"
Content-Disposition: inline
In-Reply-To: <20190222112840.25000-8-clg@kaod.org>
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


--Rex5+51txc1ort/q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 12:28:31PM +0100, C=E9dric Le Goater wrote:
> This control is to be used by the H_INT_RESET hcall from QEMU. Its
> purpose is to clear all configuration of the sources and EQs. This is
> necessary in case of a kexec (for a kdump kernel for instance) to make
> sure that no remaining configuration is left from the previous boot
> setup so that the new kernel can start safely from a clean state.
>=20
> The queue 7 is ignored when the KVM device is configured to run in
> single escalation mode. Prio 7 is used by escalations.
>=20
> The XIVE VP is kept enabled as the vCPU is still active and connected
> to the XIVE device.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/include/uapi/asm/kvm.h        |  1 +
>  arch/powerpc/kvm/book3s_xive_native.c      | 82 ++++++++++++++++++++++
>  Documentation/virtual/kvm/devices/xive.txt |  5 ++
>  3 files changed, 88 insertions(+)
>=20
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index 177e43f3edaf..7ae8cb22af7d 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -677,6 +677,7 @@ struct kvm_ppc_cpu_char {
> =20
>  /* POWER9 XIVE Native Interrupt Controller */
>  #define KVM_DEV_XIVE_GRP_CTRL		1
> +#define   KVM_DEV_XIVE_RESET		1
>  #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source attributes */
>  #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source attributes */
>  #define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit eq attributes */
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index 34a35bcf550c..bb3e121c918a 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -536,6 +536,80 @@ static int kvmppc_xive_native_get_queue_config(struc=
t kvmppc_xive *xive,
>  	return 0;
>  }
> =20
> +static void kvmppc_xive_reset_sources(struct kvmppc_xive_src_block *sb)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < KVMPPC_XICS_IRQ_PER_ICS; i++) {
> +		struct kvmppc_xive_irq_state *state =3D &sb->irq_state[i];
> +
> +		if (!state->valid)
> +			continue;
> +
> +		if (state->act_priority =3D=3D MASKED)

You're checking some things in state before you take the lock.  Could
this race?

> +			continue;
> +
> +		arch_spin_lock(&sb->lock);
> +		state->eisn =3D 0;
> +		state->act_server =3D 0;
> +		state->act_priority =3D MASKED;
> +		xive_vm_esb_load(&state->ipi_data, XIVE_ESB_SET_PQ_01);
> +		xive_native_configure_irq(state->ipi_number, 0, MASKED, 0);
> +		if (state->pt_number) {
> +			xive_vm_esb_load(state->pt_data, XIVE_ESB_SET_PQ_01);
> +			xive_native_configure_irq(state->pt_number,
> +						  0, MASKED, 0);
> +		}
> +		arch_spin_unlock(&sb->lock);
> +	}
> +}
> +
> +static int kvmppc_xive_reset(struct kvmppc_xive *xive)
> +{
> +	struct kvm *kvm =3D xive->kvm;
> +	struct kvm_vcpu *vcpu;
> +	unsigned int i;
> +
> +	pr_devel("%s\n", __func__);
> +
> +	mutex_lock(&kvm->lock);
> +
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> +		unsigned int prio;
> +
> +		if (!xc)
> +			continue;
> +
> +		kvmppc_xive_disable_vcpu_interrupts(vcpu);
> +
> +		for (prio =3D 0; prio < KVMPPC_XIVE_Q_COUNT; prio++) {
> +
> +			/* Single escalation, no queue 7 */
> +			if (prio =3D=3D 7 && xive->single_escalation)
> +				break;
> +
> +			if (xc->esc_virq[prio]) {
> +				free_irq(xc->esc_virq[prio], vcpu);
> +				irq_dispose_mapping(xc->esc_virq[prio]);
> +				kfree(xc->esc_virq_names[prio]);
> +				xc->esc_virq[prio] =3D 0;
> +			}
> +
> +			kvmppc_xive_native_cleanup_queue(vcpu, prio);
> +		}
> +	}
> +
> +	for (i =3D 0; i <=3D xive->max_sbid; i++) {
> +		if (xive->src_blocks[i])
> +			kvmppc_xive_reset_sources(xive->src_blocks[i]);
> +	}
> +
> +	mutex_unlock(&kvm->lock);
> +
> +	return 0;
> +}
> +
>  static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>  				       struct kvm_device_attr *attr)
>  {
> @@ -543,6 +617,10 @@ static int kvmppc_xive_native_set_attr(struct kvm_de=
vice *dev,
> =20
>  	switch (attr->group) {
>  	case KVM_DEV_XIVE_GRP_CTRL:
> +		switch (attr->attr) {
> +		case KVM_DEV_XIVE_RESET:
> +			return kvmppc_xive_reset(xive);
> +		}
>  		break;
>  	case KVM_DEV_XIVE_GRP_SOURCE:
>  		return kvmppc_xive_native_set_source(xive, attr->attr,
> @@ -575,6 +653,10 @@ static int kvmppc_xive_native_has_attr(struct kvm_de=
vice *dev,
>  {
>  	switch (attr->group) {
>  	case KVM_DEV_XIVE_GRP_CTRL:
> +		switch (attr->attr) {
> +		case KVM_DEV_XIVE_RESET:
> +			return 0;
> +		}
>  		break;
>  	case KVM_DEV_XIVE_GRP_SOURCE:
>  	case KVM_DEV_XIVE_GRP_SOURCE_CONFIG:
> diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/v=
irtual/kvm/devices/xive.txt
> index c0b5d9bd43fb..f1d007f485a9 100644
> --- a/Documentation/virtual/kvm/devices/xive.txt
> +++ b/Documentation/virtual/kvm/devices/xive.txt
> @@ -17,6 +17,11 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
> =20
>    1. KVM_DEV_XIVE_GRP_CTRL
>    Provides global controls on the device
> +  Attributes:
> +    1.1 KVM_DEV_XIVE_RESET (write only)
> +    Resets the interrupt controller configuration for sources and event
> +    queues. To be used by kexec and kdump.
> +    Errors: none
> =20
>    2. KVM_DEV_XIVE_GRP_SOURCE (write only)
>    Initializes a new source in the XIVE device and mask it.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Rex5+51txc1ort/q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxzVmcACgkQbDjKyiDZ
s5LK4A/9Gc87x1OLYBXpzDW/E/p52x5SHD/4ivnG+HtCdSPWJXEMJrzzAbZHa0g4
ygNLOkhWfbyNBlpY57dY/MkPsLS2mj5RhOX+6NEsbMdvX1NzU9rHjUtkUS1M7LCy
ErJ6kq9uW0EqrBoAU4go9dqIv4Z8R7eh00/jdIKsIKETHHGgUVkOndjFmJzjkah+
ZTkuoYaVw5X/TD7vreYOr1hLZTDN8jt7TDQoa7318ZRyXh4sIi0Qc6Ctt8GimJE3
CZXTqIJRu8P73YrIVa4wNc78I+I6BALqeS49dvtq7nKz76IBKSxldCsBwCYwXPfL
WWgpV0PZp+jTlOz7HNHAOylJDzKKBJlGtC7RzxS8FXPgOQM+BMEa87CgO4QRUUlS
hWywqYUmDCeIbeeGGM8ixnKTsugY4C9OsPtDtfniyRyG93dvQ+QueIWOEpz6/jrC
tiCLdDR4tLyPTajq/lCb3DVeQgqZm9BpBvxAiGNVpz3BOrlJWPS+qt7kQUNtFJw5
BaAp9pfwAzjw36bC01M4V/ak+YO3UvWiiTEZigDBWBp/ib9hktE9ZAHmA4CJjgI0
Mwk3JqqCzdh5nZ6S7xYm+mjGICnLQz5RfdyLGpkCQiwqBfaloFzt/yKCwQRv4EQt
VGZASa+4fr/uihv1o0DIfee193ji2eN6uGb0xyy43yvqhxETnkM=
=YmDK
-----END PGP SIGNATURE-----

--Rex5+51txc1ort/q--
