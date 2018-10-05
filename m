Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35ADC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:10:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C39F320875
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GPvXdNwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39F320875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RHrR65SVzF3Rq
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 15:10:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GPvXdNwZ";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RGjW6ZSmzF3Fs
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 14:19:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="GPvXdNwZ"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42RGjW5lB6z9shy; Fri,  5 Oct 2018 14:19:11 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42RGjW4zLVz9s3T; Fri,  5 Oct 2018 14:19:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538713151;
 bh=lZJttgWtPQ+MQ+RBZSofKM8TWu4KpYPxPKfPzlW8/10=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GPvXdNwZxF+dIJLGQ6m/2nbFiNtNCiixVjHgphvmrTQ0/sor8+A7qAn495koh8ik0
 B6bTk5m1c5u4fzxv58Sgp1LbM3VOIPerrXgYxNH5pfTdH2B9oNOcY+RUYGjGZ1FhpW
 y1/vUZXlm3Klur1fbWeJmeQ8JWxmNv9wMby0Fpxs=
Date: Fri, 5 Oct 2018 13:05:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v3 30/33] KVM: PPC: Book3S HV: Allow HV module to load
 without hypervisor mode
Message-ID: <20181005030549.GB13763@umbus.fritz.box>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
 <1538479892-14835-31-git-send-email-paulus@ozlabs.org>
 <20181003061514.GW1886@umbus.fritz.box>
 <20181004030321.GA16300@fergus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <20181004030321.GA16300@fergus>
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


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 04, 2018 at 01:03:21PM +1000, Paul Mackerras wrote:
> On Wed, Oct 03, 2018 at 04:15:15PM +1000, David Gibson wrote:
> > On Tue, Oct 02, 2018 at 09:31:29PM +1000, Paul Mackerras wrote:
> > > With this, the KVM-HV module can be loaded in a guest running under
> > > KVM-HV, and if the hypervisor supports nested virtualization, this
> > > guest can now act as a nested hypervisor and run nested guests.
> > >=20
> > > This also adds some checks to inform userspace that HPT guests are not
> > > supported by nested hypervisors, and to prevent userspace from
> > > configuring a guest to use HPT mode.
> > >=20
> > > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> > > ---
> > >  arch/powerpc/kvm/book3s_hv.c | 20 ++++++++++++++++----
> > >  1 file changed, 16 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_h=
v.c
> > > index f630e91..196bff1 100644
> > > --- a/arch/powerpc/kvm/book3s_hv.c
> > > +++ b/arch/powerpc/kvm/book3s_hv.c
> > > @@ -4237,6 +4237,10 @@ static int kvm_vm_ioctl_get_smmu_info_hv(struc=
t kvm *kvm,
> > >  {
> > >  	struct kvm_ppc_one_seg_page_size *sps;
> > > =20
> > > +	/* If we're a nested hypervisor, we only support radix guests */
> > > +	if (kvmhv_on_pseries())
> > > +		return -EINVAL;
> > > +
> > >  	/*
> > >  	 * POWER7, POWER8 and POWER9 all support 32 storage keys for data.
> > >  	 * POWER7 doesn't support keys for instruction accesses,
> > > @@ -4822,11 +4826,15 @@ static int kvmppc_core_emulate_mfspr_hv(struc=
t kvm_vcpu *vcpu, int sprn,
> > > =20
> > >  static int kvmppc_core_check_processor_compat_hv(void)
> > >  {
> > > -	if (!cpu_has_feature(CPU_FTR_HVMODE) ||
> > > -	    !cpu_has_feature(CPU_FTR_ARCH_206))
> > > -		return -EIO;
> > > +	if (cpu_has_feature(CPU_FTR_HVMODE) &&
> > > +	    cpu_has_feature(CPU_FTR_ARCH_206))
> > > +		return 0;
> > > =20
> > > -	return 0;
> > > +	/* Can run as nested hypervisor on POWER9 in radix mode. */
> > > +	if (cpu_has_feature(CPU_FTR_ARCH_300) && radix_enabled())
> >=20
> > Shouldn't we probe the parent hypervisor for ability to support nested
> > guests before we say "yes" here?
>=20
> Well, we do check that the parent hypervisor can support nested
> hypervisors, it's just done later on.  And to match nitpick with
> nitpick, this is a function evaluating _processor_ compatibility, and
> a POWER9 processor in radix mode does have everything necessary to
> support nested hypervisors -- if the parent hypervisor doesn't support
> nested hypervisors, that's not a deficiency in the processor.

Fair enough.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu21Q0ACgkQbDjKyiDZ
s5LaZQ/+ISOtAmfsFT9L5GpHWrKPPavsVVkD5knA5XNRSOL69Pyv8e+v/9nyfs+b
4U7JbgKpVuUz4rBzeMirkArDwPBQUjUhwWc3NORQMJtsTUG16k+FWb7WP/54iwHl
zPeEwD2cihkQ97Akj/0OK5TI58/puaBG3/wF+c+BZPac3l0HSMSlECDWjEi3fG7v
fpXYqKszFWQtCaP9lvvUvPSPFe9WzeQgGDANNo7Kh4BRXjTojc1ADL3tIMHv3FDu
Uy+QiOh2jTtJ0D6xgUInKmUFIOeHjRwJ1S3R+fLIHZ14Lu0D52Ak25x14TtT5ZJw
uGf8thFKcppUFh2rf5IuHvvwOgsiyLx6RHM+TY4isNnTpcF9M0jTVjDbHqDcdobm
E6kf/kFzEzyAIswRB1Pe/3TTy9YGvxb0qv/Fte5qjBMHXbIEFpyXHmnPOtmtBS4V
X1wrIsJpS/NDDnSZ3S842LjDYEJn/cqlY7aKyoFPaXR8vYYhJvQRn5VccGVi9Gtb
pR9DBfeAFobEnonPXEUjixtH1tzPqZuOGoZD+wmmxM5d6SAD1hL8281mVF7q5Tkq
R0Vqs8rTAJYkNrLl18FJ/3xcERuHM7wkt5GP3vIMh0lSOxgnS9Y6WAmJqG0qk7Tr
uvyo3F3p/tWCGn7VLCheL9/zjITDyjs0LueseWEv59swVXr+Rio=
=KyoE
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
