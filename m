Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D45C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 06:10:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F8520878
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 06:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="din2qNSh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F8520878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PTKL63dfzF3Cl
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 16:10:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="din2qNSh";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PT7W1XGKzF38X
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 16:01:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="din2qNSh"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42PT7W0lMPz9sj0; Tue,  2 Oct 2018 16:01:59 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42PT7V745tz9shy; Tue,  2 Oct 2018 16:01:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538460118;
 bh=Qn94O49H3FCkHdOLSi/Kguk54O711tnOybrj4Qo/W48=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=din2qNShyKJNPxIxhtzXcmXqnNHjneW+j+fAOVA67P/cB+uHjxLSK7g/ABcLE9M51
 TOG43Hakl444L0w4gH5kDI8EDeKtO6R6MZLbSl0AGpbakdkqKRUmlEbM6LpjRhGBTl
 fGv573GwPxHweuOkSPRrc9ZGzy7FHblGfrowOLZU=
Date: Tue, 2 Oct 2018 16:01:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v2 18/33] KVM: PPC: Book3S HV: Framework and hcall stubs
 for nested virtualization
Message-ID: <20181002060152.GI1886@umbus.fritz.box>
References: <1538127963-15645-1-git-send-email-paulus@ozlabs.org>
 <1538127963-15645-19-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IbA9xpzOQlG26JSn"
Content-Disposition: inline
In-Reply-To: <1538127963-15645-19-git-send-email-paulus@ozlabs.org>
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
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--IbA9xpzOQlG26JSn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2018 at 07:45:48PM +1000, Paul Mackerras wrote:
> This starts the process of adding the code to support nested HV-style
> virtualization.  It defines a new H_SET_PARTITION_TABLE hypercall which
> a nested hypervisor can use to set the base address and size of a
> partition table in its memory (analogous to the PTCR register).
> On the host (level 0 hypervisor) side, the H_SET_PARTITION_TABLE
> hypercall from the guest is handled by code that saves the virtual
> PTCR value for the guest.
>=20
> This also adds code for creating and destroying nested guests and for
> reading the partition table entry for a nested guest from L1 memory.
> Each nested guest has its own shadow LPID value, different in general
> from the LPID value used by the nested hypervisor to refer to it.  The
> shadow LPID value is allocated at nested guest creation time.
>=20
> Nested hypervisor functionality is only available for a radix guest,
> which therefore means a radix host on a POWER9 (or later) processor.
>=20
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

I've made a number of comments below, but they're all pretty minor
things.  They might be worth including if we have to respin for
whatever reason, or as follow-up improvements, but I don't think we
need to hold this up for them.


