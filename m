Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8461DC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 05:15:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE77F20872
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 05:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="AQQJnpZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE77F20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44N4Bd3J6szDqJs
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 16:15:21 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44N48f5rKDzDqJ8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 16:13:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="AQQJnpZE"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44N48f3jQ8z9sBr; Mon, 18 Mar 2019 16:13:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552886018;
 bh=vuX63Jt5KGhP10HFEgYc+RinXxwQ03BDeHxl9LG0HJo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AQQJnpZEUJk5Vu6m24lijnldgSS9s44A3tAa/kZ6moPEzvdlkJTtya5DoMv6bwbAL
 +ydhRozmHLsg739GNBe8rVlQCcI28ZYcJNxuzUP3t4hyDK0bKmc3wizqcyBnU5QMp6
 jhS7gyRmc/dMgaaqkrCgi177kGV9+yvpu43e9/wc=
Date: Mon, 18 Mar 2019 14:25:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 07/17] KVM: PPC: Book3S HV: XIVE: add a global reset
 control
Message-ID: <20190318032533.GI6874@umbus.fritz.box>
References: <20190315120609.25910-1-clg@kaod.org>
 <20190315120609.25910-8-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="itqfrb9Qq3wY07cp"
Content-Disposition: inline
In-Reply-To: <20190315120609.25910-8-clg@kaod.org>
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


--itqfrb9Qq3wY07cp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2019 at 01:05:59PM +0100, C=E9dric Le Goater wrote:
> This control is to be used by the H_INT_RESET hcall from QEMU. Its
> purpose is to clear all configuration of the sources and EQs. This is
> necessary in case of a kexec (for a kdump kernel for instance) to make
> sure that no remaining configuration is left from the previous boot
> setup so that the new kernel can start safely from a clean state.
>=20
> The queue 7 is ignored when the XIVE device is configured to run in
> single escalation mode. Prio 7 is used by escalations.
>=20
> The XIVE VP is kept enabled as the vCPU is still active and connected
> to the XIVE device.
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
>  arch/powerpc/kvm/book3s_xive_native.c      | 85 ++++++++++++++++++++++
>  Documentation/virtual/kvm/devices/xive.txt |  5 ++
>  3 files changed, 91 insertions(+)
>=20
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index 1cd728c87d7c..95e82ab57c03 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -677,6 +677,7 @@ struct kvm_ppc_cpu_char {
> =20
>  /* POWER9 XIVE Native Interrupt Controller */
>  #define KVM_DEV_XIVE_GRP_CTRL		1
> +#define   KVM_DEV_XIVE_RESET		1
>  #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source identifier */
>  #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source identifier */
>  #define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit EQ identifier */
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index 42e824658a30..3385c336fd89 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -560,6 +560,83 @@ static int kvmppc_xive_native_get_queue_config(struc=
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
> +			continue;
> +
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
> +		struct kvmppc_xive_src_block *sb =3D xive->src_blocks[i];
> +
> +		if (sb) {
> +			arch_spin_lock(&sb->lock);
> +			kvmppc_xive_reset_sources(sb);
> +			arch_spin_unlock(&sb->lock);
> +		}
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
> @@ -567,6 +644,10 @@ static int kvmppc_xive_native_set_attr(struct kvm_de=
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
> @@ -599,6 +680,10 @@ static int kvmppc_xive_native_has_attr(struct kvm_de=
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
> index a4de64f6e79c..e1893d303ab7 100644
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

--itqfrb9Qq3wY07cp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyPD6wACgkQbDjKyiDZ
s5JayQ/9EA4M1ZGfWtRMBxuX6SDwMHLdzzst3nrifZKnQh+Z8MHwiHZsV7e6eaYu
c1kMZ8xuo9jbKW3Qd5iJhvUOdG8AJfprlcNz2lyb6SX//RBHpKRQvyIPEz9jkv7d
qp0BBKMjUnCGeqC6TkSavpR5StfKSluOUp+KsP4wK/sPgf72H/FzF+U+O0usFHKH
9dmbFCYnIqNGpoopiTeZjL9lnTDEOSKwaQU+H9fVsObmq2bL8UBs+hs4Kn1GaBFl
o/BxGJLcNCvSEpC4BAokjyVESLVIKr4XPmM7G4rvgaxYbkMTFBcTgGGLZE8VmrDC
WHGoEAM+ZZuehGaOs77T30egIt8PtkP+mv3Lf5W5TVEPC4DcRAYUHWfZrMIKPCAP
bwMkdRqO8g0DOo7Jkm2iUg/0rBxkAsu3kYoQk4VxRihSXKU+KlVW4Un3kketC86A
apj+TFgg2GAEkWScGy2a7+DcPmemfxqeTCcr9lhxlsr8e/PUlKTv5bLxXyZ8MTLt
KOD+bLm8eyLp8W+sYTvccDnWL88tb5wDczf871iXUBmhVHonxcIet80AQw8ynHn4
BnsdYREx19bltFMl7xNLLi4CFlrz9byuxuqHM0xytSA85Nyi38T9itI+uPJnhE7P
I1FnJJG1g0nlVjfIxn6vjxoTdsXwddtsGIZzuuQVUlII8DEhgKo=
=Bb43
-----END PGP SIGNATURE-----

--itqfrb9Qq3wY07cp--
