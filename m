Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AE8C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:12:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A387520875
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DGPYyqbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A387520875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RHv54sxMzF3KL
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 15:12:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="DGPYyqbP";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RGjW4gXczF3Fc
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 14:19:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="DGPYyqbP"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42RGjW2Cvpz9s7W; Fri,  5 Oct 2018 14:19:11 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42RGjW1QvSz9s8J; Fri,  5 Oct 2018 14:19:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538713151;
 bh=vAR/mgGyI2APaIv5HcmP9fYAW40fFREA7iYaxDG0bO8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DGPYyqbPsVJnmPGKcw2boiK1oeqbOfwf7d43xKveooLFC1nqj+9lG8all6aWozKkw
 Oy9zL2wUNLBS3oSUSkp0cMao0tNKwnfmvFa6ouktZpqXeL2KXCMg7lnBBUJrALoNHi
 Ks3jcEfmaUtRoCCR73ESqG/gvhk35EdxhNyZKIIE=
Date: Fri, 5 Oct 2018 12:46:12 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v3 22/33] KVM: PPC: Book3S HV: Handle page fault for a
 nested guest
Message-ID: <20181005024611.GA13763@umbus.fritz.box>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
 <1538479892-14835-23-git-send-email-paulus@ozlabs.org>
 <20181003053913.GP1886@umbus.fritz.box>
 <20181004092120.GA3255@fergus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20181004092120.GA3255@fergus>
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


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 04, 2018 at 07:21:20PM +1000, Paul Mackerras wrote:
> On Wed, Oct 03, 2018 at 03:39:13PM +1000, David Gibson wrote:
> > On Tue, Oct 02, 2018 at 09:31:21PM +1000, Paul Mackerras wrote:
> > > From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > > @@ -367,7 +367,9 @@ struct kvmppc_pte {
> > >  	bool may_write		: 1;
> > >  	bool may_execute	: 1;
> > >  	unsigned long wimg;
> > > +	unsigned long rc;
> > >  	u8 page_size;		/* MMU_PAGE_xxx */
> > > +	u16 page_shift;
> >=20
> > It's a bit ugly that this has both page_size and page_shift, which is
> > redundant information AFAICT.  Also, why does page_shift need to be
> > u16 - given that 2^255 bytes is much more than our supported address
> > space, let alone a plausible page size.
>=20
> These values are all essentially function outputs, so I don't think
> it's ugly to have the same information in different forms.  I actually
> don't like using the MMU_PAGE_xxx values, because the information in
> the mmu_psize_defs[] array depends on the MMU mode of the host, but
> KVM needs to be able to work with guests in both MMU modes.  More
> generally I don't think it's a good idea that the KVM <-> guest
> interface depends so much on what the host firmware tells us about the
> physical machine we're on.  Thus I'm trying to move away from using
> MMU_PSIZE_xxx values and mmu_psize_defs[] in KVM code.

Fair enough.

> I'll change the type to u8.
>=20
> > > diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kv=
m/book3s_64_mmu_radix.c
> > > index bd06a95..ee6f493 100644
> > > --- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
> > > +++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
> > > @@ -29,43 +29,16 @@
> > >   */
> > >  static int p9_supported_radix_bits[4] =3D { 5, 9, 9, 13 };
> > > =20
> > > -/*
> > > - * Used to walk a partition or process table radix tree in guest mem=
ory
> > > - * Note: We exploit the fact that a partition table and a process
> > > - * table have the same layout, a partition-scoped page table and a
> > > - * process-scoped page table have the same layout, and the 2nd
> > > - * doubleword of a partition table entry has the same layout as
> > > - * the PTCR register.
> > > - */
> > > -int kvmppc_mmu_radix_translate_table(struct kvm_vcpu *vcpu, gva_t ea=
ddr,
> > > -				     struct kvmppc_pte *gpte, u64 table,
> > > -				     int table_index, u64 *pte_ret_p)
> > > +int kvmppc_mmu_walk_radix_tree(struct kvm_vcpu *vcpu, gva_t eaddr,
> > > +			       struct kvmppc_pte *gpte, u64 root,
> > > +			       u64 *pte_ret_p)
> > >  {
> > >  	struct kvm *kvm =3D vcpu->kvm;
> > >  	int ret, level, ps;
> > > -	unsigned long ptbl, root;
> > > -	unsigned long rts, bits, offset;
> > > -	unsigned long size, index;
> > > -	struct prtb_entry entry;
> > > +	unsigned long rts, bits, offset, index;
> > >  	u64 pte, base, gpa;
> > >  	__be64 rpte;
> > > =20
> > > -	if ((table & PRTS_MASK) > 24)
> > > -		return -EINVAL;
> > > -	size =3D 1ul << ((table & PRTS_MASK) + 12);
> > > -
> > > -	/* Is the table big enough to contain this entry? */
> > > -	if ((table_index * sizeof(entry)) >=3D size)
> > > -		return -EINVAL;
> > > -
> > > -	/* Read the table to find the root of the radix tree */
> > > -	ptbl =3D (table & PRTB_MASK) + (table_index * sizeof(entry));
> > > -	ret =3D kvm_read_guest(kvm, ptbl, &entry, sizeof(entry));
> > > -	if (ret)
> > > -		return ret;
> > > -
> > > -	/* Root is stored in the first double word */
> > > -	root =3D be64_to_cpu(entry.prtb0);
> >=20
> > This refactoring somewhat obscures the changes directly relevant to
> > the nested guest handling.  Ideally it would be nice to fold some of
> > this into the earlier reworkings.
>=20
> True, but given the rapidly approaching merge window, I'm not inclined
> to rework it.

Yeah, ok.

>=20
> > > +	if (ret) {
> > > +		/* We didn't find a pte */
> > > +		if (ret =3D=3D -EINVAL) {
> > > +			/* Unsupported mmu config */
> > > +			flags |=3D DSISR_UNSUPP_MMU;
> > > +		} else if (ret =3D=3D -ENOENT) {
> > > +			/* No translation found */
> > > +			flags |=3D DSISR_NOHPTE;
> > > +		} else if (ret =3D=3D -EFAULT) {
> > > +			/* Couldn't access L1 real address */
> > > +			flags |=3D DSISR_PRTABLE_FAULT;
> > > +			vcpu->arch.fault_gpa =3D fault_addr;
> > > +		} else {
> > > +			/* Unknown error */
> > > +			return ret;
> > > +		}
> > > +		goto resume_host;
> >=20
> > This is effectively forwarding the fault to L1, yes?  In which case a
> > different name might be better than the ambiguous "resume_host".
>=20
> I'll change it to "forward_to_l1".

Thanks.

>=20
> Paul.
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu20HEACgkQbDjKyiDZ
s5IRfg//VZxkrUEnDhAdVI8PDBwezlIa+L2ctJ+jUCMIJHtRwd0WLPv81kWNlHUb
CbV9RvZB48D20sea2/tOjhuiA3WvaChiX+5N3aKKja88dtXN9S5Z39Z6wGxuwsvc
fiJxL4Cm4/Q3EZnR758TB8dPfbKV/2LJMFL88optwkgzLIAHhFVvld1lC83ZmBY2
j/ycdRiFj3oLEbUtLZ35v9Rbc2uvjrUsIoPjsmBgSzV31tSDsDl18pd3xWl2mAJg
cybnODUlQB0P+/zLksiUpeztdo5VoeSPP9nAPSCa5uET6qBwmbn8rdHOFPvizrwN
xS/OMdq0bnIfOppRDtR69A9sDDLxT1K5+UrXBRwFDoSJVsE4b4HxHE4Uh6MxFMBa
9rCX0vtIxwQdIeY7n3AMEsd1FdTwZcYe371gzci2xftz9/d0uJ/y6RuaVnillHnS
Xn+f3sfC4Ph279dDlZPsDx9soc5LSR3uwh5T2MjWfNae9D18uTtN7vE+5+pXgVki
MG+c7X4J0nZvlsY0KGxOFzcPFJ/f0HI161BN0iSS+oxKCDwxh+v5MVE5E8xJn4RR
gxbFYKlq3Xp/uNadLsAfoKI1P9R9aP8Z2fpZ+6g6qig0SGGrPh5zcmhI85jdP6dw
YGqTu+VH9igr8HsitcfQlo4wuY3LwGwrEpE98Hzivfs8QOKYj9g=
=5pN5
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