[snip]
> @@ -287,6 +288,7 @@ struct kvm_arch {
>  	u8 radix;
>  	u8 fwnmi_enabled;
>  	bool threads_indep;
> +	bool nested_enable;
>  	pgd_t *pgtable;
>  	u64 process_table;
>  	struct dentry *debugfs_dir;
> @@ -312,6 +314,9 @@ struct kvm_arch {
>  #endif
>  	struct kvmppc_ops *kvm_ops;
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +	u64 l1_ptcr;
> +	int max_nested_lpid;
> +	struct kvm_nested_guest *nested_guests[KVM_MAX_NESTED_GUESTS];

This array could be quite large.  As a followup would it be worth
dynamically allocating it, so it can be skipped for L1s with no
nesting allowed, and/or dynamically resized as the L1 adds/removes L2s.

>  	/* This array can grow quite large, keep it at the end */
>  	struct kvmppc_vcore *vcores[KVM_MAX_VCORES];
>  #endif

[snip]
> diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3=
s_hv_nested.c
> new file mode 100644
> index 0000000..5341052
> --- /dev/null
> +++ b/arch/powerpc/kvm/book3s_hv_nested.c
> @@ -0,0 +1,283 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright IBM Corporation, 2018
> + * Authors Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> + *	   Paul Mackerras <paulus@ozlabs.org>
> + *
> + * Description: KVM functions specific to running nested KVM-HV guests
> + * on Book3S processors (specifically POWER9 and later).
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/kvm_host.h>
> +
> +#include <asm/kvm_ppc.h>
> +#include <asm/mmu.h>
> +#include <asm/pgtable.h>
> +#include <asm/pgalloc.h>
> +
> +static struct patb_entry *pseries_partition_tb;
> +
> +static void kvmhv_update_ptbl_cache(struct kvm_nested_guest *gp);
> +
> +/* Only called when we're not in hypervisor mode */

This comment isn't strictly accurate, the function is called, but
exits trivially.

> +bool kvmhv_nested_init(void)
> +{
> +	long int ptb_order;
> +	unsigned long ptcr;
> +	long rc;
> +
> +	if (!kvmhv_on_pseries())
> +		return true;
> +	if (!radix_enabled())
> +		return false;
> +
> +	/* find log base 2 of KVMPPC_NR_LPIDS, rounding up */
> +	ptb_order =3D __ilog2(KVMPPC_NR_LPIDS - 1) + 1;
> +	if (ptb_order < 8)
> +		ptb_order =3D 8;
> +	pseries_partition_tb =3D kmalloc(sizeof(struct patb_entry) << ptb_order,
> +				       GFP_KERNEL);
> +	if (!pseries_partition_tb) {
> +		pr_err("kvm-hv: failed to allocated nested partition table\n");
> +		return false;

Since this can fail in several different ways, it seems like returning
an errno, rather than a bool would make sense.

> +	}
> +
> +	ptcr =3D __pa(pseries_partition_tb) | (ptb_order - 8);
> +	rc =3D plpar_hcall_norets(H_SET_PARTITION_TABLE, ptcr);
> +	if (rc !=3D H_SUCCESS) {
> +		pr_err("kvm-hv: Parent hypervisor does not support nesting (rc=3D%ld)\=
n",
> +		       rc);
> +		kfree(pseries_partition_tb);
> +		pseries_partition_tb =3D NULL;
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +void kvmhv_nested_exit(void)
> +{
> +	if (kvmhv_on_pseries() && pseries_partition_tb) {

First clause is redundant there, isn't it, since pseries_partition_tb
can only be set if we're on pseries?

> +		plpar_hcall_norets(H_SET_PARTITION_TABLE, 0);
> +		kfree(pseries_partition_tb);
> +		pseries_partition_tb =3D NULL;
> +	}
> +}
> +
> +void kvmhv_set_ptbl_entry(unsigned int lpid, u64 dw0, u64 dw1)
> +{
> +	if (cpu_has_feature(CPU_FTR_HVMODE)) {
> +		mmu_partition_table_set_entry(lpid, dw0, dw1);
> +	} else {
> +		pseries_partition_tb[lpid].patb0 =3D cpu_to_be64(dw0);
> +		pseries_partition_tb[lpid].patb1 =3D cpu_to_be64(dw1);
> +		/* this will be emulated, L0 will do the necessary barriers */
> +		asm volatile(PPC_TLBIE_5(%0, %1, 2, 0, 1) : :
> +			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));

I think in this version you were using a paravirt TLB flush, instead
of emulation?

> +	}
> +}
> +
> +static void kvmhv_set_nested_ptbl(struct kvm_nested_guest *gp)
> +{
> +	unsigned long dw0;
> +
> +	dw0 =3D PATB_HR | radix__get_tree_size() |
> +		__pa(gp->shadow_pgtable) | RADIX_PGD_INDEX_SIZE;
> +	kvmhv_set_ptbl_entry(gp->shadow_lpid, dw0, gp->process_table);
> +}
> +
> +void kvmhv_vm_nested_init(struct kvm *kvm)
> +{
> +	kvm->arch.max_nested_lpid =3D -1;
> +}
> +
> +/*
> + * Handle the H_SET_PARTITION_TABLE hcall.
> + * r4 =3D guest real address of partition table + log_2(size) - 12
> + * (formatted as for the PTCR).
> + */
> +long kvmhv_set_partition_table(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm =3D vcpu->kvm;
> +	unsigned long ptcr =3D kvmppc_get_gpr(vcpu, 4);
> +
> +	kvm->arch.l1_ptcr =3D ptcr;

I don't think it's actually dangerous, since we validate the L1
addresses when we read from the table, but it would probably be better
for debugging a guest if this failed the hcall if the PTCR didn't make
sense (out of bounds order, or not within L1 memory size).

> +	return H_SUCCESS;
> +}

[snip]
> +/*
> + * Free up any resources allocated for a nested guest.
> + */
> +static void kvmhv_release_nested(struct kvm_nested_guest *gp)
> +{
> +	kvmhv_set_ptbl_entry(gp->shadow_lpid, 0, 0);
> +	kvmppc_free_lpid(gp->shadow_lpid);
> +	if (gp->shadow_pgtable)
> +		pgd_free(gp->l1_host->mm, gp->shadow_pgtable);
> +	kfree(gp);
> +}
> +
> +static void kvmhv_remove_nested(struct kvm_nested_guest *gp)
> +{
> +	struct kvm *kvm =3D gp->l1_host;
> +	int lpid =3D gp->l1_lpid;
> +	long ref;
> +
> +	spin_lock(&kvm->mmu_lock);
> +	if (gp =3D=3D kvm->arch.nested_guests[lpid]) {

This is to protect against a race with another remove, yes?  Since kvm
and lpid are read before you take the lock.  Is that right?

> +		kvm->arch.nested_guests[lpid] =3D NULL;
> +		if (lpid =3D=3D kvm->arch.max_nested_lpid) {
> +			while (--lpid >=3D 0 && !kvm->arch.nested_guests[lpid])
> +				;
> +			kvm->arch.max_nested_lpid =3D lpid;
> +		}
> +		--gp->refcnt;
> +	}
> +	ref =3D gp->refcnt;
> +	spin_unlock(&kvm->mmu_lock);
> +	if (ref =3D=3D 0)
> +		kvmhv_release_nested(gp);
> +}

[snip]
> +struct kvm_nested_guest *kvmhv_get_nested(struct kvm *kvm, int l1_lpid,
> +					  bool create)
> +{
> +	struct kvm_nested_guest *gp, *newgp;
> +
> +	if (l1_lpid >=3D KVM_MAX_NESTED_GUESTS ||
> +	    l1_lpid >=3D (1ul << ((kvm->arch.l1_ptcr & PRTS_MASK) + 12 - 4)))
> +		return NULL;
> +
> +	spin_lock(&kvm->mmu_lock);
> +	gp =3D kvm->arch.nested_guests[l1_lpid];
> +	if (gp)
> +		++gp->refcnt;
> +	spin_unlock(&kvm->mmu_lock);
> +
> +	if (gp || !create)
> +		return gp;
> +
> +	newgp =3D kvmhv_alloc_nested(kvm, l1_lpid);
> +	if (!newgp)
> +		return NULL;
> +	spin_lock(&kvm->mmu_lock);
> +	if (kvm->arch.nested_guests[l1_lpid]) {
> +		/* someone else beat us to it */

Should we print a message in this case.  It's no skin off the host's
nose, but wouldn't this mean the guest is concurrently trying to start
two guests with the same lpid, which seems like a dubious thing for it
to be doing.

> +		gp =3D kvm->arch.nested_guests[l1_lpid];
> +	} else {
> +		kvm->arch.nested_guests[l1_lpid] =3D newgp;
> +		++newgp->refcnt;
> +		gp =3D newgp;
> +		newgp =3D NULL;
> +		if (l1_lpid > kvm->arch.max_nested_lpid)
> +			kvm->arch.max_nested_lpid =3D l1_lpid;
> +	}
> +	++gp->refcnt;
> +	spin_unlock(&kvm->mmu_lock);
> +
> +	if (newgp)
> +		kvmhv_release_nested(newgp);
> +
> +	return gp;
> +}
> +
> +void kvmhv_put_nested(struct kvm_nested_guest *gp)
> +{
> +	struct kvm *kvm =3D gp->l1_host;
> +	long ref;
> +
> +	spin_lock(&kvm->mmu_lock);
> +	ref =3D --gp->refcnt;
> +	spin_unlock(&kvm->mmu_lock);
> +	if (ref =3D=3D 0)
> +		kvmhv_release_nested(gp);
> +}

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IbA9xpzOQlG26JSn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluzCc0ACgkQbDjKyiDZ
s5KIHw//dbFEJDqr0vPADXtiR0lAovpfK2cbDedwmM9eJJZcI6COaDi0uXmg6+/Q
qG7KKpXVaphwRL0HZNGhQmeSyCxca2+DEMkua0gujfyQv6aNlg1pZzcGy035mtJl
VNfyHeQlmPt4U8N9Poc2AQzxL7VKzUAhfD+E1Anj/17p4s0dzkgmjhL8RTiX0CLA
PmLQBALyRZ79ppjAzchXd6CECDGzq/LWH5nkPgNdXGClyinqhc95iDVGKpWiFS5v
dogWubjRSLU8bJldCKu5IBgeNguO1sZ6KMU4L8S1g+LKzhRz2/30/zsBJH3Ohvag
fPfGCSDyMqP9qW/hKGewaZo1EufWhXh1visCO8PCa9lRwYsKYZgj6ZpoE5mUqAsR
sqbCBvkslSnJYbZWRSQNRazlGiKWubnQqL72zFZrbdcp/4mJyBw0j5hY0La+/iI9
ZiPfHd51zEWQooNXH+2fNq/o7i2TpNRpJ9+RJJ8RzeUtYC9qZ9YorIr4cBNFtQcz
4xWBkRVHp/ebt39eVUNc+SBb5jkwy7qjU9GizUSmIQudCQqf+swLUkZV2oG0BUq0
lVGEWMX8aWGGpDyHMixWPkDJulRD1+ZljXVlY+cI6TdShD9Jen6LJ87dNgSgOv9s
1EvbkgyUumB4vIQLO5LlEdZYjr6TqSSEVJiQly7b2TFoJfC7rCg=
=PAD7
-----END PGP SIGNATURE-----

--IbA9xpzOQlG26JSn--
