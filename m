Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F09EC282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 05:43:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19D482081B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 05:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YtpWghS1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D482081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ttlj1VtczDqLB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 16:43:13 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ttfM1q83zDqH3
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 16:38:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="YtpWghS1"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43ttfL6k6Jz9sDr; Tue,  5 Feb 2019 16:38:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549345114;
 bh=cnuOqWew3J6mNGZPA6sT+DWoAkrnxvUxRcsKQjKgIlo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YtpWghS1dyIXQua8wDUYCF1l6ZsdaOXD1jogYAkqQYiMGM2CN86nPnf1fUPwd08+5
 PUVGsPFzsQ1nFTpgkmrvqMqlSfue0HUrnuKTJyHde8vha+7RKfNj26GhhxI5TDXF6N
 9onXSX4ySejqzq7KYC3SPmq+B9negyG4GTJDbOuo=
Date: Tue, 5 Feb 2019 16:28:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 06/19] KVM: PPC: Book3S HV: add a GET_ESB_FD control to
 the XIVE native device
Message-ID: <20190205052822.GE22661@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-7-clg@kaod.org>
 <20190204044531.GB1927@umbus.fritz.box>
 <69791b73-f93e-6957-92e8-5b8620b87731@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Content-Disposition: inline
In-Reply-To: <69791b73-f93e-6957-92e8-5b8620b87731@kaod.org>
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


