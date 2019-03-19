Return-Path: <SRS0=MfaX=RW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAB7C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 05:41:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5F520854
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 05:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="j06cX2yC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5F520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Nhjm0cS2zDqKt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Mar 2019 16:41:00 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Nhf31D1YzDqHX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Mar 2019 16:37:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="j06cX2yC"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44Nhf248NSz9s7h; Tue, 19 Mar 2019 16:37:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552973866;
 bh=Xxp38tF+Vyo6JnMkjYWRXOd5YIlJWxRYDGyQiImAa/c=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=j06cX2yCSfGLFkdCdbpu4FmQRP+BBtIwCOoD6OdS0Lb7W0ket0eFigG0+w1TGFW6w
 RiX/YIG2LoYtbFnSOwH0YVKIkPMpynMui0yQsd0SItM2HRvgF1jEDY8KwM3jPYa+pq
 QTwjXbWOHLayP2foMzhLRdLnAZMixc/Rz1N/SngU=
Date: Tue, 19 Mar 2019 16:37:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 17/17] KVM: PPC: Book3S HV: XIVE: clear the vCPU
 interrupt presenters
Message-ID: <20190319053736.GE31018@umbus.fritz.box>
References: <20190315120609.25910-1-clg@kaod.org>
 <20190315120609.25910-18-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Content-Disposition: inline
