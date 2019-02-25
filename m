Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9093C4360F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 04:02:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 282E12084D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 04:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YAFahAzi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282E12084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4477Ys6wQnzDq5j
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 15:02:09 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4477Rl0dVzzDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 14:56:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="YAFahAzi"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4477Rk5p7nz9sMr; Mon, 25 Feb 2019 14:56:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1551067010;
 bh=keRTQMDav85zH3K0KQtIjCK9XKtASUqc3H9nTkXtaTk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YAFahAzi05YsO0WKDAAMpLwbWuIgeInYhgY82lSP1Hj9hqk1QPFWUenjPok3ej36o
 r6vmskTij2Y+SVCi/3526b7KYHcXDGynC1Lif2P/DZ1oycNQJdG+n0SoO7T93Mz0LL
 +XG/3ANIRRm+WX7y+8dsVSdEuTi2ttqWGwjzZnNI=
Date: Mon, 25 Feb 2019 13:21:31 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 05/16] KVM: PPC: Book3S HV: XIVE: add a control to
 configure a source
Message-ID: <20190225022131.GI7668@umbus.fritz.box>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-6-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HuXIgs6JvY9hJs5C"
Content-Disposition: inline
In-Reply-To: <20190222112840.25000-6-clg@kaod.org>
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


--HuXIgs6JvY9hJs5C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 12:28:29PM +0100, C=E9dric Le Goater wrote:
> This control will be used by the H_INT_SET_SOURCE_CONFIG hcall from
> QEMU and also to restore the configuration of the source in the KVM
> device.
>=20
> The XIVE internal IRQ structure is extended with the value of the
> Effective Interrupt Source Number. The EISN is the interrupt number
> pushed in the event queue that the guest OS will use to dispatch
> events internally. Caching the EISN value in KVM ease the test when
> checking if a reconfiguration is indeed needed.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/include/uapi/asm/kvm.h        | 11 +++
>  arch/powerpc/kvm/book3s_xive.h             |  4 +
>  arch/powerpc/kvm/book3s_xive.c             |  5 +-
>  arch/powerpc/kvm/book3s_xive_native.c      | 97 ++++++++++++++++++++++
>  Documentation/virtual/kvm/devices/xive.txt | 20 +++++
>  5 files changed, 135 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index a9ad99f2a11b..91899c7f9abd 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -678,9 +678,20 @@ struct kvm_ppc_cpu_char {
>  /* POWER9 XIVE Native Interrupt Controller */
>  #define KVM_DEV_XIVE_GRP_CTRL		1
>  #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source attributes */
> +#define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source attributes */
> =20
>  /* Layout of 64-bit XIVE source attribute values */
>  #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
>  #define KVM_XIVE_LEVEL_ASSERTED		(1ULL << 1)
> =20
> +/* Layout of 64-bit XIVE source configuration attribute values */
> +#define KVM_XIVE_SOURCE_PRIORITY_SHIFT	0
> +#define KVM_XIVE_SOURCE_PRIORITY_MASK	0x7
> +#define KVM_XIVE_SOURCE_SERVER_SHIFT	3
> +#define KVM_XIVE_SOURCE_SERVER_MASK	0xfffffff8ULL
> +#define KVM_XIVE_SOURCE_MASK_SHIFT	32
> +#define KVM_XIVE_SOURCE_MASK_MASK	0x100000000ULL
> +#define KVM_XIVE_SOURCE_EISN_SHIFT	33
> +#define KVM_XIVE_SOURCE_EISN_MASK	0xfffffffe00000000ULL
> +
>  #endif /* __LINUX_KVM_POWERPC_H */
> diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xiv=
e.h
> index f22f2d46d0f0..ab3ac152980d 100644
> --- a/arch/powerpc/kvm/book3s_xive.h
> +++ b/arch/powerpc/kvm/book3s_xive.h
> @@ -61,6 +61,9 @@ struct kvmppc_xive_irq_state {
>  	bool saved_p;
>  	bool saved_q;
>  	u8 saved_scan_prio;
> +
> +	/* Xive native */
> +	u32 eisn;			/* Guest Effective IRQ number */
>  };
> =20
>  /* Select the "right" interrupt (IPI vs. passthrough) */
> @@ -263,6 +266,7 @@ int kvmppc_xive_debug_show_queues(struct seq_file *m,=
 struct kvm_vcpu *vcpu);
>  struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
>  	struct kvmppc_xive *xive, int irq);
>  void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb);
> +int kvmppc_xive_select_target(struct kvm *kvm, u32 *server, u8 prio);
> =20
>  #endif /* CONFIG_KVM_XICS */
>  #endif /* _KVM_PPC_BOOK3S_XICS_H */
> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xiv=
e.c
> index 6f950ecb3592..086da91d7c6e 100644
> --- a/arch/powerpc/kvm/book3s_xive.c
> +++ b/arch/powerpc/kvm/book3s_xive.c
> @@ -342,7 +342,7 @@ static int xive_try_pick_queue(struct kvm_vcpu *vcpu,=
 u8 prio)
