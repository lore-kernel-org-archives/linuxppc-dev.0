Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EB8C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 04:51:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78D41214C3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 04:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="C8GIr4K4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78D41214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Zfsd62RLzF3Xx
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 15:51:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="C8GIr4K4";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Zfq06SYWzF3Xc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 15:49:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="C8GIr4K4"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Zfq05BTJz9sC2; Wed, 17 Oct 2018 15:49:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1539751772;
 bh=qvCRm79Pz2KdC9MALRtWpenzksNa8W0cXqzChDTbF60=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C8GIr4K4Xv4L9pShz44niUjCPW4/u13U3c1xaP50nPv15Ai2LOIHuTCmyyH1ewiHU
 OVJKTMQ4Tyw0YyhXB/kRHSRaQ8djctuUGMj5UaThdHFGQ0NJ5RFBgXhsswdsVDoGXM
 ixHf6oeNLDsRN42XMxE5Aw50DxInk3YTGlEYMsos=
Date: Wed, 17 Oct 2018 15:45:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel 3/4] powerpc/mm/iommu: Make mm_iommu_new() fail on
 existing regions
Message-ID: <20181017044548.GD30180@umbus.fritz.box>
References: <20181015092416.47380-1-aik@ozlabs.ru>
 <20181015092416.47380-4-aik@ozlabs.ru>
 <20181017010022.GA30180@umbus.fritz.box>
 <39886bd3-5122-de68-f167-e010a1d12c33@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Content-Disposition: inline
In-Reply-To: <39886bd3-5122-de68-f167-e010a1d12c33@ozlabs.ru>
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
Cc: Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 17, 2018 at 02:34:32PM +1100, Alexey Kardashevskiy wrote:
>=20
>=20
> On 17/10/2018 12:00, David Gibson wrote:
> > On Mon, Oct 15, 2018 at 08:24:15PM +1100, Alexey Kardashevskiy wrote:
> >> Since we are going to have 2 different preregistering helpers, let's
> >> make it clear that mm_iommu_new() is only for the normal (i.e. not dev=
ice)
> >> memory and for existing areas mm_iommu_get() should be used instead.
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >=20
> > I think the idea is sensible.  However (and, yes, this is really an
> > existing bug) - shouldn't we check for a request to add anything
> > overlapping with an existing region, not just one that exactly
> > matches?
>=20
> The overlap check is below the changed hunk:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/powerpc/mm/mmu_context_iommu.c#n150

Ah, right.

In that case can't you just drop this whole if.  I don't see that
there's any use in giving different error codes for "tried to register
exactly a region you registered before" and "tried to register a
region overlapping one you registered before.


>=20
>=20
> >=20
> >> ---
> >>  arch/powerpc/mm/mmu_context_iommu.c | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu=
_context_iommu.c
> >> index a8c4a3c..839dbce 100644
> >> --- a/arch/powerpc/mm/mmu_context_iommu.c
> >> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> >> @@ -141,8 +141,7 @@ long mm_iommu_new(struct mm_struct *mm, unsigned l=
ong ua, unsigned long entries,
> >>  	list_for_each_entry_rcu(mem, &mm->context.iommu_group_mem_list,
> >>  			next) {
> >>  		if ((mem->ua =3D=3D ua) && (mem->entries =3D=3D entries)) {
> >> -			++mem->used;
> >> -			*pmem =3D mem;
> >> +			ret =3D -EBUSY;
> >>  			goto unlock_exit;
> >>  		}
> >> =20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlvGvnoACgkQbDjKyiDZ
s5J9ng//YU51Mvb9QxrZQjAv+13YxOFX3vneViU0EiYPYJd7HDcTJ3i7eht8BtJM
ynfAo0HzIjTg52eAewBXfIEdhVmsoflntsE4ZbIW15UzS22kl3vcEm8hYKpp4EmW
XXU4NjaV+4tF0VpZ/61gBFOG4EuQ2Hf9Bqy4eJoDa/MwE0F9nzwUqXjSNReQI9ft
SIQgVebvMkjffXsdiRmhqSp0KL5Xa1hqUCAZepEy3nXcOyKlbhNogkolaSfgv8xF
2ZWtlSJ8GH1GtVXG0burYkabd80oym2C7USk2bxCPmplVSw+pcIrY0CJRN9I+UVi
nAJQGmGrk4oXwQX9UPJxFMvztGv0BnIm8l9WGwKwq1pCOWa2Zo0FbnUU6Z4YoQK7
ssfzQK3ZFywtXozogRmSGMvX3YjZQBWpvAhVfO87I48W63eABLyeUqd5T4zu3j35
E+pPHZEsPBVtUb1lhP4WeRz37ptO0Uu3zHTYX4hzWyrkHtecR5UkOH2vFj8+v7QN
Qv3eMvQUGCSWKkpHcMLmhhdXeT6Y0QpUbf6NjYhjEMJB3Vm1irNdT/RCI8PdoN3m
Jtl5sABFZZzT+ySW8wnL28JgrWi2BA0R0lDeFYkD+D1x7PV2jMCPcQc4ikbL1kZx
GsH2TuAu6jAv8cVAVfIs8/f2fDaDkkSpOoq2wTAzII+2Gx/wD3Q=
=9aql
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--
