Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACF4C67879
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 01:06:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CBA205C9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 01:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LIYb9EKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CBA205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TfF04LPgzF3BR
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 12:06:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LIYb9EKQ";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tf1z5gR7zF3Bh
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 11:56:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="LIYb9EKQ"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Tf1z4zNQzB4N4; Tue,  9 Oct 2018 11:56:39 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Tf1z4PLJz9sj4; Tue,  9 Oct 2018 11:56:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1539046599;
 bh=mtEa8ladPWG3Ks00Q9zRl0nANqrF2UbQsF6vG/c1bfs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LIYb9EKQDWtP99WWy9PbuW+aj50aL7AhTVSoMwJIk681gpHF0dzUirLutVvhJmP50
 DZE2/u30kGeYjaUuBiL5ROC+cpVu2gC0E7GpBhoq5YSbyi3Ufk8kFbMUz9zFJUvvhq
 IVhf+lRulmAf4LOAG1npPTC553UcYt9wd8WrhtvE=
Date: Tue, 9 Oct 2018 10:34:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v5 33/33] KVM: PPC: Book3S HV: Add NO_HASH flag to
 GET_SMMU_INFO ioctl result
Message-ID: <20181008233451.GD7004@umbus.fritz.box>
References: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
 <1538976679-1363-34-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Lg8eXa+brxrbjAbR"
Content-Disposition: inline
In-Reply-To: <1538976679-1363-34-git-send-email-paulus@ozlabs.org>
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


--Lg8eXa+brxrbjAbR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 08, 2018 at 04:31:19PM +1100, Paul Mackerras wrote:
> This adds a KVM_PPC_NO_HASH flag to the flags field of the
> kvm_ppc_smmu_info struct, and arranges for it to be set when
> running as a nested hypervisor, as an unambiguous indication
> to userspace that HPT guests are not supported.  Reporting the
> KVM_CAP_PPC_MMU_HASH_V3 capability as false could be taken as
> indicating only that the new HPT features in ISA V3.0 are not
> supported, leaving it ambiguous whether pre-V3.0 HPT features
> are supported.
>=20
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  Documentation/virtual/kvm/api.txt | 4 ++++
>  arch/powerpc/kvm/book3s_hv.c      | 4 ++++
>  include/uapi/linux/kvm.h          | 1 +
>  3 files changed, 9 insertions(+)
>=20
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kv=
m/api.txt
> index fde48b6..df98b63 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -2270,6 +2270,10 @@ The supported flags are:
>          The emulated MMU supports 1T segments in addition to the
>          standard 256M ones.
> =20
> +    - KVM_PPC_NO_HASH
> +	This flag indicates that HPT guests are not supported by KVM,
> +	thus all guests must use radix MMU mode.
> +
>  The "slb_size" field indicates how many SLB entries are supported
> =20
>  The "sps" array contains 8 entries indicating the supported base
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index fa61647..f565403 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -4245,6 +4245,10 @@ static int kvm_vm_ioctl_get_smmu_info_hv(struct kv=
m *kvm,
>  	kvmppc_add_seg_page_size(&sps, 16, SLB_VSID_L | SLB_VSID_LP_01);
>  	kvmppc_add_seg_page_size(&sps, 24, SLB_VSID_L);
> =20
> +	/* If running as a nested hypervisor, we don't support HPT guests */
> +	if (kvmhv_on_pseries())
> +		info->flags |=3D KVM_PPC_NO_HASH;
> +
>  	return 0;
>  }
> =20
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index d9cec6b..7f2ff3a 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -719,6 +719,7 @@ struct kvm_ppc_one_seg_page_size {
> =20
>  #define KVM_PPC_PAGE_SIZES_REAL		0x00000001
>  #define KVM_PPC_1T_SEGMENTS		0x00000002
> +#define KVM_PPC_NO_HASH			0x00000004
> =20
>  struct kvm_ppc_smmu_info {
>  	__u64 flags;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Lg8eXa+brxrbjAbR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu76ZsACgkQbDjKyiDZ
s5KF3g//Yw4IoHHQ/GPCu14bes9e6jRCIqUc9CtoMw52sC+2KmV7JN3ilL8CkcT+
oggzpS07zJRKUl/KLIwXEMTIweeZ1lxyNDWcPBbIvsfBjbuajOko0xIP+CxAr5nH
EMipgBREEIF7qCLP9t/kYh7Q32Ld/ufQSOCtIyvUg0cDoH+WHm/nXaqCDer/I2a3
JEpTD6u8spIrNTSvgw4BGNjFQNUYYucc1DBt8ybqZXm5YPrjmPPHht2XvPKtMvys
OKkOqWujM1Rinys2RJ0zYf69UuMmXZ6yonh9LVEi1H+QgVRyahM9TQwmzxhjtTrg
uBz+UiLcOQTH94Ov1w9yR2/JvI5M8MSBNpnT74bp0EQyK9Pm/MaWoCIH2kq0Guli
6PgtfJqoKqS08gl/WS0SzalyWkL64HGzNvLVxgjnW+VQ5HVbnD3lh4ULLK1oGGW0
dWrfRuY0TG9N2cCkcR7rFDIyawPIFQsvp3ZYpqGvo0WtnN+iLnPgHRdvPpar4Hs5
HT8fc5dzaHfH3Y7tHmt6Sv+JnaGDXlCMrC5lAwqyJCJh0+UJx3+BkGVLD4H4sF3t
RiDD5TL/uFLbkVhDft+awGetHNbq86U4JtZ8vOGdFuakPCeT++28tq0r6Qw+oLvh
B4WLBBVdJ3T+n5oRMOkCjspJjSiYiHggMM2RWnQWbjrijE5A1s0=
=XFM3
-----END PGP SIGNATURE-----

--Lg8eXa+brxrbjAbR--