>  	return atomic_add_unless(&q->count, 1, max) ? 0 : -EBUSY;
>  }
> =20
> -static int xive_select_target(struct kvm *kvm, u32 *server, u8 prio)
> +int kvmppc_xive_select_target(struct kvm *kvm, u32 *server, u8 prio)
>  {
>  	struct kvm_vcpu *vcpu;
>  	int i, rc;
> @@ -535,7 +535,7 @@ static int xive_target_interrupt(struct kvm *kvm,
>  	 * priority. The count for that new target will have
>  	 * already been incremented.
>  	 */
> -	rc =3D xive_select_target(kvm, &server, prio);
> +	rc =3D kvmppc_xive_select_target(kvm, &server, prio);
> =20
>  	/*
>  	 * We failed to find a target ? Not much we can do
> @@ -1509,6 +1509,7 @@ struct kvmppc_xive_src_block *kvmppc_xive_create_sr=
c_block(
> =20
>  	for (i =3D 0; i < KVMPPC_XICS_IRQ_PER_ICS; i++) {
>  		sb->irq_state[i].number =3D (bid << KVMPPC_XICS_ICS_SHIFT) | i;
> +		sb->irq_state[i].eisn =3D 0;
>  		sb->irq_state[i].guest_priority =3D MASKED;
>  		sb->irq_state[i].saved_priority =3D MASKED;
>  		sb->irq_state[i].act_priority =3D MASKED;
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index a9b2d2d9af99..cb5a5c6e05af 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -248,6 +248,99 @@ static int kvmppc_xive_native_set_source(struct kvmp=
pc_xive *xive, long irq,
>  	return 0;
>  }
> =20
> +static int kvmppc_xive_native_update_source_config(struct kvmppc_xive *x=
ive,
> +					struct kvmppc_xive_src_block *sb,
> +					struct kvmppc_xive_irq_state *state,
> +					u32 server,
> +					u8 priority,
> +					u32 eisn)
> +{
> +	struct kvm *kvm =3D xive->kvm;
> +	u32 hw_num;
> +	int rc =3D 0;
> +
> +	/*
> +	 * TODO: Do we need to safely mask and unmask a source ? can
> +	 * we just let the guest handle the possible races ?
> +	 */
> +	arch_spin_lock(&sb->lock);
> +
> +	if (state->act_server =3D=3D server && state->act_priority =3D=3D prior=
ity &&
> +	    state->eisn =3D=3D eisn)
> +		goto unlock;
> +
> +	pr_devel("new_act_prio=3D%d new_act_server=3D%d act_server=3D%d act_pri=
o=3D%d\n",
> +		 priority, server, state->act_server, state->act_priority);
> +
> +	kvmppc_xive_select_irq(state, &hw_num, NULL);
> +
> +	if (priority !=3D MASKED) {
> +		rc =3D kvmppc_xive_select_target(kvm, &server, priority);
> +		if (rc)
> +			goto unlock;
> +
> +		state->act_priority =3D priority;
> +		state->act_server =3D server;
> +		state->eisn =3D eisn;
> +
> +		rc =3D xive_native_configure_irq(hw_num, xive->vp_base + server,
> +					       priority, eisn);
> +	} else {
> +		state->act_priority =3D MASKED;
> +		state->act_server =3D 0;
> +		state->eisn =3D 0;
> +
> +		rc =3D xive_native_configure_irq(hw_num, 0, MASKED, 0);
> +	}
> +
> +unlock:
> +	arch_spin_unlock(&sb->lock);
> +	return rc;
> +}
> +
> +static int kvmppc_xive_native_set_source_config(struct kvmppc_xive *xive,
> +						long irq, u64 addr)
> +{
> +	struct kvmppc_xive_src_block *sb;
> +	struct kvmppc_xive_irq_state *state;
> +	u64 __user *ubufp =3D (u64 __user *) addr;
> +	u16 src;
> +	u64 kvm_cfg;
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
> +	if (get_user(kvm_cfg, ubufp))
> +		return -EFAULT;
> +
> +	pr_devel("%s irq=3D0x%lx cfg=3D%016llx\n", __func__, irq, kvm_cfg);
> +
> +	priority =3D (kvm_cfg & KVM_XIVE_SOURCE_PRIORITY_MASK) >>
> +		KVM_XIVE_SOURCE_PRIORITY_SHIFT;
> +	server =3D (kvm_cfg & KVM_XIVE_SOURCE_SERVER_MASK) >>
> +		KVM_XIVE_SOURCE_SERVER_SHIFT;
> +	eisn =3D (kvm_cfg & KVM_XIVE_SOURCE_EISN_MASK) >>
> +		KVM_XIVE_SOURCE_EISN_SHIFT;
> +
> +	if (priority !=3D xive_prio_from_guest(priority)) {
> +		pr_err("invalid priority for queue %d for VCPU %d\n",
> +		       priority, server);
> +		return -EINVAL;
> +	}
> +
> +	return kvmppc_xive_native_update_source_config(xive, sb, state, server,
> +						       priority, eisn);
> +}
> +
>  static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
>  				       struct kvm_device_attr *attr)
>  {
> @@ -259,6 +352,9 @@ static int kvmppc_xive_native_set_attr(struct kvm_dev=
ice *dev,
>  	case KVM_DEV_XIVE_GRP_SOURCE:
>  		return kvmppc_xive_native_set_source(xive, attr->attr,
>  						     attr->addr);
> +	case KVM_DEV_XIVE_GRP_SOURCE_CONFIG:
> +		return kvmppc_xive_native_set_source_config(xive, attr->attr,
> +							    attr->addr);
>  	}
>  	return -ENXIO;
>  }
> @@ -276,6 +372,7 @@ static int kvmppc_xive_native_has_attr(struct kvm_dev=
ice *dev,
>  	case KVM_DEV_XIVE_GRP_CTRL:
>  		break;
>  	case KVM_DEV_XIVE_GRP_SOURCE:
> +	case KVM_DEV_XIVE_GRP_SOURCE_CONFIG:
>  		if (attr->attr >=3D KVMPPC_XIVE_FIRST_IRQ &&
>  		    attr->attr < KVMPPC_XIVE_NR_IRQS)
>  			return 0;
> diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/v=
irtual/kvm/devices/xive.txt
> index cd8bfc37b72e..4f513a1880c7 100644
> --- a/Documentation/virtual/kvm/devices/xive.txt
> +++ b/Documentation/virtual/kvm/devices/xive.txt
> @@ -32,3 +32,23 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
>      -ENOMEM: Could not create a new source block
>      -EFAULT: Invalid user pointer for attr->addr.
>      -ENXIO:  Could not allocate underlying HW interrupt
> +
> +  3. KVM_DEV_XIVE_GRP_SOURCE_CONFIG (write only)
> +  Configures source targeting
> +  Attributes:
> +    Interrupt source number  (64-bit)
> +  The kvm_device_attr.addr points to a __u64 value:
> +  bits:     | 63   ....  33 |  32  | 31 .. 3 |  2 .. 0
> +  values:   |    eisn       | mask |  server | priority
> +  - priority: 0-7 interrupt priority level
> +  - server: CPU number chosen to handle the interrupt
> +  - mask: mask flag (unused)
> +  - eisn: Effective Interrupt Source Number
> +  Errors:
> +    -ENOENT: Unknown source number
> +    -EINVAL: Not initialized source number, invalid priority or
> +             invalid CPU number.
> +    -EFAULT: Invalid user pointer for attr->addr.
> +    -ENXIO:  CPU event queues not configured or configuration of the
> +             underlying HW interrupt failed
> +    -EBUSY:  No CPU available to serve interrupt

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HuXIgs6JvY9hJs5C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxzUSYACgkQbDjKyiDZ
s5J1NQ//eORHzsjdfmbMpZMUltQvFaM7+xVOJMP9Cr6xz82sTRU4+euam9Oeia3T
1bTY9qIGcJIA9mso0fe97ZoXmn8ntYhkqENHx22JPM3p720fV4Px0okNoQ0giRUW
L6ziC0Ytfl9IZbv/Ol7+rtBlOPMtDPTjvI7rPyuhya+qtdc0pY/7nTCX0RWWDsrY
lmtPjd6GrQTdfcknbIxdkIpi2hp2WXEQHsZ08c2d58I0YsY1BKUSY71pcRxK1pmm
SPZAPSGTg0jtgxcWFBBL5JBF4MePs+JG0t2ozcWWQ7mewBX4coFeJBfRtI0ND/te
W7NAmAbDiH00JEPwGO07qqGfpGN8qbGAfsO8CMz89DQjXvkRUjPZdk0cBuGHKS0+
vN8aCQl0u2i8hngZSyFVtiPg270oSLJJKZqy5f4oWJddLihxPvHAQcxgcLiaa2Bw
vIhIKd2CTUEISI0ODUWCAsxE7pJK4/R1auRebSYyLpESf28Zjl3LB33A67aOJKFj
Ap+pVhjCGe231ayMRtyAaT3VRj5BsoTGIIW0gf3MjuifWwryNFCKbM4aZXSCttFd
0/QmfJBXOJXfaIgA21NeIg2Yaeh2uLCcwA0Z/PvHsXYkNvpTskzS/CwIEDxUtCSf
66EHK/pRkTIWEqpsP2hjcrCXqgUaAWVw1gmksJ3PxzchFw2TY7I=
=zbEE
-----END PGP SIGNATURE-----

--HuXIgs6JvY9hJs5C--
