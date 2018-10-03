Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A520C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:38:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF582089F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TfhqdiUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF582089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q5vV62rjzF3JR
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 16:38:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="TfhqdiUT";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q5X42lxhzF3Cf
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 16:21:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="TfhqdiUT"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Q5X302PZzB4MZ; Wed,  3 Oct 2018 16:21:55 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Q5X26c0lz9vd1; Wed,  3 Oct 2018 16:21:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538547714;
 bh=0eBx8H9CbamvrQ5OEzCt0Zdb3LNzswY0wXYR2nhXtKg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TfhqdiUTCOZUU7BeFWh8ceauZS9mcMYiYs7EgaQrgfRV+wKfnCCgyhljtWt5lhbx1
 y8qO1cOG3Fm53G3+vRnxehdrW3XR2IXO8i7AhW1l8sTUrPeh6wNOb+ige7uvDCcoiI
 jt6TPvT6gzjnMJk0wW4hMsg4/CyGJJ7yio5prkeU=
Date: Wed, 3 Oct 2018 15:42:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v3 22/33] KVM: PPC: Book3S HV: Handle page fault for a
 nested guest
Message-ID: <20181003054208.GR1886@umbus.fritz.box>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
 <1538479892-14835-23-git-send-email-paulus@ozlabs.org>
 <20181003053913.GP1886@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ngPZezdD7QsvFaqQ"
Content-Disposition: inline
In-Reply-To: <20181003053913.GP1886@umbus.fritz.box>
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


--ngPZezdD7QsvFaqQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2018 at 03:39:13PM +1000, David Gibson wrote:
> On Tue, Oct 02, 2018 at 09:31:21PM +1000, Paul Mackerras wrote:
> > From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> >=20
> > Consider a normal (L1) guest running under the main hypervisor (L0),
> > and then a nested guest (L2) running under the L1 guest which is acting
> > as a nested hypervisor. L0 has page tables to map the address space for
> > L1 providing the translation from L1 real address -> L0 real address;
> >=20
> > 	L1
> > 	|
> > 	| (L1 -> L0)
> > 	|
> > 	----> L0
> >=20
> > There are also page tables in L1 used to map the address space for L2
> > providing the translation from L2 real address -> L1 read address. Since
> > the hardware can only walk a single level of page table, we need to
> > maintain in L0 a "shadow_pgtable" for L2 which provides the translation
> > from L2 real address -> L0 real address. Which looks like;
> >=20
> > 	L2				L2
> > 	|				|
> > 	| (L2 -> L1)			|
> > 	|				|
> > 	----> L1			| (L2 -> L0)
> > 	      |				|
> > 	      | (L1 -> L0)		|
> > 	      |				|
> > 	      ----> L0			--------> L0
> >=20
> > When a page fault occurs while running a nested (L2) guest we need to
> > insert a pte into this "shadow_pgtable" for the L2 -> L0 mapping. To
> > do this we need to:
> >=20
> > 1. Walk the pgtable in L1 memory to find the L2 -> L1 mapping, and
> >    provide a page fault to L1 if this mapping doesn't exist.
> > 2. Use our L1 -> L0 pgtable to convert this L1 address to an L0 address,
> >    or try to insert a pte for that mapping if it doesn't exist.
> > 3. Now we have a L2 -> L0 mapping, insert this into our shadow_pgtable
> >=20
> > Once this mapping exists we can take rc faults when hardware is unable
> > to automatically set the reference and change bits in the pte. On these
> > we need to:
> >=20
> > 1. Check the rc bits on the L2 -> L1 pte match, and otherwise reflect
> >    the fault down to L1.
> > 2. Set the rc bits in the L1 -> L0 pte which corresponds to the same
> >    host page.
> > 3. Set the rc bits in the L2 -> L0 pte.
> >=20
> > As we reuse a large number of functions in book3s_64_mmu_radix.c for
> > this we also needed to refactor a number of these functions to take
> > an lpid parameter so that the correct lpid is used for tlb invalidation=
s.
> > The functionality however has remained the same.
> >=20
> > Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> > Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
>=20
> Some comments below, but no showstoppers, so,
>=20
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

One more, again not a showstopper:

> > @@ -393,10 +396,20 @@ struct kvm_nested_guest *kvmhv_alloc_nested(struc=
t kvm *kvm, unsigned int lpid)
> >   */
> >  static void kvmhv_release_nested(struct kvm_nested_guest *gp)
> >  {
> > +	struct kvm *kvm =3D gp->l1_host;
> > +
> > +	if (gp->shadow_pgtable) {
> > +		/*
> > +		 * No vcpu is using this struct and no call to
> > +		 * kvmhv_remove_nest_rmap can find this struct,

It's kind of dubious that you're referring to kvmhv_remove_nest_rmap()
a patch before it is introduced.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ngPZezdD7QsvFaqQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu0VrAACgkQbDjKyiDZ
s5IxwBAAmT7/2xc5HI7TqZL7vCqMjoBHrri9Q0/zKXcDeOCB+KxtoZiPzk5qA563
S5SCPQELLVJsDUFDqDsTZXICKSkFlA78ke6iJ/CzxMqzKRCqVgzRQsT0I9fXoD0f
EpN+Y5aucARY8OAC5fYNpJL+xKJVdgaSSmB76MrEEP5lEjy+xBymUF6kaNOSDbvT
UaZNFnHKcv/H44DD/fnu6BFJcx6Oa1smDLuxJFyHNUWO6EFocqdaLBX6TxduzZYa
5IdRE2qWL0wQETeixbaNIMgG5QvzxTooH2mWc6+XD0gW9pP5YEmnORIFvf54HmLg
2+SqMxR/yI7EYr0bkr3goauAwgVN23q08mUtMmIzTM6YroINrH6agJMCcVGa5ary
roQmZEfqkCHw9RXCppOQ93kgVdADEjr8FwJBy/DFEKWc3Clxv9XUWUXS9P1gQ/pB
RqjesDUyYNIsdXPIlplZl/O+b8IoZJYKSYTdg/CE4pmoh89RSQiv2fTyCyHjWCjG
m2kwpVd5NEBKNLw8OzeNlMooPrG7t5e/1oSIzuzmZ3os5e804gA0jL99f392HAMn
CrsnzzR37xqt4AGSgHkIiua6/pRF4Wh5gdAUPLbubeMhW7OdBl7tt/G1zCOE4c2E
2mRawL/hjgnNialh0EfSQyH6hGCy4SprANIIsIvINYQxdjiBozI=
=ll3v
-----END PGP SIGNATURE-----

--ngPZezdD7QsvFaqQ--
