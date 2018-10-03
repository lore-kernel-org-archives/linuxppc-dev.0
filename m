Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D73C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 05:18:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D90B206B2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 05:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UvsIM14M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D90B206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q46p3rwHzF325
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 15:18:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="UvsIM14M";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q43m4zdlzF37X
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 15:15:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="UvsIM14M"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Q43m4G4nz9s8r; Wed,  3 Oct 2018 15:15:48 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Q43m3j3gz9sB7; Wed,  3 Oct 2018 15:15:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538543748;
 bh=bFw2WKS2i61yJFJP3s7y+UJ83D5evVXmgRGwz7xqn4U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UvsIM14MsXBdMSJix/bIKmrZi9hftAnjFxo7zc1x2Ejfqn8llMn9ERaI+7QGH8/Fm
 LpuvX3GGjDv2EqNwBXeIEEZ+7RucKTa3z15+xTQOMQ5fR9KH5ou9djDknxuNcQiikN
 2GnTscVIFk6r1AjWsVD/es5s7Mk7ZVlSBxG1SgiA=
Date: Wed, 3 Oct 2018 15:09:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v2 19/33] KVM: PPC: Book3S HV: Nested guest entry via
 hypercall
Message-ID: <20181003050914.GA30122@umbus.fritz.box>
References: <1538127963-15645-1-git-send-email-paulus@ozlabs.org>
 <1538127963-15645-20-git-send-email-paulus@ozlabs.org>
 <20181002070009.GJ1886@umbus.fritz.box>
 <20181002080016.GB26512@fergus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <20181002080016.GB26512@fergus>
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


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 02, 2018 at 06:00:16PM +1000, Paul Mackerras wrote:
> On Tue, Oct 02, 2018 at 05:00:09PM +1000, David Gibson wrote:
> > On Fri, Sep 28, 2018 at 07:45:49PM +1000, Paul Mackerras wrote:
> > > This adds a new hypercall, H_ENTER_NESTED, which is used by a nested
> > > hypervisor to enter one of its nested guests.  The hypercall supplies
> > > register values in two structs.  Those values are copied by the level=
 0
