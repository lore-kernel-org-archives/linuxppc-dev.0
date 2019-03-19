Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE11C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 05:44:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF0720872
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 05:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VPZ9erL2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF0720872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44NhnS5VGyzDqJQ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 16:44:12 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Nhf335vfzDqHf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 16:37:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="VPZ9erL2"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44Nhf25DTHz9s9y; Tue, 19 Mar 2019 16:37:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552973866;
 bh=QSxbIiwrlfkoB5mNY4H3loPAmvOhQHot4K509mGfP98=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VPZ9erL2UIsnecU9sJDuvOms+ZKjhAZzfWe68Hs8sVCwYNnh3nRJCYpQ4MEvG156P
 Y+uc1elw4on7oHwgfcBApYckhqWkg1r5mrVXpBSwWvC+t6y0ziAHFsFuAsiqriinau
 k6lIRQYtjIurNWqtZPaNdZwiJ+4vgQgD1ntoXitw=
Date: Tue, 19 Mar 2019 16:22:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 14/17] KVM: PPC: Book3S HV: XIVE: add passthrough
 support
Message-ID: <20190319052227.GD31018@umbus.fritz.box>
References: <20190315120609.25910-1-clg@kaod.org>
 <20190315120609.25910-15-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Content-Disposition: inline
In-Reply-To: <20190315120609.25910-15-clg@kaod.org>
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


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2019 at 01:06:06PM +0100, C=E9dric Le Goater wrote:
> The KVM XICS-over-XIVE device and the proposed KVM XIVE native device
> implement an IRQ space for the guest using the generic IPI interrupts
> of the XIVE IC controller. These interrupts are allocated at the OPAL
> level and "mapped" into the guest IRQ number space in the range 0-0x1FFF.
> Interrupt management is performed in the XIVE way: using loads and
> stores on the addresses of the XIVE IPI interrupt ESB pages.
>=20
> Both KVM devices share the same internal structure caching information
> on the interrupts, among which the xive_irq_data struct containing the
> addresses of the IPI ESB pages and an extra one in case of pass-through.
> The later contains the addresses of the ESB pages of the underlying HW
> controller interrupts, PHB4 in all cases for now.
>=20
> A guest, when running in the XICS legacy interrupt mode, lets the KVM
> XICS-over-XIVE device "handle" interrupt management, that is to
> perform the loads and stores on the addresses of the ESB pages of the
> guest interrupts. However, when running in XIVE native exploitation
> mode, the KVM XIVE native device exposes the interrupt ESB pages to
> the guest and lets the guest perform directly the loads and stores.
>=20
> The VMA exposing the ESB pages make use of a custom VM fault handler
> which role is to populate the VMA with appropriate pages. When a fault
> occurs, the guest IRQ number is deduced from the offset, and the ESB
> pages of associated XIVE IPI interrupt are inserted in the VMA (using
> the internal structure caching information on the interrupts).
>=20
> Supporting device passthrough in the guest running in XIVE native
> exploitation mode adds some extra refinements because the ESB pages
> of a different HW controller (PHB4) need to be exposed to the guest
> along with the initial IPI ESB pages of the XIVE IC controller. But
> the overall mechanic is the same.
>=20
> When the device HW irqs are mapped into or unmapped from the guest
> IRQ number space, the passthru_irq helpers, kvmppc_xive_set_mapped()
> and kvmppc_xive_clr_mapped(), are called to record or clear the
> passthrough interrupt information and to perform the switch.
>=20
> The approach taken by this patch is to clear the ESB pages of the
> guest IRQ number being mapped and let the VM fault handler repopulate.
> The handler will insert the ESB page corresponding to the HW interrupt
> of the device being passed-through or the initial IPI ESB page if the
> device is being removed.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
>  Changes since v2 :
>=20
>  - extra comment in documentation
>=20
>  arch/powerpc/kvm/book3s_xive.h             |  9 +++++
>  arch/powerpc/kvm/book3s_xive.c             | 15 ++++++++
>  arch/powerpc/kvm/book3s_xive_native.c      | 41 ++++++++++++++++++++++
>  Documentation/virtual/kvm/devices/xive.txt | 19 ++++++++++
>  4 files changed, 84 insertions(+)
>=20
> diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xiv=
e.h
> index 622f594d93e1..e011622dc038 100644
> --- a/arch/powerpc/kvm/book3s_xive.h
> +++ b/arch/powerpc/kvm/book3s_xive.h
> @@ -94,6 +94,11 @@ struct kvmppc_xive_src_block {
>  	struct kvmppc_xive_irq_state irq_state[KVMPPC_XICS_IRQ_PER_ICS];
>  };
> =20
> +struct kvmppc_xive;
> +
> +struct kvmppc_xive_ops {
> +	int (*reset_mapped)(struct kvm *kvm, unsigned long guest_irq);
> +};
> =20
>  struct kvmppc_xive {
>  	struct kvm *kvm;
> @@ -132,6 +137,10 @@ struct kvmppc_xive {
> =20
>  	/* Flags */
>  	u8	single_escalation;
> +
> +	struct kvmppc_xive_ops *ops;
> +	struct address_space   *mapping;
> +	struct mutex mapping_lock;
>  };
> =20
>  #define KVMPPC_XIVE_Q_COUNT	8
> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xiv=
e.c
> index c1b7aa7dbc28..480a3fc6b9fd 100644
> --- a/arch/powerpc/kvm/book3s_xive.c
> +++ b/arch/powerpc/kvm/book3s_xive.c
> @@ -937,6 +937,13 @@ int kvmppc_xive_set_mapped(struct kvm *kvm, unsigned=
 long guest_irq,
>  	/* Turn the IPI hard off */
>  	xive_vm_esb_load(&state->ipi_data, XIVE_ESB_SET_PQ_01);
> =20
> +	/*
> +	 * Reset ESB guest mapping. Needed when ESB pages are exposed
> +	 * to the guest in XIVE native mode
> +	 */
> +	if (xive->ops && xive->ops->reset_mapped)
> +		xive->ops->reset_mapped(kvm, guest_irq);
> +
>  	/* Grab info about irq */
>  	state->pt_number =3D hw_irq;
>  	state->pt_data =3D irq_data_get_irq_handler_data(host_data);
> @@ -1022,6 +1029,14 @@ int kvmppc_xive_clr_mapped(struct kvm *kvm, unsign=
ed long guest_irq,
>  	state->pt_number =3D 0;
>  	state->pt_data =3D NULL;
> =20
> +	/*
> +	 * Reset ESB guest mapping. Needed when ESB pages are exposed
> +	 * to the guest in XIVE native mode
> +	 */
> +	if (xive->ops && xive->ops->reset_mapped) {
> +		xive->ops->reset_mapped(kvm, guest_irq);
> +	}
> +
>  	/* Reconfigure the IPI */
>  	xive_native_configure_irq(state->ipi_number,
>  				  kvmppc_xive_vp(xive, state->act_server),
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index e465d4c53f5c..67a1bb26a4cc 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -14,6 +14,7 @@
>  #include <linux/delay.h>
>  #include <linux/percpu.h>
>  #include <linux/cpumask.h>
> +#include <linux/file.h>
>  #include <asm/uaccess.h>
>  #include <asm/kvm_book3s.h>
>  #include <asm/kvm_ppc.h>
> @@ -170,6 +171,35 @@ int kvmppc_xive_native_connect_vcpu(struct kvm_devic=
e *dev,
>  	return rc;
>  }
> =20
> +/*
> + * Device passthrough support
> + */
> +static int kvmppc_xive_native_reset_mapped(struct kvm *kvm, unsigned lon=
g irq)
> +{
> +	struct kvmppc_xive *xive =3D kvm->arch.xive;
> +
> +	if (irq >=3D KVMPPC_XIVE_NR_IRQS)
> +		return -EINVAL;
> +
> +	/*
> +	 * Clear the ESB pages of the IRQ number being mapped (or
> +	 * unmapped) into the guest and let the the VM fault handler
> +	 * repopulate with the appropriate ESB pages (device or IC)
> +	 */
> +	pr_debug("clearing esb pages for girq 0x%lx\n", irq);
> +	mutex_lock(&xive->mapping_lock);
> +	if (xive->mapping)
> +		unmap_mapping_range(xive->mapping,
> +				    irq * (2ull << PAGE_SHIFT),
> +				    2ull << PAGE_SHIFT, 1);
> +	mutex_unlock(&xive->mapping_lock);
> +	return 0;
> +}
> +
> +static struct kvmppc_xive_ops kvmppc_xive_native_ops =3D  {
> +	.reset_mapped =3D kvmppc_xive_native_reset_mapped,
> +};
> +
>  static int xive_native_esb_fault(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma =3D vmf->vma;
> @@ -247,6 +277,8 @@ static const struct vm_operations_struct xive_native_=
tima_vmops =3D {
>  static int kvmppc_xive_native_mmap(struct kvm_device *dev,
>  				   struct vm_area_struct *vma)
>  {
> +	struct kvmppc_xive *xive =3D dev->private;
> +
>  	/* We only allow mappings at fixed offset for now */
>  	if (vma->vm_pgoff =3D=3D KVM_XIVE_TIMA_PAGE_OFFSET) {
>  		if (vma_pages(vma) > 4)
> @@ -262,6 +294,13 @@ static int kvmppc_xive_native_mmap(struct kvm_device=
 *dev,
> =20
>  	vma->vm_flags |=3D VM_IO | VM_PFNMAP;
>  	vma->vm_page_prot =3D pgprot_noncached_wc(vma->vm_page_prot);
> +
> +	/*
> +	 * Grab the KVM device file address_space to be able to clear
> +	 * the ESB pages mapping when a device is passed-through into
> +	 * the guest.
> +	 */
> +	xive->mapping =3D vma->vm_file->f_mapping;
>  	return 0;
>  }
> =20
> @@ -959,6 +998,7 @@ static int kvmppc_xive_native_create(struct kvm_devic=
e *dev, u32 type)
>  	xive->dev =3D dev;
>  	xive->kvm =3D kvm;
>  	kvm->arch.xive =3D xive;
> +	mutex_init(&xive->mapping_lock);
> =20
>  	/*
>  	 * Allocate a bunch of VPs. KVM_MAX_VCPUS is a large value for
> @@ -972,6 +1012,7 @@ static int kvmppc_xive_native_create(struct kvm_devi=
ce *dev, u32 type)
>  		ret =3D -ENXIO;
> =20
>  	xive->single_escalation =3D xive_native_has_single_escalation();
> +	xive->ops =3D &kvmppc_xive_native_ops;
> =20
>  	if (ret)
>  		kfree(xive);
> diff --git a/Documentation/virtual/kvm/devices/xive.txt b/Documentation/v=
irtual/kvm/devices/xive.txt
> index 686cca450f9f..9aa48efca1cb 100644
> --- a/Documentation/virtual/kvm/devices/xive.txt
> +++ b/Documentation/virtual/kvm/devices/xive.txt
> @@ -43,6 +43,25 @@ the legacy interrupt mode, referred as XICS (POWER7/8).
>    manage the source: to trigger, to EOI, to turn off the source for
>    instance.
> =20
> +  3. Device pass-through
> +
> +  When a device is passed-through into the guest, the source
> +  interrupts are from a different HW controller (PHB4) and the ESB
> +  pages exposed to the guest should accommadate this change.
> +
> +  The passthru_irq helpers, kvmppc_xive_set_mapped() and
> +  kvmppc_xive_clr_mapped() are called when the device HW irqs are
> +  mapped into or unmapped from the guest IRQ number space. The KVM
> +  device extends these helpers to clear the ESB pages of the guest IRQ
> +  number being mapped and then lets the VM fault handler repopulate.
> +  The handler will insert the ESB page corresponding to the HW
> +  interrupt of the device being passed-through or the initial IPI ESB
> +  page if the device has being removed.
> +
> +  The ESB remapping is fully transparent to the guest and the OS
> +  device driver. All handling is done within VFIO and the above
> +  helpers in KVM-PPC.
> +
>  * Groups:
> =20
>    1. KVM_DEV_XIVE_GRP_CTRL

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyQfJAACgkQbDjKyiDZ
s5LtLQ//XZdIJuAibIJ8i4jpfN5alWb/7IhxIkSS8hl1a5yOYBNHcwyqRQOttN1M
OHv6Nmsqs5fOwhsWH4Cjldw+VxkixBcj0m0X3hbihH9lGktkd+/9Q/CYm78LWPRR
YgLgSz2dd0z271F4RdJergE2BY2Z9Y+tfzYSJb1taTuGYUJDw5UvZuYoi2yNBRfk
xQNAsUTb/a8iB9EIIjFxNT6hOY3+xa8dDU1NmcYQD3XOyuBNPWoK5vMVBgK4QtuL
bcOM2eMmJGIn7gB05kh/7mkBtabmzduDBxzJijcbTvzawPawR5SCuf5YGFhRV9pH
zt4LNUcgtlB6zsS/lUgfql4DQFWrHm+kfzBzUUXgtrdvMR9GQVOhzmhtCELLAOwh
J8ukC7clOQCAQm+Odh6q5dGep9Rdw2V2c3t6N326HtX9cyrG4xOybFqfk75JrZzx
CQq0mrDIyvjrxdSXsqxypduZOl55TqA8tYH4gx5HjsQoSMPyI+G3BJHnldyArna/
ahWJKcD9pIp4oCwU7B5HQwc1mb1mcbi4sSPTPdz3S5vSCxFbdbenG7IR9By8+mr3
JETl2IDp1UIhC8xG/WUYMKEMAPRBghDg5P6H+CbMNNg4FVQ6pUX6zm2IoBjRFVi4
X+RTSo6zNCDVQV59/wGihQOt51hJGTyHRuFG614xTccb9B4SldU=
=f4J0
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--
