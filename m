Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7E0C282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 05:40:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2FB020821
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 05:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="otVYNDd2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2FB020821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tthJ0THfzDqKr
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 16:40:16 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ttfM64N5zDqKl
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 16:38:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="otVYNDd2"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43ttfM39vjz9sNM; Tue,  5 Feb 2019 16:38:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549345115;
 bh=Aw3AHovx66hR0tNZ3maVci7Rdfvqgb3hO1OAJaPOZ00=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=otVYNDd20bQIhMOAop+a6PC93yoe+Rlb5fw423YTMytXlEs58pJZM7w/ZSZYaARRU
 YFouSW3S9WxjgrWKyPlWRz65jXu5vr4NTnbWwjGCLvar7v/p00bcRGUVT2XuDi3m5G
 ++MSbmY3gdHBJG7C1DjktLGrev/ShciwN6MO4Zk8=
Date: Tue, 5 Feb 2019 16:35:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 09/19] KVM: PPC: Book3S HV: add a SET_SOURCE control to
 the XIVE native device
Message-ID: <20190205053554.GI22661@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-10-clg@kaod.org>
 <20190204045751.GD1927@umbus.fritz.box>
 <40c8dc36-0d54-1e66-d766-5580c19ae8fd@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rCb8EA+9TsBVtA92"
Content-Disposition: inline
In-Reply-To: <40c8dc36-0d54-1e66-d766-5580c19ae8fd@kaod.org>
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


--rCb8EA+9TsBVtA92
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 08:07:20PM +0100, C=E9dric Le Goater wrote:
> On 2/4/19 5:57 AM, David Gibson wrote:
> > On Mon, Jan 07, 2019 at 07:43:21PM +0100, C=E9dric Le Goater wrote:
[snip]
> >> +		sb =3D kvmppc_xive_create_src_block(xive, irq);
> >> +		if (!sb) {
> >> +			pr_err("Failed to create block...\n");
> >> +			return -ENOMEM;
> >> +		}
> >> +	}
> >> +	state =3D &sb->irq_state[idx];
> >> +
> >> +	if (get_user(val, ubufp)) {
> >> +		pr_err("fault getting user info !\n");
> >> +		return -EFAULT;
> >> +	}
> >> +
> >> +	/*
> >> +	 * If the source doesn't already have an IPI, allocate
> >> +	 * one and get the corresponding data
> >> +	 */
> >> +	if (!state->ipi_number) {
> >> +		state->ipi_number =3D xive_native_alloc_irq();
> >> +		if (state->ipi_number =3D=3D 0) {
> >> +			pr_err("Failed to allocate IRQ !\n");
> >> +			return -ENOMEM;
> >> +		}
> >=20
> > Am I right in thinking this is the point at which a specific guest irq
> > number gets bound to a specific host irq number?
>=20
> yes. the XIVE IRQ state caches this information and 'state' should be=20
> protected before being assigned, indeed ... The XICS-over-XIVE device
> also has the same race issue.
>=20
> It's not showing because where initializing the KVM device sequentially
> from QEMU and only once.

Ok.

So, for the passthrough case, what's the point at which we know that a
particular guest interrupt needs to be bound to a specific real
hardware interrupt, rather than a generic IPI?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rCb8EA+9TsBVtA92
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxZILoACgkQbDjKyiDZ
s5JdJhAAzVuiEoXQxgnZpkZHKWtgO16seRiZIO1T3zUqHAv2m202CkCdClFc0Ktk
zQxLa3cXMFtmDhXJ0ewxDGoxv3xcqz9SERjwHAeg/3DP323EoOktPjUhVcql065F
+sMMvNJR5yw69lVDUNfHHE0J6xW6ADbrZo2BEMyZqw7kDeFycdQnXUF8M4w5CnQQ
R2WlVvIxvxrn3B0hr8ZwRiQMVC/Y5kEzaIGS5D3VEM+AIZ/3ZPD+5L9C+MhtNkpK
3ZW3uakQCObWMeFHLwDOXGmInZcnrOaWSJQJQWrMXWTc4Dv9Kof9vyxUiEG/B0tK
/UopLiz5aG9dY8zHAtUFyKIbNW3GeWHwie17y6qsgroKbTDAyyPT71X9VABdxTHM
6tjAHm+oyo2XLmaJfzNuqCk77ew04Bbe/mTyju6lxsnoqXbHc53psPMB/dQBKWQu
XMMSDh2w4JFqGM3N1l8lzPogIS8/n+lFyGbIQ/nArV+nSRq4zc5Uj+dkiJGL7BpY
sK0Pat+kdE21CdlaIRROb+Idn0sv2IY6JdsMUfhQ8mLubZuO+c710sX18HkC8iFX
rkG4r7Jtq+aaKwiyBAqYDMESbmSC3yaC8oa7Tk9GoSbirTKhxRnZQ1yTu/NBmzgc
2lXljyDXO+xhndeMfCFmtOUSjeGue6fJzEp62N8mlRp5iPuX4y0=
=IEau
-----END PGP SIGNATURE-----

--rCb8EA+9TsBVtA92--