In-Reply-To: <20190315120609.25910-18-clg@kaod.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2019 at 01:06:09PM +0100, C=E9dric Le Goater wrote:
> When the VM boots, the CAS negotiation process determines which
> interrupt mode to use and invokes a machine reset. At that time, the
> previous KVM interrupt device is 'destroyed' before the chosen one is
> created. Upon destruction, the vCPU interrupt presenters using the KVM
> device should be cleared first, the machine will reconnect them later
> to the new device after it is created.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
>  Changes since v2 :
>=20
>  - removed comments on possible race in kvmppc_native_connect_vcpu()
>    for the XIVE KVM device. This is still an issue in the
>    XICS-over-XIVE device.
>=20
>  arch/powerpc/kvm/book3s_xics.c        | 19 +++++++++++++
>  arch/powerpc/kvm/book3s_xive.c        | 39 +++++++++++++++++++++++++--
>  arch/powerpc/kvm/book3s_xive_native.c | 12 +++++++++
>  3 files changed, 68 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xic=
s.c
> index f27ee57ab46e..81cdabf4295f 100644
> --- a/arch/powerpc/kvm/book3s_xics.c
> +++ b/arch/powerpc/kvm/book3s_xics.c
> @@ -1342,6 +1342,25 @@ static void kvmppc_xics_free(struct kvm_device *de=
v)
>  	struct kvmppc_xics *xics =3D dev->private;
>  	int i;
>  	struct kvm *kvm =3D xics->kvm;
> +	struct kvm_vcpu *vcpu;
> +
> +	/*
> +	 * When destroying the VM, the vCPUs are destroyed first and
> +	 * the vCPU list should be empty. If this is not the case,
> +	 * then we are simply destroying the device and we should
> +	 * clean up the vCPU interrupt presenters first.
> +	 */
> +	if (atomic_read(&kvm->online_vcpus) !=3D 0) {
> +		/*
> +		 * call kick_all_cpus_sync() to ensure that all CPUs
> +		 * have executed any pending interrupts
> +		 */
> +		if (is_kvmppc_hv_enabled(kvm))
> +			kick_all_cpus_sync();
> +
> +		kvm_for_each_vcpu(i, vcpu, kvm)
> +			kvmppc_xics_free_icp(vcpu);
> +	}
> =20
>  	debugfs_remove(xics->dentry);
> =20
> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xiv=
e.c
> index 480a3fc6b9fd..cf6a4c6c5a28 100644
> --- a/arch/powerpc/kvm/book3s_xive.c
> +++ b/arch/powerpc/kvm/book3s_xive.c
> @@ -1100,11 +1100,19 @@ void kvmppc_xive_disable_vcpu_interrupts(struct k=
vm_vcpu *vcpu)
>  void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcpu)
>  {
>  	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> -	struct kvmppc_xive *xive =3D xc->xive;
> +	struct kvmppc_xive *xive;
>  	int i;
> =20
> +	if (!kvmppc_xics_enabled(vcpu))
> +		return;
> +
> +	if (!xc)
> +		return;
> +
>  	pr_devel("cleanup_vcpu(cpu=3D%d)\n", xc->server_num);
> =20
> +	xive =3D xc->xive;
> +
>  	/* Ensure no interrupt is still routed to that VP */
>  	xc->valid =3D false;
>  	kvmppc_xive_disable_vcpu_interrupts(vcpu);
> @@ -1141,6 +1149,10 @@ void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcp=
u)
>  	}
>  	/* Free the VP */
>  	kfree(xc);
> +
> +	/* Cleanup the vcpu */
> +	vcpu->arch.irq_type =3D KVMPPC_IRQ_DEFAULT;
> +	vcpu->arch.xive_vcpu =3D NULL;
>  }
> =20
>  int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
> @@ -1158,7 +1170,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
>  	}
>  	if (xive->kvm !=3D vcpu->kvm)
>  		return -EPERM;
> -	if (vcpu->arch.irq_type)
> +	if (vcpu->arch.irq_type !=3D KVMPPC_IRQ_DEFAULT)
>  		return -EBUSY;
>  	if (kvmppc_xive_find_server(vcpu->kvm, cpu)) {
>  		pr_devel("Duplicate !\n");
> @@ -1828,8 +1840,31 @@ static void kvmppc_xive_free(struct kvm_device *de=
v)
>  {
>  	struct kvmppc_xive *xive =3D dev->private;
>  	struct kvm *kvm =3D xive->kvm;
> +	struct kvm_vcpu *vcpu;
>  	int i;
> =20
> +	/*
> +	 * When destroying the VM, the vCPUs are destroyed first and
> +	 * the vCPU list should be empty. If this is not the case,
> +	 * then we are simply destroying the device and we should
> +	 * clean up the vCPU interrupt presenters first.
> +	 */
> +	if (atomic_read(&kvm->online_vcpus) !=3D 0) {
> +		/*
> +		 * call kick_all_cpus_sync() to ensure that all CPUs
> +		 * have executed any pending interrupts
> +		 */
> +		if (is_kvmppc_hv_enabled(kvm))
> +			kick_all_cpus_sync();
> +
> +		/*
> +		 * TODO: There is still a race window with the early
> +		 * checks in kvmppc_native_connect_vcpu()
> +		 */
> +		kvm_for_each_vcpu(i, vcpu, kvm)
> +			kvmppc_xive_cleanup_vcpu(vcpu);
> +	}
> +
>  	debugfs_remove(xive->dentry);
> =20
>  	if (kvm)
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index 67a1bb26a4cc..8f7be5e23177 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -956,8 +956,20 @@ static void kvmppc_xive_native_free(struct kvm_devic=
e *dev)
>  {
>  	struct kvmppc_xive *xive =3D dev->private;
>  	struct kvm *kvm =3D xive->kvm;
> +	struct kvm_vcpu *vcpu;
>  	int i;
> =20
> +	/*
> +	 * When destroying the VM, the vCPUs are destroyed first and
> +	 * the vCPU list should be empty. If this is not the case,
> +	 * then we are simply destroying the device and we should
> +	 * clean up the vCPU interrupt presenters first.
> +	 */
> +	if (atomic_read(&kvm->online_vcpus) !=3D 0) {
> +		kvm_for_each_vcpu(i, vcpu, kvm)
> +			kvmppc_xive_native_cleanup_vcpu(vcpu);
> +	}
> +
>  	debugfs_remove(xive->dentry);
> =20
>  	pr_devel("Destroying xive native device\n");

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyQgB4ACgkQbDjKyiDZ
s5KvXxAA4ZKWRmIBm2G7anrDpE3w2v9XrOKZDBG2mJwba5qIMVvNOzVVUiah20IY
+BpENZd6XKqS4TeEO/zVNW7IworN7r8KNeUbfH/tA82x51IDx7wGuXpMFutpMv/+
Uxh7yUSQxtnMPvBwqbQ5Ghc5JioRcxoDI/FmjwmsdHh65VUfJx5FIlD2Rkvz0M8p
i6/gqw2JNwZ43dseSimIp4P25KQ0IDkWDwhsmln927gLxgLBUMf1WP+PcFrYSn08
U/5sw5YZ0uIXGFI9YiVITKBLZ4vY2mRVzT80K6Ji7veGCAMzs/R+DsfmK7NiAOeb
pqG9mnbvM/mYPSs+xX+ngb0wXYqbJ6jdYkaQzNf05J22VBJ/FmaqIduAUA5Hht3u
47orCbBYdqZksDDdZHvki7NhT2uuckrve00GqNVbjrMqLqIacMGLHBRpdiFvFpFn
gDQY/S18l6D7cHjyC+dVBBA133eZdds8GV90dvPgGQY4fLQXxFMF7xfqZMp279VZ
yM56d+e2/m1kk9CL7tqOHRoWK6gS3E/v0JdoqMvEg/hnmDEwVIvyA72Jfu0OudeX
4KvZ+sIOgL/OuT8+ZObAV361PTllkAC7hB47p4Q9X6X4UxphnHvPgXlBBe3+7q0m
xGRi7YjurIECoYbJ30l045pSQCnOqoPfQd13Jn/vULkJ9xI1Wig=
=hSZt
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--
