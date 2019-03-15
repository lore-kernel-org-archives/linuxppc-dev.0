Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E842C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 04:30:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D90321871
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 04:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="H8j93Bmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D90321871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LCLc53GbzDqR0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 15:30:48 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LCJk2yWVzDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 15:29:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="H8j93Bmn"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44LCJj549xz9s9T; Fri, 15 Mar 2019 15:29:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552624149;
 bh=ZAI344mw/VFIepTI6G0rrf75eyH9vaaisTPUbgCvPW8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=H8j93BmnAzTM+v1WLnjj7PkTpDu9Dm1e8ShAba4MbjOypvv6e304MvGEhQ25Xv/K8
 n3c/HYMPwlawYf9PmUTMuCFTIewK9Klyrf9mnEnE8zpGBbPnNomTB93lkOTuxO3uyY
 ArmWBX5df/NFaWKV62r4BgDbTBAoGnIyuKn1+to4=
Date: Fri, 15 Mar 2019 11:29:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 06/16] KVM: PPC: Book3S HV: XIVE: add controls for the
 EQ configuration
Message-ID: <20190315002911.GV8211@umbus.fritz.box>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-7-clg@kaod.org>
 <20190226052429.GC28015@blackberry>
 <33aeb002-39b2-1015-9923-613781c08fd6@kaod.org>
 <20190314023210.GL8211@umbus.fritz.box>
 <5fd4dd85-5bf0-dd95-546b-ddc7a3efdb45@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IgDDV5QArAYIxtdK"
Content-Disposition: inline
In-Reply-To: <5fd4dd85-5bf0-dd95-546b-ddc7a3efdb45@kaod.org>
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--IgDDV5QArAYIxtdK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2019 at 08:11:17AM +0100, C=E9dric Le Goater wrote:
> On 3/14/19 3:32 AM, David Gibson wrote:
> > On Wed, Mar 13, 2019 at 10:40:19AM +0100, C=E9dric Le Goater wrote:
> >> On 2/26/19 6:24 AM, Paul Mackerras wrote:
> >>> On Fri, Feb 22, 2019 at 12:28:30PM +0100, C=E9dric Le Goater wrote:
> >>>> These controls will be used by the H_INT_SET_QUEUE_CONFIG and
> >>>> H_INT_GET_QUEUE_CONFIG hcalls from QEMU. They will also be used to
> >>>> restore the configuration of the XIVE EQs in the KVM device and to
> >>>> capture the internal runtime state of the EQs. Both 'get' and 'set'
> >>>> rely on an OPAL call to access from the XIVE interrupt controller the
> >>>> EQ toggle bit and EQ index which are updated by the HW when event
> >>>> notifications are enqueued in the EQ.
> >>>>
> >>>> The value of the guest physical address of the event queue is saved =
in
> >>>> the XIVE internal xive_q structure for later use. That is when
> >>>> migration needs to mark the EQ pages dirty to capture a consistent
> >>>> memory state of the VM.
> >>>>
> >>>> To be noted that H_INT_SET_QUEUE_CONFIG does not require the extra
> >>>> OPAL call setting the EQ toggle bit and EQ index to configure the EQ,
> >>>> but restoring the EQ state will.
> >>>
> >>> [snip]
> >>>
> >>>> +/* Layout of 64-bit eq attribute */
> >>>> +#define KVM_XIVE_EQ_PRIORITY_SHIFT	0
> >>>> +#define KVM_XIVE_EQ_PRIORITY_MASK	0x7
> >>>> +#define KVM_XIVE_EQ_SERVER_SHIFT	3
> >>>> +#define KVM_XIVE_EQ_SERVER_MASK		0xfffffff8ULL
> >>>> +
> >>>> +/* Layout of 64-bit eq attribute values */
> >>>> +struct kvm_ppc_xive_eq {
> >>>> +	__u32 flags;
> >>>> +	__u32 qsize;
> >>>> +	__u64 qpage;
> >>>> +	__u32 qtoggle;
> >>>> +	__u32 qindex;
> >>>> +	__u8  pad[40];
> >>>> +};
> >>>
> >>> This is confusing.  What's the difference between an "eq attribute"
> >>> and an "eq attribute value"?  Is the first actually a queue index or
> >>> a queue identifier?
> >>
> >> The "attribute" qualifier comes from the {get,set,has}_addr methods=20
> >> of the KVM device. But it is not a well chosen name for the group=20
> >> KVM_DEV_XIVE_GRP_EQ_CONFIG.
> >>
> >> I should be using "eq identifier" and "eq values" or "eq state".=20
> >=20
> > Yeah, that seems clearer.
> >=20
> >>> Also, the kvm_ppc_xive_eq is not 64 bits, so the comment above it is
> >>> wrong.  Maybe you meant "64-byte"?
> >>
> >> That was a bad copy paste. I have padded the structure to twice the si=
ze
> >> of the XIVE END (the XIVE EQ descriptor in HW) which size is 32 bytes.=
=20
> >> I thought that one extra u64 was not enough room for future.
> >>
> >>>
> >>> [snip]
> >>>
> >>>> +	page =3D gfn_to_page(kvm, gpa_to_gfn(kvm_eq.qpage));
> >>>> +	if (is_error_page(page)) {
> >>>> +		pr_warn("Couldn't get guest page for %llx!\n", kvm_eq.qpage);
> >>>> +		return -ENOMEM;
> >>>> +	}
> >>>> +	qaddr =3D page_to_virt(page) + (kvm_eq.qpage & ~PAGE_MASK);
> >>>
> >>> Isn't this assuming that we can map the whole queue with a single
> >>> gfn_to_page?  That would only be true if kvm_eq.qsize <=3D PAGE_SHIFT.
> >>> What happens if kvm_eq.qsize > PAGE_SHIFT?
> >>
> >> Ah yes. Theoretically, it should not happen because we only advertise
> >> 64K in the DT for the moment. I should at least add a check. So I will=
=20
> >> change the helper xive_native_validate_queue_size() to return -EINVAL
> >> for other page sizes.
> >=20
> > Ok.
> >=20
> >> Do you think it would be complex to support XIVE EQs using a page larg=
er=20
> >> than the default one on the guest ?
> >=20
> > Hm.  The queue has to be physically contiguous from the host point of
> > view, in order for the XIVE hardware to write to it, doesn't it?  If
> > so then supporting queues bigger than the guest page size would be
> > very difficult.
>=20
> The queue is only *one* page.

