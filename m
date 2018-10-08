Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA84C67879
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 00:59:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA2E2087D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 00:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YRgyERYk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA2E2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Tf4r625jzF3Dc
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 11:59:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YRgyERYk";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tf1z6xh9zF3Bm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 11:56:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="YRgyERYk"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Tf1z6BGlzB4N5; Tue,  9 Oct 2018 11:56:39 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Tf1z5CxgzB2xk; Tue,  9 Oct 2018 11:56:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1539046599;
 bh=oNgLtnsly/yz+M4vj1NHy52VK2/1hnpOFcrYG5gjITU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YRgyERYkSnVzqddB/dBI9RYnZ9r6oyJVu+pwTI8CJFHi1Bi4fuSh9PzZ7q4v/vI7I
 wzyrNFGU3cewcZ4oTCyrFp+KlvjzBMWz199ycTshI1bYlfNV8tM3qIwvCyHhL9+XTp
 oaoutsCfSqbOs2DY7mw+aogw1FZ5QsXobXfINTtc=
Date: Tue, 9 Oct 2018 10:31:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v5 30/33] KVM: PPC: Book3S HV: Allow HV module to load
 without hypervisor mode
Message-ID: <20181008233150.GB7004@umbus.fritz.box>
References: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
 <1538976679-1363-31-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6FinHCQBQ0zFDOqT"
Content-Disposition: inline
In-Reply-To: <1538976679-1363-31-git-send-email-paulus@ozlabs.org>
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


--6FinHCQBQ0zFDOqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 04:31:16PM +1100, Paul Mackerras wrote:
> With this, the KVM-HV module can be loaded in a guest running under
> KVM-HV, and if the hypervisor supports nested virtualization, this
> guest can now act as a nested hypervisor and run nested guests.
>=20
> This also adds some checks to inform userspace that HPT guests are not
> supported by nested hypervisors (by returning false for the
> KVM_CAP_PPC_MMU_HASH_V3 capability), and to prevent userspace from
> configuring a guest to use HPT mode.
>=20
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kvm/book3s_hv.c | 16 ++++++++++++----
>  arch/powerpc/kvm/powerpc.c   |  3 ++-
>  2 files changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 127bb5f..152bf75 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -4807,11 +4807,15 @@ static int kvmppc_core_emulate_mfspr_hv(struct kv=
m_vcpu *vcpu, int sprn,
> =20
>  static int kvmppc_core_check_processor_compat_hv(void)
>  {
> -	if (!cpu_has_feature(CPU_FTR_HVMODE) ||
> -	    !cpu_has_feature(CPU_FTR_ARCH_206))
> -		return -EIO;
> +	if (cpu_has_feature(CPU_FTR_HVMODE) &&
> +	    cpu_has_feature(CPU_FTR_ARCH_206))
> +		return 0;
> =20
> -	return 0;
> +	/* POWER9 in radix mode is capable of being a nested hypervisor. */
> +	if (cpu_has_feature(CPU_FTR_ARCH_300) && radix_enabled())
> +		return 0;
> +
> +	return -EIO;
>  }
> =20
>  #ifdef CONFIG_KVM_XICS
> @@ -5129,6 +5133,10 @@ static int kvmhv_configure_mmu(struct kvm *kvm, st=
ruct kvm_ppc_mmuv3_cfg *cfg)
>  	if (radix && !radix_enabled())
>  		return -EINVAL;
> =20
> +	/* If we're a nested hypervisor, we currently only support radix */
> +	if (kvmhv_on_pseries() && !radix)
> +		return -EINVAL;
> +
>  	mutex_lock(&kvm->lock);
>  	if (radix !=3D kvm_is_radix(kvm)) {
>  		if (kvm->arch.mmu_ready) {
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index eba5756..1f4b128 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -594,7 +594,8 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, lon=
g ext)
>  		r =3D !!(hv_enabled && radix_enabled());
>  		break;
>  	case KVM_CAP_PPC_MMU_HASH_V3:
> -		r =3D !!(hv_enabled && cpu_has_feature(CPU_FTR_ARCH_300));
> +		r =3D !!(hv_enabled && cpu_has_feature(CPU_FTR_ARCH_300) &&
> +		       cpu_has_feature(CPU_FTR_HVMODE));
>  		break;
>  #endif
>  	case KVM_CAP_SYNC_MMU:

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6FinHCQBQ0zFDOqT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu76OYACgkQbDjKyiDZ
s5IyQA/+PL6E7riVc4WSZotsykKzjOM248m7zui9cogKQfXWG2/6a31g4iQXKXI+
yo2SLsekvmD4TVFYxCZTuyKd05ThY9Gvwc/WQK+YpTbOmiV4JiEwqigkpJXMceeg
jmFGwucFb+jqB5zkiLuR0lE7HjX7WGA5SUMECvJgc40kI9yZBIi8UYp36ZYd52M/
ws5lGygx2hIA+uarV9B7RdHpiLo8Vjc8JAPVpx8bdTBwEhHXfTdJlwreY4jA7RKn
Rc19gmFgwXvoh6PCTvbvksitMDYg2t7oh8yB3vc+nA3w96dabZ9E7c4bcLG3kIPm
K/SX1C1tLngiRsZIaySBPL9oQk9jSWwf+xunn7qGGblhQ8YJBIaLixDafUrgfxRH
WwCJ8ahglGceMLU6yzz8en9CztAhCcip43r02j18onGWdJzyJVXoixFZejiDeWS6
k8HGG+YI+N4If2cXGvOirTwBkcJlrUPbWm92wnieVUVfdGY8mC+GCqj28SxpKdjK
hrHSeD5PQury0spsLEST2TofCK/+helHJ071k6MGRcfN3AYda3U12IQcHY5Lwfb0
Gj5K1XRaEs8mA3Xcv7fgXt4+D2r95PRc+YuAwcQ/9X59+NaiPgfeH+sQmkgKb3Ct
LU24LT8YXf5xLf3hNOuJMjy0FVAP4Q6mS+dIcapKtw3zv0rEFjE=
=Qxg8
-----END PGP SIGNATURE-----

--6FinHCQBQ0zFDOqT--
