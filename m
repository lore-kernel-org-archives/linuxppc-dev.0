Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E925FC169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 05:21:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1746220863
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 05:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="cvFmwXtD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1746220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wk6q0sKBzDqW3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 16:21:07 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wk434Mj5zDqTn
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 16:18:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="cvFmwXtD"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43wk43125tz9sNx; Fri,  8 Feb 2019 16:18:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549603123;
 bh=PV+f3Ho8IucPdoLGi8WNvPbR4LnFHYYgkouse5zx1tA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cvFmwXtDKK/gQuEcTcNNzoqPjM/VlsLuw5t1GXXNCoNT/8NahG3GZQ/TnAQ8enx5N
 HI0hne8IHWCC+vqHF1kn6jVgpBirporLinIQh/HOB2KkLWYrf4StD4k2eVbARfXPU8
 OM9tKUS8eN5RslxUeQZ+ZKJeEA4MxBOZC8MXuTlI=
Date: Fri, 8 Feb 2019 16:07:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 00/19] KVM: PPC: Book3S HV: add XIVE native exploitation
 mode
Message-ID: <20190208050747.GC2688@umbus.fritz.box>
References: <2f9b4420-ef90-20b8-d31b-dc547a6aa6b4@kaod.org>
 <a420acfb9f375b27bc1203fbb15312a61eb0c34d.camel@kernel.crashing.org>
 <06b7c4d2-72ba-ca4f-aded-789280798136@kaod.org>
 <20190204053610.GK1927@umbus.fritz.box>
 <dc59257b-c780-7b81-f3d8-46269b834c2d@kaod.org>
 <20190205221315.GB29038@blackberry>
 <20190206011800.GN22661@umbus.fritz.box>
 <bf3725b6-9881-74a0-ec4f-43ac409cb496@kaod.org>
 <20190207025111.GB22661@umbus.fritz.box>
 <2d623da8-31e4-bdc9-c5e4-ea3689a795dd@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="t0UkRYy7tHLRMCai"
Content-Disposition: inline
In-Reply-To: <2d623da8-31e4-bdc9-c5e4-ea3689a795dd@kaod.org>
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--t0UkRYy7tHLRMCai
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 09:31:06AM +0100, C=E9dric Le Goater wrote:
> On 2/7/19 3:51 AM, David Gibson wrote:
> > On Wed, Feb 06, 2019 at 08:35:24AM +0100, C=E9dric Le Goater wrote:
> >> On 2/6/19 2:18 AM, David Gibson wrote:
> >>> On Wed, Feb 06, 2019 at 09:13:15AM +1100, Paul Mackerras wrote:
> >>>> On Tue, Feb 05, 2019 at 12:31:28PM +0100, C=E9dric Le Goater wrote:
> >>>>>>>> As for nesting, I suggest for the foreseeable future we stick to=
 XICS
> >>>>>>>> emulation in nested guests.
> >>>>>>>
> >>>>>>> ok. so no kernel_irqchip at all. hmm.=20
> >>>>>
> >>>>> I was confused with what Paul calls 'XICS emulation'. It's not the =
QEMU
> >>>>> XICS emulated device but the XICS-over-XIVE KVM device, the KVM XIC=
S=20
> >>>>> device KVM uses when under a P9 processor.=20
> >>>>
> >>>> Actually there are two separate implementations of XICS emulation in
> >>>> KVM.  The first (older) one is almost entirely a software emulation
> >>>> but does have some cases where it accesses an underlying XICS device
> >>>> in order to make some things faster (IPIs and pass-through of a devi=
ce
> >>>> interrupt to a guest).  The other, newer one is the XICS-on-XIVE
> >>>> emulation that Ben wrote, which uses the XIVE hardware pretty heavil=
y.
> >>>> My patch was about making the the older code work when there is no
> >>>> XICS available to the host.
> >>>
> >>> Ah, right.  To clarify my earlier statements in light of this:
> >>>
> >>>  * We definitely want some sort of kernel-XICS available in a nested
> >>>    guest.  AIUI, this is now accomplished, so, Yay!
> >>>
> >>>  * Implementing the L2 XICS in terms of L1's PAPR-XIVE would be a
> >>>    bonus, but it's a much lower priority.
> >>
> >> Yes. In this case, the L1 KVM-HV should not advertise KVM_CAP_PPC_IRQ_=
XIVE
> >> to QEMU which will restrict CAS to the XICS only interrupt mode.
> >=20
> > Uh... no... we shouldn't change what's available to the guest based on
> > host configuration only.  We should just stop advertising the CAP
> > saying that *KVM implemented* is available=20
>=20
> yes. that is what I meant.
>=20
> > so that qemu will fall back to userspace XIVE emulation.
>=20
> even if kernel_irqchip is required ?=20

Well, no, but if we don't specify.

> Today, QEMU just fails to start.

If we specify kernel_irqchip=3Don but the kernel can't support that I
think that's the right thing to do.

> With the dual mode, the interrupt mode=20
> is negotiated at CAS time and when merged, the KVM device will be created=
=20
> at reset. In case of failure, QEMU will abort.=20
>=20
> I am not saying it is not possible but we will need some internal=20
> infrastructure to handle dynamically the fall back to userspace
> emulation.

Uh.. we do?  I think in all cases we need to make the XICS vs. XIVE
decision first (i.e. what we present to the guest), then we should
decide how to implement it (userspace, KVM accelerated, impossible and
give up).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--t0UkRYy7tHLRMCai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxdDp0ACgkQbDjKyiDZ
s5L1lQ/+Nvinl/jySO64cCRsHDaXhyAOeqnlPxa3lcUF7IE4fq25F6AsytDG7pb+
DVmWTnAOg4glLkduJDsGVrJ5Y1Kd9Dpm1pxr9E5H72a6ZAbwZ9NVZIOFv0LIug03
lDsWC/aZ1ipCbfUlVkDm1moHPr+n+WzKQy+LOQNnwrcsA/s40MbQsMoNvAN1jS5m
l+nkh8z+iw3LBDvMRZbEjkgOyEfjEMHPWpZxGoByY812sYAm7Sm0rz93O4jTfeEL
lOARA5IGI7ZZyowhg+T03h0oM1MgeCtwxkIhRhhNXF86hrsWDvAmNODXdKJBSAje
4i6vfu8DQWB2Y+gSJQPl18yENF69r/Z1zuXHfovEAikdVJfN9y5qKusN7JGVjQSa
AQ7/wpa20JLfzgovFuS1aPFdBOyf+M6wa+3RDP45x5QVuefWE/AE72tYYlERCwad
7i3cjzsmqb+k0xoWat0trhOUIsE0nBURJi6GfQrhzfmivUza06u2Rj6TbxXz/Gix
l+ZZ2TjlvdsQ2jso2QzQZdhL1hM2ytO/KplcDCat5g/dbZtLNWdO0nMDOs2EVE3f
JB8AAOZr2lqOSH1tRbwu56gpMNnJjOeXsqWymcz6o2jbG6zXXMXVFwP05gcSfh2o
pAy+HzlfGzV9OhQs7XxO8E+zCgmwjtqcd09+5hQzDPSlOunfkD4=
=CstI
-----END PGP SIGNATURE-----

--t0UkRYy7tHLRMCai--
