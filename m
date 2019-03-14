Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06105C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 03:08:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 788F82064C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 03:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bc+l8jwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788F82064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KYYn3vv9zDqNf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 14:08:13 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KYQX67wtzDqLX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 14:01:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="bc+l8jwW"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44KYQX2PQWz9s70; Thu, 14 Mar 2019 14:01:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552532516;
 bh=hV/aSPExRngWXx0TEhPlTqOMBqRJBNesQtEDEBa6hF0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bc+l8jwW3qQJLA0GRfjCpaM1N2XcHjmZfFdtP1OBawa6ATPWgG8yCmadDBOq3kIV3
 2BxqEGSqGPM3MbPoJuGjcyix+XIG2JDttcUgZ8P7WOAuEkJBSFUaBkJru3V70zZXYn
 RNf00lsPAHPgP6Z9QMUNPLpg7TYnCwueRZ084hQk=
Date: Thu, 14 Mar 2019 13:15:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 04/16] KVM: PPC: Book3S HV: XIVE: add a control to
 initialize a source
Message-ID: <20190314021518.GI8211@umbus.fritz.box>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-5-clg@kaod.org>
 <20190225021012.GH7668@umbus.fritz.box>
 <6974050a-cc11-b69d-f35b-9a076549bdd0@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uJWb33pM2TcUAXIl"
Content-Disposition: inline
In-Reply-To: <6974050a-cc11-b69d-f35b-9a076549bdd0@kaod.org>
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


--uJWb33pM2TcUAXIl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 04:19:35PM +0100, C=E9dric Le Goater wrote:
> On 2/25/19 3:10 AM, David Gibson wrote:
> > On Fri, Feb 22, 2019 at 12:28:28PM +0100, C=E9dric Le Goater wrote:
> >> The associated HW interrupt source is simply allocated at the OPAL/HW
> >> level and then MASKED. KVM only needs to know about its type: LSI or
> >> MSI.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  arch/powerpc/include/uapi/asm/kvm.h        |   5 +
> >>  arch/powerpc/kvm/book3s_xive.h             |  10 ++
> >>  arch/powerpc/kvm/book3s_xive.c             |   8 +-
> >>  arch/powerpc/kvm/book3s_xive_native.c      | 114 +++++++++++++++++++++
> >>  Documentation/virtual/kvm/devices/xive.txt |  15 +++
> >>  5 files changed, 148 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/includ=
e/uapi/asm/kvm.h
> >> index b002c0c67787..a9ad99f2a11b 100644
> >> --- a/arch/powerpc/include/uapi/asm/kvm.h
> >> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> >> @@ -677,5 +677,10 @@ struct kvm_ppc_cpu_char {
> >> =20
> >>  /* POWER9 XIVE Native Interrupt Controller */
> >>  #define KVM_DEV_XIVE_GRP_CTRL		1
> >> +#define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source attributes */
> >> +
> >> +/* Layout of 64-bit XIVE source attribute values */
> >> +#define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
> >> +#define KVM_XIVE_LEVEL_ASSERTED		(1ULL << 1)
> >> =20
> >>  #endif /* __LINUX_KVM_POWERPC_H */
> >> diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_=
xive.h
> >> index bcb1bbcf0359..f22f2d46d0f0 100644
> >> --- a/arch/powerpc/kvm/book3s_xive.h
> >> +++ b/arch/powerpc/kvm/book3s_xive.h
> >> @@ -12,6 +12,13 @@
> >>  #ifdef CONFIG_KVM_XICS
> >>  #include "book3s_xics.h"
> >> =20
> >> +/*
> >> + * The XIVE IRQ number space is aligned with the XICS IRQ number
> >> + * space, CPU IPIs being allocated in the first 4K.
> >=20
> > We do align these in qemu, but I don't see that the kernel part
> > cares: as far as it's concerned only one of XICS or XIVE is active at
> > a time, and the irq numbers are chosen by userspace.
>=20
> There is some relation with userspace nevertheless. The KVM device does=
=20
> not remap the numbers to some other range today and the limits are fixed
> values. Checks are being done in the has_attr() and the set_attr().

Hrm.  I still think the comment needs to describe what the constraint
is from the point of view of the kernel, which this isn't.  Maybe, "we
allow irqs in the range X..Y (allowing userspace to do ...)"

>=20
> >> + */
> >> +#define KVMPPC_XIVE_FIRST_IRQ	0
> >> +#define KVMPPC_XIVE_NR_IRQS	KVMPPC_XICS_NR_IRQS
> >> +
> >>  /*
> >>   * State for one guest irq source.
> >>   *
> >> @@ -253,6 +260,9 @@ extern int (*__xive_vm_h_eoi)(struct kvm_vcpu *vcp=
u, unsigned long xirr);
> >>   */
> >>  void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu);
> >>  int kvmppc_xive_debug_show_queues(struct seq_file *m, struct kvm_vcpu=
 *vcpu);