Right, but it's one *host* page, right, which is by nature host
physically contiguous.  If the guest page size is different a single
guest page might not be host physically contiguous.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IgDDV5QArAYIxtdK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyK8dYACgkQbDjKyiDZ
s5LBnRAA4IjL4eX1FugzPg/4jaRuOogHkKlDg+xpItTkSqVcffv+j+hQIY9SSyjY
ytKb8GIqJEp5+zYh3s3HSB1+dJtlEcugqnToGbNErKwUnWFhFuAbo224fGsh13ar
1aG4cBfJzb9SzODCO0uGJtUz4lFpjrEKIsSYRcBAEH3YeneSqX0hvDN0PnNptS3x
15nPvKtbiOrTN+DK1UiTVNU80VnvcfuBv1eLDDyDdnLMqkmQaf/7N0KSsnITx3pj
8Y6hJvmlAGbo6Y8NcQG6XjW10raTy68Hp8oaYvYlIvgVM8CYNLECRvxLuohuGd2q
Q6y40m8iSNJvcCI8ILzLpmjfjL6nkcb55XgwH3tXASHuuc9wIRFvN5OK6IMwRxT/
51SxrAd+haDjUIi5WzlvwFXIA/XormHywxti2CjiLfkHYVMVAQ1+Idd2tNWzP9eX
OXyMDhiQENW7b0P3WS5TLnP5vCIfwbqqA8gPqtZbnMsnBHLjsAD21NEaRhR6pewc
0eTEEIOlGSZ0ed4wfjC3b0iZvLaymj5DDBMerzcrSND3Pt0GZvEeJLeczZSA0BKG
V8NGpWxtHDQiiFMtms9iSkC69eVsuVAXv87czxaQzKV/H7NyPq/AEQ1qMw/TuATX
9Ocn7UnJSMt3tg389L36rZdeqnlIhFJX68lB3WageTf3pI9CWQs=
=B6nD
-----END PGP SIGNATURE-----

--IgDDV5QArAYIxtdK--
