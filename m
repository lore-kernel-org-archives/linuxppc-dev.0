Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532A3C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:36:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 996EA2089F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="a3hpVk0k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996EA2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q5rx4wL3zF3Jd
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 16:36:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="a3hpVk0k";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q5X303SBzF3C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 16:21:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="a3hpVk0k"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Q5X26cSfzB4MW; Wed,  3 Oct 2018 16:21:54 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Q5X2646wz9sBk; Wed,  3 Oct 2018 16:21:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538547714;
 bh=Tm18TqjS0jvHmvmdHc0KklksB/i3IjsmohZqzXCN0S4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a3hpVk0k5TCp0dpDzqDb0bcL/92GO1gQMPdGKGekn/8Q7VSMjwGeaRm3zGiSjQieN
 jspkMKJJhYeiwqtYZVRAcdfhR28DJCXm8luXpvfIopqMDn/JQzVEv5fmk8+dwXMSoT
 AhW3EbD3WZqft84g0HTGyaDj8d8pJrDmCDuI7FF0=
Date: Wed, 3 Oct 2018 16:13:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v3 29/33] KVM: PPC: Book3S HV: Handle differing
 endianness for H_ENTER_NESTED
Message-ID: <20181003061336.GV1886@umbus.fritz.box>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
 <1538479892-14835-30-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VvnGyWaJ9JuxX38U"
Content-Disposition: inline
In-Reply-To: <1538479892-14835-30-git-send-email-paulus@ozlabs.org>
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


--VvnGyWaJ9JuxX38U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 02, 2018 at 09:31:28PM +1000, Paul Mackerras wrote:
> From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>=20
> The hcall H_ENTER_NESTED takes as the two parameters the address in
> L1 guest memory of a hv_regs struct and a pt_regs struct which the
> L1 guest would like to use to run a L2 guest and in which are returned
> the exit state of the L2 guest.  For efficiency, these are in the
> endianness of the L1 guest, rather than being always big-endian as is
> usually the case for PAPR hypercalls.

Does that actually make a difference for efficiency?  I thought the
presence of the byte-reversing loads and stores meant byteswapping was
basically zero-cost on POWER.

