Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AF7C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 05:15:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C41020842
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 05:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="HkiHSXab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C41020842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4479BG4MtdzDqSM
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 16:15:18 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44796f4CPGzDqMG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 16:12:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="HkiHSXab"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44796f2SC8z9sBp; Mon, 25 Feb 2019 16:12:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1551071530;
 bh=tNbJD740pQWlIDs2e7sMfhHrjnQg4rhNApRVfYulDQE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HkiHSXabwTkMuKU+t2ZQj/rQb69ru7wTkoUntgUyJXTRXGeLBKzRt2auBd2ou9+dl
 Bs7v2EmPZkL0Yp3BWEQcDTnH2TYEqPxXdasQuAVII5zYc0bFRAdkDDDZnURN6mdkdk
 U9sMRzh3AmOv5/nK2ZzLPGspjP5PXXztN5XmUzDw=
Date: Mon, 25 Feb 2019 15:18:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 16/16] KVM: PPC: Book3S HV: XIVE: clear the vCPU
 interrupt presenters
Message-ID: <20190225041858.GT7668@umbus.fritz.box>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-17-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FT/vNgDLxVq4t/AU"
Content-Disposition: inline
In-Reply-To: <20190222112840.25000-17-clg@kaod.org>
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--FT/vNgDLxVq4t/AU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 12:28:40PM +0100, C=E9dric Le Goater wrote:
> When the VM boots, the CAS negotiation process determines which
> interrupt mode to use and invokes a machine reset. At that time, the
> previous KVM interrupt device is 'destroyed' before the chosen one is
> created. Upon destruction, the vCPU interrupt presenters using the KVM
> device should be cleared first, the machine will reconnect them later
> to the new device after it is created.
>=20
> When using the KVM device, there is still a race window with the early
> checks in kvmppc_native_connect_vcpu(). Yet to be fixed.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/kvm/book3s_xics.c        | 19 +++++++++++++
>  arch/powerpc/kvm/book3s_xive.c        | 39 +++++++++++++++++++++++++--
>  arch/powerpc/kvm/book3s_xive_native.c | 16 +++++++++++
>  3 files changed, 72 insertions(+), 2 deletions(-)
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
> index 7a14512b8944..0a1c11d6881c 100644
> --- a/arch/powerpc/kvm/book3s_xive.c
> +++ b/arch/powerpc/kvm/book3s_xive.c
> @@ -1105,11 +1105,19 @@ void kvmppc_xive_disable_vcpu_interrupts(struct k=
vm_vcpu *vcpu)
>  void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcpu)
>  {
>  	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> -	struct kvmppc_xive *xive =3D xc->xive;
> +	struct kvmppc_xive *xive;
>  	int i;
> =20
> +	if (!kvmppc_xics_enabled(vcpu))

This should be kvmppc_xive_enabled(), no?

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
> @@ -1146,6 +1154,10 @@ void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcp=
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
> @@ -1163,7 +1175,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
>  	}
>  	if (xive->kvm !=3D vcpu->kvm)
>  		return -EPERM;
> -	if (vcpu->arch.irq_type)
> +	if (vcpu->arch.irq_type !=3D KVMPPC_IRQ_DEFAULT)
>  		return -EBUSY;
>  	if (kvmppc_xive_find_server(vcpu->kvm, cpu)) {
>  		pr_devel("Duplicate !\n");
> @@ -1833,8 +1845,31 @@ static void kvmppc_xive_free(struct kvm_device *de=
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
> index bf60870144f1..c0655164d9af 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -909,8 +909,24 @@ static void kvmppc_xive_native_free(struct kvm_devic=
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
> +		/*
> +		 * TODO: There is still a race window with the early
> +		 * checks in kvmppc_xive_native_connect_vcpu()
> +		 */
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

--FT/vNgDLxVq4t/AU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxzbLIACgkQbDjKyiDZ
s5Lqvg//aBrr9wiOAtqtQtcnbDg3Zy64VgzHHVHSnZw5QiWmYRVxKw1DaO3rsJEE
kIK4k+fR4rI4ZIGDiGTBgECLhMyir0lXSEGxswAhQN1LgWvY4zGDj/2UnjJvBs8J
bXp6DDFuGT65BuL7QewCUUzCfkafMDrzkVhVz/iJrazDZE1/pH16SWC1KC2K5ZP6
nHCLjDaVoyCZRwiaj/qwXzUuxazQgz5+0nTkLrV5nB+uSJ6lDanJVg2YMKnU/Rns
4k41ArsGNrD/B5o/cCfeh/uzjr6DQMwVVaZoZRBE0lTGobus8rzn2J2t7CGU2scH
LDzwwMFulUPn9FsSCtfDpvaosk8frEUIz56zlblolEmXE6b+GjvECRW01ggkd6UD
I94mEPbxhEJDB6ZqGeT7KkP5AC2ZAJo4il/lw2paBty6TtmYbVPQteDQ+kewCbD8
QEbDfZI8GT21xJr0jsSF+9NYiHc+bMH1tDRZzNe2lpBi6I3GS111F25PODLxDc4x
6rz41Ru2hOHerPGIC2yXbS8xQV83SYA6L7WQead9UqZ0whv054X4eFCX9UrV0zT7
Og8ikLjxeLjkFVGWGU6YKvLNMl55M1eIQWYbU3/LWReQQk43OtHU6eL/NsDLKsnj
G+SOopi2kkGjanLPWT2f0+dlMdyR0F4fCnjq5skqI40fIUdWkd4=
=tkVm
-----END PGP SIGNATURE-----

--FT/vNgDLxVq4t/AU--
