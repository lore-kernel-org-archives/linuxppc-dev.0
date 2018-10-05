Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3EEC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:19:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF8420834
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="H4nghGfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF8420834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RJ2z2L4WzF3L2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 15:19:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="H4nghGfR";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RGjX3wckzDrBy
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 14:19:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="H4nghGfR"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42RGjX3Q1hz9sBN; Fri,  5 Oct 2018 14:19:12 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42RGjX2Z11z9sCr; Fri,  5 Oct 2018 14:19:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538713152;
 bh=+7R98kGgdMpkaWgsTSa27WK+tyjoGYepf59g6QWw66A=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=H4nghGfRCQb/45gb5ddXmjq/Zwwq6AXMQ4g4ysq4Y8GQfiv3rwYrD3q3jyeniIRud
 a16w+ZQctOTKJrL32wndv0myptSZ68bofdWmt9ElHIXJYYRuJ12EFLprSuq3VSgCE9
 weSyOI5uC8LpSDz/M0a8rQ4i3IfJJts4MSaod220=
Date: Fri, 5 Oct 2018 13:40:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v4 23/32] KVM: PPC: Book3S HV: Implement H_TLB_INVALIDATE
 hcall
Message-ID: <20181005034047.GI7004@umbus.fritz.box>
References: <1538654169-15602-1-git-send-email-paulus@ozlabs.org>
 <1538654169-15602-24-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="itqfrb9Qq3wY07cp"
Content-Disposition: inline
In-Reply-To: <1538654169-15602-24-git-send-email-paulus@ozlabs.org>
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


--itqfrb9Qq3wY07cp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 04, 2018 at 09:56:00PM +1000, Paul Mackerras wrote:
11;rgb:ffff/ffff/ffff> From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>=20
> When running a nested (L2) guest the guest (L1) hypervisor will use
> the H_TLB_INVALIDATE hcall when it needs to change the partition
> scoped page tables or the partition table which it manages.  It will
> use this hcall in the situations where it would use a partition-scoped
> tlbie instruction if it were running in hypervisor mode.
>=20
> The H_TLB_INVALIDATE hcall can invalidate different scopes:
>=20
> Invalidate TLB for a given target address:
> - This invalidates a single L2 -> L1 pte
> - We need to invalidate any L2 -> L0 shadow_pgtable ptes which map the L2
>   address space which is being invalidated. This is because a single
>   L2 -> L1 pte may have been mapped with more than one pte in the
>   L2 -> L0 page tables.
>=20
> Invalidate the entire TLB for a given LPID or for all LPIDs:
> - Invalidate the entire shadow_pgtable for a given nested guest, or
>   for all nested guests.
>=20
> Invalidate the PWC (page walk cache) for a given LPID or for all LPIDs:
> - We don't cache the PWC, so nothing to do.
>=20
> Invalidate the entire TLB, PWC and partition table for a given/all LPIDs:
> - Here we re-read the partition table entry and remove the nested state
>   for any nested guest for which the first doubleword of the partition
>   table entry is now zero.
>=20
> The H_TLB_INVALIDATE hcall takes as parameters the tlbie instruction
> word (of which only the RIC, PRS and R fields are used), the rS value
> (giving the lpid, where required) and the rB value (giving the IS, AP
> and EPN values).
>=20
> [paulus@ozlabs.org - adapted to having the partition table in guest
> memory, added the H_TLB_INVALIDATE implementation, removed tlbie
> instruction emulation, reworded the commit message.]
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

That said, there's one change I think could make it substantially
easier to read..

[snip]
> +static int kvmhv_emulate_tlbie_tlb_addr(struct kvm_vcpu *vcpu, int lpid,
> +					int ap, long epn)
> +{
> +	struct kvm *kvm =3D vcpu->kvm;
> +	struct kvm_nested_guest *gp;
> +	long npages;
> +	int shift;
> +	unsigned long addr;
> +
> +	shift =3D ap_to_shift(ap);
> +	addr =3D epn << 12;
> +	if (shift < 0)
> +		/* Invalid ap encoding */
> +		return -EINVAL;
> +
> +	addr &=3D ~((1UL << shift) - 1);
> +	npages =3D 1UL << (shift - PAGE_SHIFT);
> +
> +	gp =3D kvmhv_get_nested(kvm, lpid, false);
> +	if (!gp) /* No such guest -> nothing to do */
> +		return 0;
> +	mutex_lock(&gp->tlb_lock);
> +
> +	/* There may be more than one host page backing this single guest pte */
> +	do {
> +		kvmhv_invalidate_shadow_pte(vcpu, gp, addr, &shift);
> +
> +		npages -=3D 1UL << (shift - PAGE_SHIFT);
> +		addr +=3D 1UL << shift;

I read this about 6 times before realizing that 'shift' here has a
different value to what it did before the loop (which it has to in
order to be correct).  I'd suggest a loop local variable with a
different name (maybe 'shadow_shift') to make that more obvious.
--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--itqfrb9Qq3wY07cp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu23TwACgkQbDjKyiDZ
s5IU7A//b5Oa0tE4mrci6tjOXKF2wjFGMVzr3qzi2vfLXvijCNyZb1503NaYJ7wQ
p5sQ7xe77VllqDZKUeeW66ygvwI47VJnkFITj4iU3OvPaxx1iNuxtVVN472p84gc
CCMYW6ABOz4uzo4pMfTIxRJBHsPor1ivE8s6f0ggXt+p/oTE6ISs4PUTv+emfgSq
ivetPtKvjT4UMk2Gj33iHTqYp4aBZJzogg9gezSX8re9bZ1yOKU6DVSQPmDOdmOf
5Pooe1ID/b8DWAvDgVSmo43ql/RKRdgzMMEB5jL2tPhjatQgQTGS8w/84LqCqv2K
4E46CfMUwiPeVJghQOG2AiGhZCsgHFtUDmSRpR7egKudLIIx8pdiENfB0JuVgIIz
IYV8rbNdf9D/9SO0RQeYxYrLwf3DFYb6GlqvP/sShklbsDEOe/Ux3GFvzpBt5RzN
VpaS/ey3/IYpsK1QxsxYJasioSuPLvO4WggRA3yayEs/Y2VLyRjB3Vng6l36Cpo/
vu5WOrOg75WZ56Zagvd5S51CMuNDJ+su2TAgvb9/AIBqi/F260xcMGk+xhhMQmSe
k0PSfoy5s/XaiChFjWTEQ57SOnMK9bWpA3nUgIn4ZzKyM3IDefUW4eSgpLHLIBEO
PmTw/MoioxksVcSQE/imrFMwW0dk3wBycq1nVLgxfVmue3+ejcU=
=aigY
-----END PGP SIGNATURE-----

--itqfrb9Qq3wY07cp--
