Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B093C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 05:23:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4509D206B2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 05:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KTmYmu29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4509D206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q4D31Cb7zF38m
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 15:22:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KTmYmu29";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q43m3HmRzF325
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 15:15:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="KTmYmu29"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Q43m2RKDz9sBN; Wed,  3 Oct 2018 15:15:48 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Q43m1kCYz9s8J; Wed,  3 Oct 2018 15:15:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538543748;
 bh=ZzCjvadYs2nFfQjnWOnIBPOUzXod2m0+uVmRYOtbtMo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KTmYmu29SWqC3ZxRruzXcypGUj7DTflOF0G1VQf8QT6k580Gq7atDfvV5WT5r0qYa
 Cl7Yeo0yhtaXToLfGVtKoWSuF5uQu933gRk1+8dZHiZCdxI+2yayYyY2IFe84USa5T
 T4Ko4koDVshyHwNQKBCGh4SnPtclwr5xWm6AcaOE=
Date: Wed, 3 Oct 2018 13:17:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v3 17/33] KVM: PPC: Book3S HV: Framework and hcall stubs
 for nested virtualization
Message-ID: <20181003031739.GM1886@umbus.fritz.box>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
 <1538479892-14835-18-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="t5NgoZwlhlUmGr82"
Content-Disposition: inline
In-Reply-To: <1538479892-14835-18-git-send-email-paulus@ozlabs.org>
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


--t5NgoZwlhlUmGr82
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 02, 2018 at 09:31:16PM +1000, Paul Mackerras wrote:
> This starts the process of adding the code to support nested HV-style
> virtualization.  It defines a new H_SET_PARTITION_TABLE hypercall which
> a nested hypervisor can use to set the base address and size of a
> partition table in its memory (analogous to the PTCR register).
> On the host (level 0 hypervisor) side, the H_SET_PARTITION_TABLE
> hypercall from the guest is handled by code that saves the virtual
> PTCR value for the guest.
>=20
> This also adds code for creating and destroying nested guests and for
> reading the partition table entry for a nested guest from L1 memory.
> Each nested guest has its own shadow LPID value, different in general
> from the LPID value used by the nested hypervisor to refer to it.  The
> shadow LPID value is allocated at nested guest creation time.
>=20
> Nested hypervisor functionality is only available for a radix guest,
> which therefore means a radix host on a POWER9 (or later) processor.
>=20
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Couple of nits noted below

[snip]
> +void kvmhv_set_ptbl_entry(unsigned int lpid, u64 dw0, u64 dw1)
> +{
> +	if (cpu_has_feature(CPU_FTR_HVMODE)) {
> +		mmu_partition_table_set_entry(lpid, dw0, dw1);
> +	} else {
> +		pseries_partition_tb[lpid].patb0 =3D cpu_to_be64(dw0);
> +		pseries_partition_tb[lpid].patb1 =3D cpu_to_be64(dw1);
> +		/* this will be emulated, L0 will do the necessary barriers */
> +		asm volatile(PPC_TLBIE_5(%0, %1, 2, 0, 1) : :
> +			     "r" (TLBIEL_INVAL_SET_LPID), "r" (lpid));

It seems a bit odd to me to introduce this with a mechanism we never
actually implement, then replace it.  But I guess if refolding the
series is painful..

> +	}

[snip]
> +/*
> + * Handle the H_SET_PARTITION_TABLE hcall.
> + * r4 =3D guest real address of partition table + log_2(size) - 12
> + * (formatted as for the PTCR).
> + */
> +long kvmhv_set_partition_table(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm *kvm =3D vcpu->kvm;
> +	unsigned long ptcr =3D kvmppc_get_gpr(vcpu, 4);
> +
> +	kvm->arch.l1_ptcr =3D ptcr;

Still no validation here.

> +	return H_SUCCESS;
> +}


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--t5NgoZwlhlUmGr82
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu0NNEACgkQbDjKyiDZ
s5LHGxAAzxiPF0oLCNfNU9DwmHch+2gdf69VU9tja4A83IMkdgjn8z0nzVvZQNxs
mwt7UxxBIcrAV4mXojW71rT2C0IoJryJ/JwEL/j+0cBbbSzgApLhUmy72uN9XJCc
7PIhWNd0X1bMcUOtaX1gRrpwkZV5KrHQrbXqxdRy1IDM9dJiQ8/idMLjzDu5xK+M
h4nY721KxkMHZsULaW78JGza6GdO+LQ7W5wWW4FLfs6Vnd+kKDQmAtzI0887DKNE
nIOaht4OgTU5VXkRbmjx+735gBoNKulwQkDalDwSdk6QbSbXbzY4mjq0kH0ks0Ao
h1e/sAl5JELZGzMK/CYmLv4T8Hh/YaCVRqAA+C5XqFiIchEP8V9A7v1kilbkW8rV
Cd2bkCyyQBPWbgzveh5RlsGPTfoi6d0f0UFV1nu3MTxtop3CbFSG1qQqFYATJcYs
BULYdR3pHYoKbeR64rZt31pM+hEXwCNVnwpx+f02VKJxISQBrr9aTXt0/JgMAhMh
vflHaI8ZxX0S6Sd2opd21noVq1fzPvqJ0TGG6DhXdrzkZkchtok5UzcP9t2Ac2QX
FjqKpvJjO34nPoNm+FeHetoQQ4Svwld1lstl1zWoBxImH6cvH4dxKhGciZMaG46W
vbGsM1yrd3A4kWX0IlBVLOI4nXEGPTqGVBIe33LvY6lM4dyPRI8=
=Pzfx
-----END PGP SIGNATURE-----

--t5NgoZwlhlUmGr82--