> >> +struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
> >> +	struct kvmppc_xive *xive, int irq);
> >> +void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb);
> >> =20
> >>  #endif /* CONFIG_KVM_XICS */
> >>  #endif /* _KVM_PPC_BOOK3S_XICS_H */
> >> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_=
xive.c
> >> index d1cc18a5b1c4..6f950ecb3592 100644
> >> --- a/arch/powerpc/kvm/book3s_xive.c
> >> +++ b/arch/powerpc/kvm/book3s_xive.c
> >=20
> > I wonder if we should rename this book3s_xics_on_xive.c or something
> > at some point, I keep getting confused because I forget that this is
> > only dealing with host xive, not guest xive.
>=20
> I am fine with renaming. Any objections ? book3s_xics_p9.c ?=20

Hm, maybe?

> >> @@ -1485,8 +1485,8 @@ static int xive_get_source(struct kvmppc_xive *x=
ive, long irq, u64 addr)
> >>  	return 0;
> >>  }
> >> =20
> >> -static struct kvmppc_xive_src_block *xive_create_src_block(struct kvm=
ppc_xive *xive,
> >> -							   int irq)
> >> +struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
> >> +	struct kvmppc_xive *xive, int irq)
> >>  {
> >>  	struct kvm *kvm =3D xive->kvm;
> >>  	struct kvmppc_xive_src_block *sb;
> >=20
> > It's odd that this function, now used from the xive-on-xive path as
> > well as the xics-on-xive path references KVMPPC_XICS_ICS_SHIFT a few
> > lines down from this change.
>=20
> Yes. This is because of the definition of the struct kvmppc_xive_src_bloc=
k.
>=20
> We could introduce new defines for XIVE or a common set of defines for
> XICS and XIVE.

I think making common definitions would be best, if possible.

>=20
> >> @@ -1565,7 +1565,7 @@ static int xive_set_source(struct kvmppc_xive *x=
ive, long irq, u64 addr)
> >>  	sb =3D kvmppc_xive_find_source(xive, irq, &idx);
> >>  	if (!sb) {
> >>  		pr_devel("No source, creating source block...\n");
> >> -		sb =3D xive_create_src_block(xive, irq);
> >> +		sb =3D kvmppc_xive_create_src_block(xive, irq);
> >>  		if (!sb) {
> >>  			pr_devel("Failed to create block...\n");
> >>  			return -ENOMEM;
> >> @@ -1789,7 +1789,7 @@ static void kvmppc_xive_cleanup_irq(u32 hw_num, =
struct xive_irq_data *xd)
> >>  	xive_cleanup_irq_data(xd);
> >>  }
> >> =20
> >> -static void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb)
> >> +void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb)
> >>  {
> >>  	int i;
> >> =20
> >> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/=
book3s_xive_native.c
> >> index 1f3da47a4a6a..a9b2d2d9af99 100644
> >> --- a/arch/powerpc/kvm/book3s_xive_native.c
> >> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> >> @@ -31,6 +31,29 @@
> >> =20
> >>  #include "book3s_xive.h"
> >> =20
> >> +/*
> >> + * TODO: introduce a common template file with the XIVE native layer
> >> + * and the XICS-on-XIVE glue for the utility functions
> >> + */
> >> +#define __x_eoi_page(xd)	((void __iomem *)((xd)->eoi_mmio))
> >> +#define __x_trig_page(xd)	((void __iomem *)((xd)->trig_mmio))
> >> +#define __x_readq	__raw_readq
> >> +#define __x_writeq	__raw_writeq
> >> +
> >> +static u8 xive_vm_esb_load(struct xive_irq_data *xd, u32 offset)
> >> +{
> >> +	u64 val;
> >> +
> >> +	if (xd->flags & XIVE_IRQ_FLAG_SHIFT_BUG)
> >> +		offset |=3D offset << 4;
> >> +
> >> +	val =3D __x_readq(__x_eoi_page(xd) + offset);
> >> +#ifdef __LITTLE_ENDIAN__
> >> +	val >>=3D 64-8;
> >> +#endif
> >> +	return (u8)val;
> >> +}
> >> +
> >>  static void kvmppc_xive_native_cleanup_queue(struct kvm_vcpu *vcpu, i=
nt prio)
> >>  {
> >>  	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> >> @@ -153,12 +176,89 @@ int kvmppc_xive_native_connect_vcpu(struct kvm_d=
evice *dev,
> >>  	return rc;
> >>  }
> >> =20
> >> +static int kvmppc_xive_native_set_source(struct kvmppc_xive *xive, lo=
ng irq,
> >> +					 u64 addr)
> >> +{
> >> +	struct kvmppc_xive_src_block *sb;
> >> +	struct kvmppc_xive_irq_state *state;
> >> +	u64 __user *ubufp =3D (u64 __user *) addr;
> >> +	u64 val;
> >> +	u16 idx;
> >> +
> >> +	pr_devel("%s irq=3D0x%lx\n", __func__, irq);
> >> +
> >> +	if (irq < KVMPPC_XIVE_FIRST_IRQ || irq >=3D KVMPPC_XIVE_NR_IRQS)
> >> +		return -E2BIG;
> >> +
> >> +	sb =3D kvmppc_xive_find_source(xive, irq, &idx);
> >> +	if (!sb) {
> >> +		pr_debug("No source, creating source block...\n");
> >> +		sb =3D kvmppc_xive_create_src_block(xive, irq);
> >> +		if (!sb) {
> >> +			pr_err("Failed to create block...\n");
> >> +			return -ENOMEM;
> >> +		}
> >> +	}
> >> +	state =3D &sb->irq_state[idx];
> >> +
> >> +	if (get_user(val, ubufp)) {
> >> +		pr_err("fault getting user info !\n");
> >> +		return -EFAULT;
> >> +	}
> >=20
> > You should validate the value loaded here to check it doesn't have any
> > bits set we don't know about.
>=20
> ok
>=20
> >=20
> >> +
> >> +	/*
> >> +	 * If the source doesn't already have an IPI, allocate
> >> +	 * one and get the corresponding data
> >> +	 */
> >> +	if (!state->ipi_number) {
> >> +		state->ipi_number =3D xive_native_alloc_irq();
> >> +		if (state->ipi_number =3D=3D 0) {
> >> +			pr_err("Failed to allocate IRQ !\n");
> >> +			return -ENXIO;
> >> +		}
> >> +		xive_native_populate_irq_data(state->ipi_number,
> >> +					      &state->ipi_data);
> >> +		pr_debug("%s allocated hw_irq=3D0x%x for irq=3D0x%lx\n", __func__,
> >> +			 state->ipi_number, irq);
> >> +	}
> >> +
> >> +	arch_spin_lock(&sb->lock);
> >=20
> > Why the direct call to arch_spin_lock() rather than just spin_lock()?
>=20
> Paul answered this question but may be I should make the effort to
> decouple both devices on this aspect.=20
>=20
> Thanks,
>=20
> C.=20
>=20
> >> +
> >> +	/* Restore LSI state */
> >> +	if (val & KVM_XIVE_LEVEL_SENSITIVE) {
> >> +		state->lsi =3D true;
> >> +		if (val & KVM_XIVE_LEVEL_ASSERTED)
> >> +			state->asserted =3D true;
> >> +		pr_devel("  LSI ! Asserted=3D%d\n", state->asserted);
> >> +	}
> >> +
> >> +	/* Mask IRQ to start with */
> >> +	state->act_server =3D 0;
> >> +	state->act_priority =3D MASKED;
> >> +	xive_vm_esb_load(&state->ipi_data, XIVE_ESB_SET_PQ_01);
> >> +	xive_native_configure_irq(state->ipi_number, 0, MASKED, 0);
> >> +
> >> +	/* Increment the number of valid sources and mark this one valid */
> >> +	if (!state->valid)
> >> +		xive->src_count++;
> >> +	state->valid =3D true;
> >> +
> >> +	arch_spin_unlock(&sb->lock);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>  static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
> >>  				       struct kvm_device_attr *attr)
> >>  {
> >> +	struct kvmppc_xive *xive =3D dev->private;
> >> +
> >>  	switch (attr->group) {
> >>  	case KVM_DEV_XIVE_GRP_CTRL:
> >>  		break;
> >> +	case KVM_DEV_XIVE_GRP_SOURCE:
> >> +		return kvmppc_xive_native_set_source(xive, attr->attr,
> >> +						     attr->addr);
> >>  	}
> >>  	return -ENXIO;
> >>  }
> >> @@ -175,6 +275,11 @@ static int kvmppc_xive_native_has_attr(struct kvm=
_device *dev,
> >>  	switch (attr->group) {
> >>  	case KVM_DEV_XIVE_GRP_CTRL:
> >>  		break;
> >> +	case KVM_DEV_XIVE_GRP_SOURCE:
> >> +		if (attr->attr >=3D KVMPPC_XIVE_FIRST_IRQ &&
> >> +		    attr->attr < KVMPPC_XIVE_NR_IRQS)
> >> +			return 0;
> >> +		break;
> >>  	}
> >>  	return -ENXIO;
> >>  }
> >> @@ -183,6 +288,7 @@ static void kvmppc_xive_native_free(struct kvm_dev=
ice *dev)
> >>  {
> >>  	struct kvmppc_xive *xive =3D dev->private;
> >>  	struct kvm *kvm =3D xive->kvm;
> >> +	int i;
> >> =20
> >>  	debugfs_remove(xive->dentry);
> >> =20
> >> @@ -191,6 +297,14 @@ static void kvmppc_xive_native_free(struct kvm_de=
vice *dev)
> >>  	if (kvm)
> >>  		kvm->arch.xive =3D NULL;
> >> =20
> >> +	/* Mask and free interrupts */
> >> +	for (i =3D 0; i <=3D xive->max_sbid; i++) {
> >> +		if (xive->src_blocks[i])
> >> +			kvmppc_xive_free_sources(xive->src_blocks[i]);
> >> +		kfree(xive->src_blocks[i]);
> >> +		xive->src_blocks[i] =3D NULL;
> >> +	}
> >> +
> >>  	if (xive->vp_base !=3D XIVE_INVALID_VP)
> >>  		xive_native_free_vp_block(xive->vp_base);
> >> =20
> >> diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentatio=
n/virtual/kvm/devices/xive.txt
> >> index fdbd2ff92a88..cd8bfc37b72e 100644
> >> --- a/Documentation/virtual/kvm/devices/xive.txt
> >> +++ b/Documentation/virtual/kvm/devices/xive.txt
> >> @@ -17,3 +17,18 @@ the legacy interrupt mode, referred as XICS (POWER7=
/8).
> >> =20
> >>    1. KVM_DEV_XIVE_GRP_CTRL
> >>    Provides global controls on the device
> >> +
> >> +  2. KVM_DEV_XIVE_GRP_SOURCE (write only)
> >> +  Initializes a new source in the XIVE device and mask it.
> >> +  Attributes:
> >> +    Interrupt source number  (64-bit)
> >> +  The kvm_device_attr.addr points to a __u64 value:
> >> +  bits:     | 63   ....  2 |   1   |   0
> >> +  values:   |    unused    | level | type
> >> +  - type:  0:MSI 1:LSI
> >> +  - level: assertion level in case of an LSI.
> >> +  Errors:
> >> +    -E2BIG:  Interrupt source number is out of range
> >> +    -ENOMEM: Could not create a new source block
> >> +    -EFAULT: Invalid user pointer for attr->addr.
> >> +    -ENXIO:  Could not allocate underlying HW interrupt
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uJWb33pM2TcUAXIl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyJuTYACgkQbDjKyiDZ
s5Kdvg//fkbcdnmlpBOZ3F2cyXJ8wZFUTTixLY7Y870gwhy+gFk+gJV8zITHfl7C
PwHE5l0bubp79locgehNR9UxvZX5BJi7M60Dd1RrGno1U7DskDDY8CvkS2j6U5VS
1H88kEikIbBoxI/FLlH1Obi9MDimWdXaTPwLVoEtlFjrM7yncUUvLEMFBhCavei5
9TpKpe7lkkcZlKaDsT60z+I+5mjoCosURv7HItW1sJPf3czRTyZ4axatMBNiDvHw
vSV21vESpp94Rc0S9qTs54VU5Cbq6S4i1Hj26dtJVXUOoEPQJJJHagFAUCn4+zjH
QAiNibuoogc5S6oQv/GmWOqwhO7dmK7MBYg/wO6vm9IakWHN2u+duzMkN/QfKd1F
VTVLFCZfk4UjtzkFjwiBSNGRKAcDgz4q4vtawvYwfRtw5NTAKyvYVNahiikDYwue
bMciBi9KIXWHm1cQGSfy+9rgae8VyxdYgzfpU00LJJU9Biv11WZt3r37iUZDCNIm
9x/kL2Drn0ABMI/QXFgWNVY4jnWZGd5aCo5X6laHVI77gfQddzlayxWACgeF2Bw4
uec+SwL7lsaGP5AOj51C/Rv1dkQF0S/4THAd2usmSCATNtlXH1IZvWnCebihZjho
E5ENEWA2dYGd4iwTZMMqBsRdZoCE09C5Zkt0m/Uvnm1MmMUrM4U=
=+kZK
-----END PGP SIGNATURE-----

--uJWb33pM2TcUAXIl--