--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 12:30:39PM +0100, C=E9dric Le Goater wrote:
> On 2/4/19 5:45 AM, David Gibson wrote:
> > On Mon, Jan 07, 2019 at 07:43:18PM +0100, C=E9dric Le Goater wrote:
> >> This will let the guest create a memory mapping to expose the ESB MMIO
> >> regions used to control the interrupt sources, to trigger events, to
> >> EOI or to turn off the sources.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  arch/powerpc/include/uapi/asm/kvm.h   |  4 ++
> >>  arch/powerpc/kvm/book3s_xive_native.c | 97 +++++++++++++++++++++++++++
> >>  2 files changed, 101 insertions(+)
> >>
> >> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/includ=
e/uapi/asm/kvm.h
> >> index 8c876c166ef2..6bb61ba141c2 100644
> >> --- a/arch/powerpc/include/uapi/asm/kvm.h
> >> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> >> @@ -675,4 +675,8 @@ struct kvm_ppc_cpu_char {
> >>  #define  KVM_XICS_PRESENTED		(1ULL << 43)
> >>  #define  KVM_XICS_QUEUED		(1ULL << 44)
> >> =20
> >> +/* POWER9 XIVE Native Interrupt Controller */
> >> +#define KVM_DEV_XIVE_GRP_CTRL		1
> >> +#define   KVM_DEV_XIVE_GET_ESB_FD	1
> >=20
> > Introducing a new FD for ESB and TIMA seems overkill.  Can't you get
> > to both with an mmap() directly on the xive device fd?  Using the
> > offset to distinguish which one to map, obviously.
>=20
> The page offset would define some sort of user API. It seems feasible.
> But I am not sure this would be practical in the future if we need to=20
> tune the length.

Um.. why not?  I mean, yes the XIVE supports rather a lot of
interrupts, but we have 64-bits of offset we can play with - we can
leave room for billions of ESB slots and still have room for billions
of VPs.

> The TIMA has two pages that can be exposed at guest level for interrupt=
=20
> management : the OS and the USER page. That should be OK.
>=20
> But we might want to map only portions of the interrupt ESB space, for=20
> PCI passthrough for instance as Paul proposed. I am still looking at that.
>=20
> Thanks,
>=20
> C.
>=20
> >>  #endif /* __LINUX_KVM_POWERPC_H */
> >> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/=
book3s_xive_native.c
> >> index 115143e76c45..e20081f0c8d4 100644
> >> --- a/arch/powerpc/kvm/book3s_xive_native.c
> >> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> >> @@ -153,6 +153,85 @@ int kvmppc_xive_native_connect_vcpu(struct kvm_de=
vice *dev,
> >>  	return rc;
> >>  }
> >> =20
> >> +static int xive_native_esb_fault(struct vm_fault *vmf)
> >> +{
> >> +	struct vm_area_struct *vma =3D vmf->vma;
> >> +	struct kvmppc_xive *xive =3D vma->vm_file->private_data;
> >> +	struct kvmppc_xive_src_block *sb;
> >> +	struct kvmppc_xive_irq_state *state;
> >> +	struct xive_irq_data *xd;
> >> +	u32 hw_num;
> >> +	u16 src;
> >> +	u64 page;
> >> +	unsigned long irq;
> >> +
> >> +	/*
> >> +	 * Linux/KVM uses a two pages ESB setting, one for trigger and
> >> +	 * one for EOI
> >> +	 */
> >> +	irq =3D vmf->pgoff / 2;
> >> +
> >> +	sb =3D kvmppc_xive_find_source(xive, irq, &src);
> >> +	if (!sb) {
> >> +		pr_err("%s: source %lx not found !\n", __func__, irq);
> >> +		return VM_FAULT_SIGBUS;
> >> +	}
> >> +
> >> +	state =3D &sb->irq_state[src];
> >> +	kvmppc_xive_select_irq(state, &hw_num, &xd);
> >> +
> >> +	arch_spin_lock(&sb->lock);
> >> +
> >> +	/*
> >> +	 * first/even page is for trigger
> >> +	 * second/odd page is for EOI and management.
> >> +	 */
> >> +	page =3D vmf->pgoff % 2 ? xd->eoi_page : xd->trig_page;
> >> +	arch_spin_unlock(&sb->lock);
> >> +
> >> +	if (!page) {
> >> +		pr_err("%s: acessing invalid ESB page for source %lx !\n",
> >> +		       __func__, irq);
> >> +		return VM_FAULT_SIGBUS;
> >> +	}
> >> +
> >> +	vmf_insert_pfn(vma, vmf->address, page >> PAGE_SHIFT);
> >> +	return VM_FAULT_NOPAGE;
> >> +}
> >> +
> >> +static const struct vm_operations_struct xive_native_esb_vmops =3D {
> >> +	.fault =3D xive_native_esb_fault,
> >> +};
> >> +
> >> +static int xive_native_esb_mmap(struct file *file, struct vm_area_str=
uct *vma)
> >> +{
> >> +	/* There are two ESB pages (trigger and EOI) per IRQ */
> >> +	if (vma_pages(vma) + vma->vm_pgoff > KVMPPC_XIVE_NR_IRQS * 2)
> >> +		return -EINVAL;
> >> +
> >> +	vma->vm_flags |=3D VM_IO | VM_PFNMAP;
> >> +	vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
> >> +	vma->vm_ops =3D &xive_native_esb_vmops;
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct file_operations xive_native_esb_fops =3D {
> >> +	.mmap =3D xive_native_esb_mmap,
> >> +};
> >> +
> >> +static int kvmppc_xive_native_get_esb_fd(struct kvmppc_xive *xive, u6=
4 addr)
> >> +{
> >> +	u64 __user *ubufp =3D (u64 __user *) addr;
> >> +	int ret;
> >> +
> >> +	ret =3D anon_inode_getfd("[xive-esb]", &xive_native_esb_fops, xive,
> >> +				O_RDWR | O_CLOEXEC);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	return put_user(ret, ubufp);
> >> +}
> >> +
> >>  static int kvmppc_xive_native_set_attr(struct kvm_device *dev,
> >>  				       struct kvm_device_attr *attr)
> >>  {
> >> @@ -162,12 +241,30 @@ static int kvmppc_xive_native_set_attr(struct kv=
m_device *dev,
> >>  static int kvmppc_xive_native_get_attr(struct kvm_device *dev,
> >>  				       struct kvm_device_attr *attr)
> >>  {
> >> +	struct kvmppc_xive *xive =3D dev->private;
> >> +
> >> +	switch (attr->group) {
> >> +	case KVM_DEV_XIVE_GRP_CTRL:
> >> +		switch (attr->attr) {
> >> +		case KVM_DEV_XIVE_GET_ESB_FD:
> >> +			return kvmppc_xive_native_get_esb_fd(xive, attr->addr);
> >> +		}
> >> +		break;
> >> +	}
> >>  	return -ENXIO;
> >>  }
> >> =20
> >>  static int kvmppc_xive_native_has_attr(struct kvm_device *dev,
> >>  				       struct kvm_device_attr *attr)
> >>  {
> >> +	switch (attr->group) {
> >> +	case KVM_DEV_XIVE_GRP_CTRL:
> >> +		switch (attr->attr) {
> >> +		case KVM_DEV_XIVE_GET_ESB_FD:
> >> +			return 0;
> >> +		}
> >> +		break;
> >> +	}
> >>  	return -ENXIO;
> >>  }
> >> =20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxZHvYACgkQbDjKyiDZ
s5I65w/+PQ9Dkb413X34thFt1NBYK8CzRhadhNw0+fbvLHC7DVcbssovPmTVUk36
/ZFQHh/gVHwiBZlF47BkA5b0aK+IzKJ5ApSEd6Ax9ZYqh35/+7UxJdH74UIV8dK6
OElHkF+yKms+FfNM6I9UXqTANptR+/FVSjKuhmKU/Pd73Dl7xH+0Fph8HvZSPKAx
Tke9HNVTN+7h85m8KcHJ232jxha5I+vWkFzoOTA+WWc7/4yh236VBISN3+b6xDRZ
9+28e1FgPzyNlmYdcSk8evQXL/e9KnRMtuSRxioMcBf4oOFa41cWCbM7cdusUKl5
KOn9Oc5Ot3cHDCGabLL5Xzwx4JRdNBgd8GH1B6U0twlIOZ1PoskVcUA51FL78KGR
bBhdOUKnEkIVTzZ+3yTbA3o11LCa0kAC33of1QJccZF7kfDhn08eflbdE5RdhUce
2rGD8GDhfB3H1cICJ0KaEQuA5Nv0SCKQF+ClnZ45uKSiLcl2q03Af4YqCBGgDKIy
oUl8lRnDoDRVqxJ6ccb988s3nM2knDm47Yz2J97QcUIVm6zqy093pH44hFbcwh/X
uuI9q1MX4lDND9ShfJ/OFYQSrOe76ZpPZkUNiAZH2NpIxaVsKOB8QIMEZIXchifN
IEl8RWDWE77HTk7K/YUZQRF+DmKY1O5x3ve6+oX02B4pS9LWKIY=
=0EsT
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--
