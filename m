Return-Path: <SRS0=q2Dt=QN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243A2C282CB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 01:54:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D7692184E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 01:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fYsMvMuI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D7692184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43vPdJ4h1TzDqLg
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 12:54:28 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43vPSP5CWDzDqKL
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 12:46:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="fYsMvMuI"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43vPSP304qz9sMl; Wed,  6 Feb 2019 12:46:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549417605;
 bh=2WNbqNew+IJifbU8BdCM/Y/23UsGevq55eRZKVnaXNk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fYsMvMuI5812o5wj4fiVqFnFDfQXcZL5+QEULuHa+fFySti27JizRq04aKbBq18kC
 cftNkuF4mVOL3WIuW04jI++QtNNxhkj22sUfcIAUV92Nrf67Z4dVa+av6mJHGJK92I
 Xn6cB5IOZndV4n2uIcQV5cxZ7OnsguHbAr9ypfYo=
Date: Wed, 6 Feb 2019 12:18:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 00/19] KVM: PPC: Book3S HV: add XIVE native exploitation
 mode
Message-ID: <20190206011800.GN22661@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190122044654.GA15124@blackberry>
 <2f9b4420-ef90-20b8-d31b-dc547a6aa6b4@kaod.org>
 <a420acfb9f375b27bc1203fbb15312a61eb0c34d.camel@kernel.crashing.org>
 <06b7c4d2-72ba-ca4f-aded-789280798136@kaod.org>
 <20190204053610.GK1927@umbus.fritz.box>
 <dc59257b-c780-7b81-f3d8-46269b834c2d@kaod.org>
 <20190205221315.GB29038@blackberry>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="o+ZCuNqY+dEAKBWl"
Content-Disposition: inline
In-Reply-To: <20190205221315.GB29038@blackberry>
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
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--o+ZCuNqY+dEAKBWl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 09:13:15AM +1100, Paul Mackerras wrote:
> On Tue, Feb 05, 2019 at 12:31:28PM +0100, C=E9dric Le Goater wrote:
> > >>> As for nesting, I suggest for the foreseeable future we stick to XI=
CS
> > >>> emulation in nested guests.
> > >>
> > >> ok. so no kernel_irqchip at all. hmm.=20
> >=20
> > I was confused with what Paul calls 'XICS emulation'. It's not the QEMU
> > XICS emulated device but the XICS-over-XIVE KVM device, the KVM XICS=20
> > device KVM uses when under a P9 processor.=20
>=20
> Actually there are two separate implementations of XICS emulation in
> KVM.  The first (older) one is almost entirely a software emulation
> but does have some cases where it accesses an underlying XICS device
> in order to make some things faster (IPIs and pass-through of a device
> interrupt to a guest).  The other, newer one is the XICS-on-XIVE
> emulation that Ben wrote, which uses the XIVE hardware pretty heavily.
> My patch was about making the the older code work when there is no
> XICS available to the host.

Ah, right.  To clarify my earlier statements in light of this:

 * We definitely want some sort of kernel-XICS available in a nested
   guest.  AIUI, this is now accomplished, so, Yay!

 * Implementing the L2 XICS in terms of L1's PAPR-XIVE would be a
   bonus, but it's a much lower priority.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--o+ZCuNqY+dEAKBWl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxaNcYACgkQbDjKyiDZ
s5KMFA/9Ea25W4mwq61gaNMyUtvsa8KqPjL4f5PryrwBCsCXdxwnV+gyiT/mCOdC
djMYoagDTYGqbk5y2I4XDODaF9znNDirLIGOEZPtB1KNzPsK65BOvNaSiGNFXJW+
ZQ6aNEQX1xaoGwqXZ2MAcuMLQtYrD4RAZ+HwHY15unnd1JMecOCbWsDRYF+/hjq9
AOi3Rb+K7Z2vQb8rr+kgzMFyxCVx6gD0G9oTX283RhWjliqom2wXlTpCv5cd1aAK
mNeJzNVoPFblIH0B/hj/aXWaTInRmkPtuV28nFCRaNROZNkYh/LweOdHGvdo5/E8
A+4Yzsmn2IUILglriy/I3JF2MhCaIReXLBCXct3mQKOsPGSmUPGfS7iCHfYAA5b2
6eiqkN4gUplxtOuyVIHj/bNgnfVgeJUkWVF67RDfw26FS0EumPb/Hl247c+6W+LS
U1fS9+0TgDUCjDn33zZuTJT5NrXjOeCzYtap3x8LbbtIykugBQUN6E4vlh2rYCON
+oOyZK3ETZ4tqjYhajzdoBQOehGIDvntg6m8/Jqncf+0lVVF3wJHBCwwqxSzUnRj
mzRlxUNJA16Wn0q+ZUFu0USbuJletsfqIZmhT45G+Fls51BidrQMu+gp+y0T9eem
KXAIwlOKCtQ4BQirKplzXuHKRJU/3qUKlSWcjwY6OO9/5Yih8Rs=
=gIj3
-----END PGP SIGNATURE-----

--o+ZCuNqY+dEAKBWl--
