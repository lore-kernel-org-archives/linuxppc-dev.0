Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5E2C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 23:40:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA30218D0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 23:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="FbirW6CJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA30218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448FfV697pzDqLf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 10:40:02 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448FZZ6wFQzDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 10:36:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="FbirW6CJ"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 448FZZ2q4mz9s71; Wed, 27 Feb 2019 10:36:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1551224198;
 bh=bAz1vvACkzx6Ay9jVDjbrX4271TF0xQ92Myjrt71Bas=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FbirW6CJZ1F/VsC8q5QLhqg462zISzdDVqJ4mCk6QcbuatzxUPFLQVpKa2oeax/Om
 iCqbjzsMdoSAuMXBGGckiKXqaIwUb6+HryFEf+CpzX+hm0TyyHU/5quIWJOvTXGKLG
 Vr+n9ZRunzaBkewtjdvn/4Sc3/hR0X/oReIVkwEo=
Date: Wed, 27 Feb 2019 10:22:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 11/16] KVM: introduce a 'mmap' method for KVM devices
Message-ID: <20190226232230.GV6872@umbus.fritz.box>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-12-clg@kaod.org>
 <20190225033309.GO7668@umbus.fritz.box>
 <c906cf13-fb2a-3a76-4382-2a7f98496c05@kaod.org>
 <e1a35077-8c0f-313c-15d0-0483956bfcd6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Rsp728Nwk8twChKq"
Content-Disposition: inline
In-Reply-To: <e1a35077-8c0f-313c-15d0-0483956bfcd6@redhat.com>
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
 Paul Mackerras <paulus@samba.org>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--Rsp728Nwk8twChKq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2019 at 01:52:39PM +0100, Paolo Bonzini wrote:
> On 25/02/19 11:57, C=E9dric Le Goater wrote:
> > Hello Paolo,
> >=20
> > On 2/25/19 4:33 AM, David Gibson wrote:
> >> On Fri, Feb 22, 2019 at 12:28:35PM +0100, C=E9dric Le Goater wrote:
> >>> Some KVM devices will want to handle special mappings related to the
> >>> underlying HW. For instance, the XIVE interrupt controller of the
> >>> POWER9 processor has MMIO pages for thread interrupt management and
> >>> for interrupt source control that need to be exposed to the guest when
> >>> the OS has the required support.
> >>>
> >>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>
> >> Ah, when I suggested mmap() on the base device fd, I hadn't realized
> >> there wasn't a facility for that yet.
> >>
> >> Have you discussed this with Paolo? =20
> >=20
> > Not yet.
> >=20
> >> We'll need some core KVM buy in to merge this.
> >=20
> > Here is an extension of the KVM device to allow special mappings.
> > Something we would need for the support of the POWER9 XIVE interrupt=20
> > controller.
> >=20
> > There are two MMIOs we need to expose to the guest :=20
> >=20
> >  1. HW MMIO controlling of the interrupt presenter registers (TIMA)
> >  2. HW MMIO of the interrupt sources for interrupt management (ESB)
> >=20
> > The TIMA could have been exposed with a page offset in the vCPU mapping
> > but as it only makes sense when the XIVE interrupt mode is active, we=
=20
> > chose to use directly the KVM device fd for that. Is that ok ?=20
> >=20
> > An alternate solution is to use a device ioctl to allocate an anon fd
> > and do the mapping, but that seems like extra fuss for the same result.=
=20
>=20
> It's okay, it's a natural extension to dev_ops - but thanks for asking
> anyway. :)

Ok, cool.

Given that, do you want to merge directly - since this looks sound
enough, even though the rest of the series needs some polish?  Or
would you prefer it to come in via Paulus' tree?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Rsp728Nwk8twChKq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx1yjYACgkQbDjKyiDZ
s5KYkw//YZG/omKMn5bZAAgTKvcH3tS/3tWmqrIiObKbtdhtJGP7tgmJ62WgdZPX
Iq9AL2BmKKlgWt845SrCRVt6S+0+7TQrvtYTSDFcIVVq3WXXpk9ixowYGJAgnJT1
4f8xXCI2S36IzlUDDMFjARwa+iDlXVZ6L2GoHZCYwa5qFVwdxqo0B8+hK/+p9InX
WJKnnu2SEPIeZ5e5ylg7y/ODpwpZEoMi0KOSm9cVykO1HFE4m+uVhosk+Sp4UUzU
OabFylbA3gE6RfG4eZa4lVQjccoKg4hO+pRuSfchCyDwb7dDXUkXi/4kYFMIgP2W
2pCo9HutwuXJAAhYPVrV8jzLwWUhlcy4JMWZhQwHeFKAOUspxkwZrD8nIrboGk2S
ksUAqc1G0eQolepLjOFs0QhwHvUeRqUPcT9HyQOMCGQizaimTx94l2nsPeHynxkc
+So/NZSVvTsAkfxbjawIgVDWTK3xqQhBNvGr4temx3mfdPTSUtKd2m1u1dMiCGJm
HXhjUKTo2zjX/d5R5+eNVNl45ZBriJbSy/bzwHAGKfCziitR2MRBSalgE7woXxt/
Q0HqUDIepfOgNqR2SlOEFTmIOg3CxrasRhM8Roo60urHiAk8YKwKylyE0WtxZyE2
zlisCEpXvU6GHE4d4uyKD9C/R+cdRSYj1j3w8T/Jz0siITnLb6g=
=c2lV
-----END PGP SIGNATURE-----

--Rsp728Nwk8twChKq--
