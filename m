Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9754BC00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:34:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3F322089F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 06:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dndVNny7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F322089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q5pD0674zF3JW
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 16:34:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="dndVNny7";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q5X42mkvzF3F0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 16:21:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="dndVNny7"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Q5X320r9zB4Mj; Wed,  3 Oct 2018 16:21:55 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Q5X31Kydz9sRp; Wed,  3 Oct 2018 16:21:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538547715;
 bh=AK41ddedDoTTv9MzMU5i5Rw0fy58oH3cPiVyFlDDakg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dndVNny7nwKp0XhpQecxHsHQEMzHAbNw060AbJ9oVdW43AcKXnPoHj7ebNxaSGcbC
 vsf/irEurCfR08AT7SDEoXXBJ3EMq5fcaKHrRsloh5zhh/2U89Aegw4BRkWLX7SkOD
 0NuBelaevlybfAjswFPue8BSbS1XVJOyS0UY1Vto=
Date: Wed, 3 Oct 2018 16:15:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v3 30/33] KVM: PPC: Book3S HV: Allow HV module to load
 without hypervisor mode
Message-ID: <20181003061514.GW1886@umbus.fritz.box>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
 <1538479892-14835-31-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iytlPraCFSCqrfnM"
Content-Disposition: inline
In-Reply-To: <1538479892-14835-31-git-send-email-paulus@ozlabs.org>
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


--iytlPraCFSCqrfnM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 02, 2018 at 09:31:29PM +1000, Paul Mackerras wrote:
> With this, the KVM-HV module can be loaded in a guest running under
> KVM-HV, and if the hypervisor supports nested virtualization, this
> guest can now act as a nested hypervisor and run nested guests.
>=20
> This also adds some checks to inform userspace that HPT guests are not
> supported by nested hypervisors, and to prevent userspace from
> configuring a guest to use HPT mode.
>=20
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index f630e91..196bff1 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -4237,6 +4237,10 @@ static int kvm_vm_ioctl_get_smmu_info_hv(struct kv=
m *kvm,
>  {
>  	struct kvm_ppc_one_seg_page_size *sps;
> =20
> +	/* If we're a nested hypervisor, we only support radix guests */
> +	if (kvmhv_on_pseries())
> +		return -EINVAL;
> +
>  	/*
>  	 * POWER7, POWER8 and POWER9 all support 32 storage keys for data.
>  	 * POWER7 doesn't support keys for instruction accesses,
> @@ -4822,11 +4826,15 @@ static int kvmppc_core_emulate_mfspr_hv(struct kv=
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
> +	/* Can run as nested hypervisor on POWER9 in radix mode. */
> +	if (cpu_has_feature(CPU_FTR_ARCH_300) && radix_enabled())

Shouldn't we probe the parent hypervisor for ability to support nested
guests before we say "yes" here?

> +		return 0;
> +
> +	return -EIO;
>  }
> =20
>  #ifdef CONFIG_KVM_XICS
> @@ -5144,6 +5152,10 @@ static int kvmhv_configure_mmu(struct kvm *kvm, st=
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

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iytlPraCFSCqrfnM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu0XnIACgkQbDjKyiDZ
s5IdQg//fry5BXYJso3OTVaKcB9pz0hMU/cBG8TjNgJqnACFN+NORKtGqSg6OzQg
So+4VUC/KDtunKqktEGiDQuvzhhCJ1A668AI76s2NlTnjV2MpmbjhXfv7Fs8r6A3
ULidBoFMhIvC0KVBxS/pOr858zTGdZ6Zp6L1UYpIOhnfRATxVIl07o+nxQ7Km1CG
dcIcMIY23xElk0M1TBk2MxFH4N2D4S26vf6989F/Ocm8n3rOhzsiqR/j/H87IVLt
m11hsh/0B4YknxUNuD97K9pFdM2icPhCopfWuy16OeDiAnfu6wZBaand6RN46L3Z
96RVnkUxYaO0HiulUs45Kf9HuYAPw3F2vogHZAN4UEkNKd2t7l/EFLBBVMKRw2v8
3G98f65MviGlS/QWItB+WmrYu3B64MODEYka698KgZfEctJlvsrh4MXVp5ReDK58
j+p+ZQhnATaJ1Rh5fbixylKxjpY00phrIAJKU/VmxRJKGavXNMw3lmWqo0BDopvS
zWPh/j5FzySprW0aiox8E7QMqmUHdBiTkJNPX8uTl1jMW2E/3yCn8MZYSnKGPYfH
bQc8oqn07FqBh0RTySySZI5Rcasu7CUx69If1r/DW6o+QLckYaS0BpRMAFPkHRZV
gEjtyrjSzZPEzCbP+9zr00BixEzbTixLBs/Kn5oJEep2L95ITlY=
=k2Eg
-----END PGP SIGNATURE-----

--iytlPraCFSCqrfnM--