> > > (L0) hypervisor (the one which is running in hypervisor mode) into the
> > > vcpu struct of the L1 guest, and then the guest is run until an
> > > interrupt or error occurs which needs to be reported to L1 via the
> > > hypercall return value.
> > >=20
> > > Currently this assumes that the L0 and L1 hypervisors are the same
> > > endianness, and the structs passed as arguments are in native
> > > endianness.  If they are of different endianness, the version number
> > > check will fail and the hcall will be rejected.
> > >=20
> > > Nested hypervisors do not support indep_threads_mode=3DN, so this adds
> > > code to print a warning message if the administrator has set
> > > indep_threads_mode=3DN, and treat it as Y.
> > >=20
> > > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> >=20
> > [snip]
> > > +/* Register state for entering a nested guest with H_ENTER_NESTED */
> > > +struct hv_guest_state {
> > > +	u64 version;		/* version of this structure layout */
> > > +	u32 lpid;
> > > +	u32 vcpu_token;
> > > +	/* These registers are hypervisor privileged (at least for writing)=
 */
> > > +	u64 lpcr;
> > > +	u64 pcr;
> > > +	u64 amor;
> > > +	u64 dpdes;
> > > +	u64 hfscr;
> > > +	s64 tb_offset;
> > > +	u64 dawr0;
> > > +	u64 dawrx0;
> > > +	u64 ciabr;
> > > +	u64 hdec_expiry;
> > > +	u64 purr;
> > > +	u64 spurr;
> > > +	u64 ic;
> > > +	u64 vtb;
> > > +	u64 hdar;
> > > +	u64 hdsisr;
> > > +	u64 heir;
> > > +	u64 asdr;
> > > +	/* These are OS privileged but need to be set late in guest entry */
> > > +	u64 srr0;
> > > +	u64 srr1;
> > > +	u64 sprg[4];
> > > +	u64 pidr;
> > > +	u64 cfar;
> > > +	u64 ppr;
> > > +};
> >=20
> > I'm guessing the implication here is that most supervisor privileged
> > registers need to be set by the L1 to the L2 values, before making the
> > H_ENTER_NESTED call.  Is that right?
>=20
> Right - the supervisor privileged registers that are here are the ones
> that the L1 guest needs to have valid at all times (e.g. sprgN), or
> that can get clobbered at any time (e.g. srr0/1), or that can't be
> set to guest values until just before guest entry (cfar, ppr), or that
> are not writable by the supervisor (purr, spurr, dpdes, ic, vtb).
>=20
> > [snip]
> > > +static int kvmppc_handle_nested_exit(struct kvm_vcpu *vcpu)
> > > +{
> > > +	int r;
> > > +	int srcu_idx;
> > > +
> > > +	vcpu->stat.sum_exits++;
> > > +
> > > +	/*
> > > +	 * This can happen if an interrupt occurs in the last stages
> > > +	 * of guest entry or the first stages of guest exit (i.e. after
> > > +	 * setting paca->kvm_hstate.in_guest to KVM_GUEST_MODE_GUEST_HV
> > > +	 * and before setting it to KVM_GUEST_MODE_HOST_HV).
> > > +	 * That can happen due to a bug, or due to a machine check
> > > +	 * occurring at just the wrong time.
> > > +	 */
> > > +	if (vcpu->arch.shregs.msr & MSR_HV) {
> > > +		pr_emerg("KVM trap in HV mode while nested!\n");
> > > +		pr_emerg("trap=3D0x%x | pc=3D0x%lx | msr=3D0x%llx\n",
> > > +			 vcpu->arch.trap, kvmppc_get_pc(vcpu),
> > > +			 vcpu->arch.shregs.msr);
> > > +		kvmppc_dump_regs(vcpu);
> > > +		return RESUME_HOST;
> >=20
> > To make sure I'm understanding right here, RESUME_HOST will
> > effectively mean resume the L0, and RESUME_GUEST (without additional
> > processing) will mean resume the L2, right?
>=20
> RESUME_HOST means resume L1 in fact, and RESUME_GUEST means resume L2.

Hm, ok.  A comment saying that might make this easier to read.

> We never go straight out from L2 to L0 because that would leave L1 in
> the middle of a hypercall and we would have to have some sort of extra
> state to record that fact.  Instead, if we need to do anything like
> that (e.g. because of a signal pending for the task), we get to the
> point where the H_ENTER_NESTED is finished and the return code is
> stored in L1's r3 before exiting to the L0 userspace.

To clarify.. if an L2 is running, but the L1 vcpu it's running on is
descheduled by the L0, does that mean we have to force an L2 exit to
L1 before we can continued scheduling whatever else on the L0?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu0TvgACgkQbDjKyiDZ
s5IQKA//V6EJMt7gcha2rVvlvZgju3q++fnOOtmc2hzMq3v4q0BNi7B1rZ5zIJWQ
CEoeX60fWsxlmcNkBnoH8BdRHKvcSY8nu9qViSEY/YGHwrVa1YbyXYxdSe6HTfh4
p7TrmPt2VnbvBsilh52pbiie8mMVgJpB+BSlyCXrcHjtjEeTA6QjI5E3z3ko75Vg
d0I/e3mP2uVyF0RcqWIrjXouBtiD9XNDBj/b/UneoM81y50gTm/HKISFXJ60UZFS
r9yTRIDlDZV0BPgDDrat3OYd3u3K4X1RBBYdA/xr+luh+OW/PT/0TtjcVip/jlQz
tAOGxy3iWflQ7Krhk6nbB5xBfBw3rgKoTuVhbZ9OSu53ggpLTGDYMTIaiBAlaN4A
4udnhfZPZY/QC+S+7W7ifhf50VGPZe3ZcTd6tmzw+Omq/9iEBcK7Oc04CJNU+MWF
BqLQ5CUITvQn2Rw50ahIrMV77zguZfn5N/85xtpRIKXWb4SpTTtAojolYQgpdYoc
BCQ6goA5oxRGPBUgUHC1NZ1kzp9DtaI+JJCFWcVQSrqV+fyvGrcwMbX/Y2s2wMGT
QTYaP1H2MzZFCWMzYSes8Z0PCg7Iflbxagag2vzsi1cCfHjgnzAiu9w5EWD0gHlU
KB8yc5X7JrXfhi7TQS8ZJmGFj4gKhSHmiBZ++ii4BQTzkdXnp5c=
=NIbd
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