> When reading/writing these structures, this patch handles the case
> where the endianness of the L1 guest differs from that of the L0
> hypervisor, by byteswapping the structures after reading and before
> writing them back.
>=20
> Since all the fields of the pt_regs are of the same type, i.e.,
> unsigned long, we treat it as an array of unsigned longs.  The fields
> of struct hv_guest_state are not all the same, so its fields are
> byteswapped individually.
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Looks correct, though, so

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kvm/book3s_hv_nested.c | 51 +++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 50 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_hv_nested.c b/arch/powerpc/kvm/book3=
s_hv_nested.c
> index 7b1088a..228dc11 100644
> --- a/arch/powerpc/kvm/book3s_hv_nested.c
> +++ b/arch/powerpc/kvm/book3s_hv_nested.c
> @@ -51,6 +51,48 @@ void kvmhv_save_hv_regs(struct kvm_vcpu *vcpu, struct =
hv_guest_state *hr)
>  	hr->ppr =3D vcpu->arch.ppr;
>  }
> =20
> +static void byteswap_pt_regs(struct pt_regs *regs)
> +{
> +	unsigned long *addr =3D (unsigned long *) regs;
> +
> +	for (; addr < ((unsigned long *) (regs + 1)); addr++)
> +		*addr =3D swab64(*addr);
> +}
> +
> +static void byteswap_hv_regs(struct hv_guest_state *hr)
> +{
> +	hr->version =3D swab64(hr->version);
> +	hr->lpid =3D swab32(hr->lpid);
> +	hr->vcpu_token =3D swab32(hr->vcpu_token);
> +	hr->lpcr =3D swab64(hr->lpcr);
> +	hr->pcr =3D swab64(hr->pcr);
> +	hr->amor =3D swab64(hr->amor);
> +	hr->dpdes =3D swab64(hr->dpdes);
> +	hr->hfscr =3D swab64(hr->hfscr);
> +	hr->tb_offset =3D swab64(hr->tb_offset);
> +	hr->dawr0 =3D swab64(hr->dawr0);
> +	hr->dawrx0 =3D swab64(hr->dawrx0);
> +	hr->ciabr =3D swab64(hr->ciabr);
> +	hr->hdec_expiry =3D swab64(hr->hdec_expiry);
> +	hr->purr =3D swab64(hr->purr);
> +	hr->spurr =3D swab64(hr->spurr);
> +	hr->ic =3D swab64(hr->ic);
> +	hr->vtb =3D swab64(hr->vtb);
> +	hr->hdar =3D swab64(hr->hdar);
> +	hr->hdsisr =3D swab64(hr->hdsisr);
> +	hr->heir =3D swab64(hr->heir);
> +	hr->asdr =3D swab64(hr->asdr);
> +	hr->srr0 =3D swab64(hr->srr0);
> +	hr->srr1 =3D swab64(hr->srr1);
> +	hr->sprg[0] =3D swab64(hr->sprg[0]);
> +	hr->sprg[1] =3D swab64(hr->sprg[1]);
> +	hr->sprg[2] =3D swab64(hr->sprg[2]);
> +	hr->sprg[3] =3D swab64(hr->sprg[3]);
> +	hr->pidr =3D swab64(hr->pidr);
> +	hr->cfar =3D swab64(hr->cfar);
> +	hr->ppr =3D swab64(hr->ppr);
> +}
> +
>  static void save_hv_return_state(struct kvm_vcpu *vcpu, int trap,
>  				 struct hv_guest_state *hr)
>  {
> @@ -175,6 +217,8 @@ long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu)
>  				  sizeof(struct hv_guest_state));
>  	if (err)
>  		return H_PARAMETER;
> +	if (kvmppc_need_byteswap(vcpu))
> +		byteswap_hv_regs(&l2_hv);
>  	if (l2_hv.version !=3D HV_GUEST_STATE_VERSION)
>  		return H_P2;
> =20
> @@ -183,7 +227,8 @@ long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu)
>  				  sizeof(struct pt_regs));
>  	if (err)
>  		return H_PARAMETER;
> -
> +	if (kvmppc_need_byteswap(vcpu))
> +		byteswap_pt_regs(&l2_regs);
>  	if (l2_hv.vcpu_token >=3D NR_CPUS)
>  		return H_PARAMETER;
> =20
> @@ -255,6 +300,10 @@ long kvmhv_enter_nested_guest(struct kvm_vcpu *vcpu)
>  	kvmhv_put_nested(l2);
> =20
>  	/* copy l2_hv_state and regs back to guest */
> +	if (kvmppc_need_byteswap(vcpu)) {
> +		byteswap_hv_regs(&l2_hv);
> +		byteswap_pt_regs(&l2_regs);
> +	}
>  	err =3D kvm_vcpu_write_guest(vcpu, hv_ptr, &l2_hv,
>  				   sizeof(struct hv_guest_state));
>  	if (err)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VvnGyWaJ9JuxX38U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu0XhAACgkQbDjKyiDZ
s5L5VxAAjJWtbbYBPg3C4SSSgwGcjNMEm7c9qRXOdJs+bbatfSx+XDHKV2pO1pqW
j7/JBQ7LZc6vSjs0WlzAn7paTFp6A7npQHlzuzTt86DxXOOqnCpWdVa65rRq7PiE
LbujEaijcoMYV+gNOwUaV7UpKShOwvIZuiOxy8HqOnDFpuAJU1cC7GbDLvVuyw69
1CnpTzkAJXfkSq1JowdjGy3FkGwCHyexwEpr40aRTPfHYKft6GsuaY7Zq6Jyv7Gx
PJzNQZnN07WaQBxfrbLHgZFXpVDw0RJ1Zbrajv5pKxVki/XoRSxHYv/G1g6kTsOM
qFBsdWk0k5WC/AaijfTo9737aOpvTbUmItSUzcRejdi4W6jzOQej2lwdCsr7y08h
/V1Exp/2naSjbX+Pyl2hg8qLtxlLJZX7fLOsExZM2fA1jPu2E4vVJUtTzr9WlCP+
0SrVU0lwWgL+XpSENpQ1VyV0hOo+D3OmQ5oWcrmkGc8yQtR1vSFXrgiQKDuUHAFv
SFE2e3AcdqvBeDNX+jBCXx7NuGlvLDISZoMWZzTm+1CdZAqmN1zEUoAqOqehFICO
dUm1IBeqEP/O6q2WRK6t3GMcZ30xUAnIi0Pe8A38ckkAExsGnLvLdWU8PbT54cwT
CPa4fOVAFK/1bcRNNloEavGdpuAs7z9iJsqdMpJxZG18SihTi7o=
=JQW/
-----END PGP SIGNATURE-----

--VvnGyWaJ9JuxX38U--
