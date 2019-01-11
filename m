Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE4BC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 04:51:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8AAB20870
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 04:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="C5YpUFwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AAB20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bVnf3lVXzDr0y
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 15:51:34 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bVlp4nSBzDqyv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 15:49:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="C5YpUFwX"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43bVlp2Khjz9sN1; Fri, 11 Jan 2019 15:49:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1547182198;
 bh=XLIqu5BnypivPMESp/gWoSQ00TY6+gtsdfRlBGFYljo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C5YpUFwX3XWFQzot4j+7yfPdq7mP04wNez1VPnC0pyV1rOYdNLQGtGCAz29vcpJtS
 XoM3iudlOFzVJSpH0VEYaPG9dhuwJ+ALvKiwhMPNSLtydV9MBuxHLflpKKLH7ZvZGN
 QtN+xCXX9LXZ8EvCayyHUKvtSXThYfd+0w1mfwd0=
Date: Fri, 11 Jan 2019 15:09:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 04/19] KVM: PPC: Book3S HV: export services for the XIVE
 native exploitation device
Message-ID: <20190111040957.GA1927@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
In-Reply-To: <20190107184331.8429-5-clg@kaod.org>
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


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:43:16PM +0100, C=E9dric Le Goater wrote:
> The KVM device for the XIVE native exploitation mode will reuse the
> structures of the XICS-over-XIVE glue implementation. Some code will
> also be shared : source block creation and destruction, target
> selection and escalation attachment.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kvm/book3s_xive.h | 11 +++++
>  arch/powerpc/kvm/book3s_xive.c | 89 +++++++++++++++++++---------------
>  2 files changed, 62 insertions(+), 38 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xiv=
e.h
> index a08ae6fd4c51..10c4aa5cd010 100644
> --- a/arch/powerpc/kvm/book3s_xive.h
> +++ b/arch/powerpc/kvm/book3s_xive.h
> @@ -248,5 +248,16 @@ extern int (*__xive_vm_h_ipi)(struct kvm_vcpu *vcpu,=
 unsigned long server,
>  extern int (*__xive_vm_h_cppr)(struct kvm_vcpu *vcpu, unsigned long cppr=
);
>  extern int (*__xive_vm_h_eoi)(struct kvm_vcpu *vcpu, unsigned long xirr);
> =20
> +/*
> + * Common Xive routines for XICS-over-XIVE and XIVE native
> + */
> +struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
> +	struct kvmppc_xive *xive, int irq);
> +void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb);
> +int kvmppc_xive_select_target(struct kvm *kvm, u32 *server, u8 prio);
> +void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu);
> +int kvmppc_xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio);
> +int kvmppc_xive_debug_show_queues(struct seq_file *m, struct kvm_vcpu *v=
cpu);
> +
>  #endif /* CONFIG_KVM_XICS */
>  #endif /* _KVM_PPC_BOOK3S_XICS_H */
> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xiv=
e.c
> index 8a4fa45f07f8..bb5d32f7e4e6 100644
> --- a/arch/powerpc/kvm/book3s_xive.c
> +++ b/arch/powerpc/kvm/book3s_xive.c
> @@ -166,7 +166,7 @@ static irqreturn_t xive_esc_irq(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
> =20
> -static int xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio)
> +int kvmppc_xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio)
>  {
>  	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
>  	struct xive_q *q =3D &xc->queues[prio];
> @@ -291,7 +291,7 @@ static int xive_check_provisioning(struct kvm *kvm, u=
8 prio)
>  			continue;
>  		rc =3D xive_provision_queue(vcpu, prio);
>  		if (rc =3D=3D 0 && !xive->single_escalation)
> -			xive_attach_escalation(vcpu, prio);
> +			kvmppc_xive_attach_escalation(vcpu, prio);
>  		if (rc)
>  			return rc;
>  	}
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
> @@ -1055,7 +1055,7 @@ int kvmppc_xive_clr_mapped(struct kvm *kvm, unsigne=
d long guest_irq,
>  }
>  EXPORT_SYMBOL_GPL(kvmppc_xive_clr_mapped);
> =20
> -static void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu)
> +void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu)
>  {
>  	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
>  	struct kvm *kvm =3D vcpu->kvm;
> @@ -1225,7 +1225,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
>  		if (xive->qmap & (1 << i)) {
>  			r =3D xive_provision_queue(vcpu, i);
>  			if (r =3D=3D 0 && !xive->single_escalation)
> -				xive_attach_escalation(vcpu, i);
> +				kvmppc_xive_attach_escalation(vcpu, i);
>  			if (r)
>  				goto bail;
>  		} else {
> @@ -1240,7 +1240,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
>  	}
> =20
>  	/* If not done above, attach priority 0 escalation */
> -	r =3D xive_attach_escalation(vcpu, 0);
> +	r =3D kvmppc_xive_attach_escalation(vcpu, 0);
>  	if (r)
>  		goto bail;
> =20
> @@ -1491,8 +1491,8 @@ static int xive_get_source(struct kvmppc_xive *xive=
, long irq, u64 addr)
>  	return 0;
>  }
> =20
> -static struct kvmppc_xive_src_block *xive_create_src_block(struct kvmppc=
_xive *xive,
> -							   int irq)
> +struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
> +	struct kvmppc_xive *xive, int irq)
>  {
>  	struct kvm *kvm =3D xive->kvm;
>  	struct kvmppc_xive_src_block *sb;
> @@ -1571,7 +1571,7 @@ static int xive_set_source(struct kvmppc_xive *xive=
, long irq, u64 addr)
>  	sb =3D kvmppc_xive_find_source(xive, irq, &idx);
>  	if (!sb) {
>  		pr_devel("No source, creating source block...\n");
> -		sb =3D xive_create_src_block(xive, irq);
> +		sb =3D kvmppc_xive_create_src_block(xive, irq);
>  		if (!sb) {
>  			pr_devel("Failed to create block...\n");
>  			return -ENOMEM;
> @@ -1795,7 +1795,7 @@ static void kvmppc_xive_cleanup_irq(u32 hw_num, str=
uct xive_irq_data *xd)
>  	xive_cleanup_irq_data(xd);
>  }
> =20
> -static void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb)
> +void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb)
>  {
>  	int i;
> =20
> @@ -1824,6 +1824,8 @@ static void kvmppc_xive_free(struct kvm_device *dev)
> =20
>  	debugfs_remove(xive->dentry);
> =20
> +	pr_devel("Destroying xive for partition\n");
> +
>  	if (kvm)
>  		kvm->arch.xive =3D NULL;
> =20
> @@ -1889,6 +1891,43 @@ static int kvmppc_xive_create(struct kvm_device *d=
ev, u32 type)
>  	return 0;
>  }
> =20
> +int kvmppc_xive_debug_show_queues(struct seq_file *m, struct kvm_vcpu *v=
cpu)
> +{
> +	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < KVMPPC_XIVE_Q_COUNT; i++) {
> +		struct xive_q *q =3D &xc->queues[i];
> +		u32 i0, i1, idx;
> +
> +		if (!q->qpage && !xc->esc_virq[i])
> +			continue;
> +
> +		seq_printf(m, " [q%d]: ", i);
> +
> +		if (q->qpage) {
> +			idx =3D q->idx;
> +			i0 =3D be32_to_cpup(q->qpage + idx);
> +			idx =3D (idx + 1) & q->msk;
> +			i1 =3D be32_to_cpup(q->qpage + idx);
> +			seq_printf(m, "T=3D%d %08x %08x...\n", q->toggle,
> +				   i0, i1);
> +		}
> +		if (xc->esc_virq[i]) {
> +			struct irq_data *d =3D irq_get_irq_data(xc->esc_virq[i]);
> +			struct xive_irq_data *xd =3D
> +				irq_data_get_irq_handler_data(d);
> +			u64 pq =3D xive_vm_esb_load(xd, XIVE_ESB_GET);
> +
> +			seq_printf(m, "E:%c%c I(%d:%llx:%llx)",
> +				   (pq & XIVE_ESB_VAL_P) ? 'P' : 'p',
> +				   (pq & XIVE_ESB_VAL_Q) ? 'Q' : 'q',
> +				   xc->esc_virq[i], pq, xd->eoi_page);
> +			seq_puts(m, "\n");
> +		}
> +	}
> +	return 0;
> +}
> =20
>  static int xive_debug_show(struct seq_file *m, void *private)
>  {
> @@ -1914,7 +1953,6 @@ static int xive_debug_show(struct seq_file *m, void=
 *private)
> =20
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
>  		struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> -		unsigned int i;
> =20
>  		if (!xc)
>  			continue;
> @@ -1924,33 +1962,8 @@ static int xive_debug_show(struct seq_file *m, voi=
d *private)
>  			   xc->server_num, xc->cppr, xc->hw_cppr,
>  			   xc->mfrr, xc->pending,
>  			   xc->stat_rm_h_xirr, xc->stat_vm_h_xirr);
> -		for (i =3D 0; i < KVMPPC_XIVE_Q_COUNT; i++) {
> -			struct xive_q *q =3D &xc->queues[i];
> -			u32 i0, i1, idx;
> =20
> -			if (!q->qpage && !xc->esc_virq[i])
> -				continue;
> -
> -			seq_printf(m, " [q%d]: ", i);
> -
> -			if (q->qpage) {
> -				idx =3D q->idx;
> -				i0 =3D be32_to_cpup(q->qpage + idx);
> -				idx =3D (idx + 1) & q->msk;
> -				i1 =3D be32_to_cpup(q->qpage + idx);
> -				seq_printf(m, "T=3D%d %08x %08x... \n", q->toggle, i0, i1);
> -			}
> -			if (xc->esc_virq[i]) {
> -				struct irq_data *d =3D irq_get_irq_data(xc->esc_virq[i]);
> -				struct xive_irq_data *xd =3D irq_data_get_irq_handler_data(d);
> -				u64 pq =3D xive_vm_esb_load(xd, XIVE_ESB_GET);
> -				seq_printf(m, "E:%c%c I(%d:%llx:%llx)",
> -					   (pq & XIVE_ESB_VAL_P) ? 'P' : 'p',
> -					   (pq & XIVE_ESB_VAL_Q) ? 'Q' : 'q',
> -					   xc->esc_virq[i], pq, xd->eoi_page);
> -				seq_printf(m, "\n");
> -			}
> -		}
> +		kvmppc_xive_debug_show_queues(m, vcpu);
> =20
>  		t_rm_h_xirr +=3D xc->stat_rm_h_xirr;
>  		t_rm_h_ipoll +=3D xc->stat_rm_h_ipoll;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlw4FxUACgkQbDjKyiDZ
s5I+sxAAucIMSNyX3n7jd/MMi7b0AHSC1sZ5twJvNP3eIJ2lq5cPzrOnNHYzeYjB
5FW0XiKNsevgRAcLQvstBGDTPcM7/YCSXNotSJb+Lj94irdXRvhXSwkvGzkgutto
LCf7L4i2RqUHmv7XIZoCj+osrIm4B1UOhZ/kNQ5ehSnIUDvPD5GBGYxZmQN/eDTu
kr1AfZMrzojQ2L7h2tYkZ6QAtOQUBsCKC5C3cXttP8qQXXO9twOk92pBVwhvaXf+
YXZZtN3agXj/yh7YZhJKYo3UqguF7qRekyQ17ugRINv9v6c1kND6OJ/5m6voTCAJ
R2IXD3lCJWCK1lAk+x5NbTXB2byMq66F95SRxC1AikP+V32xuR2xYNSk7DTmclih
Y4Dxcum+jExnB2e7tV6IYnB+rf3aoRknLaLu9EeKmT+y+YK4RkXAuroATvnPPu6w
wqBxBb+R++yvvKZCmPhOhplvEqCQHoBC7fzFViMMju/wtF5T4hOKcklLLtK3pajU
TNztFbkzRU9perLScKbR5UNuUk7afoerVf5cRPPK2H2OKpXCxeyKfShD5LJJXEAI
htzWVhK0NMpMRrhCoGrglrYpN1yQ3RsB0VtREpimxKNknIQjUNkTRWwi/O77/Gw6
jdQXo7Iw0d9Leqz4uOScqfjiDPq18F2ptYuxkCXS19UcbsLn7pI=
=Sv6R
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
