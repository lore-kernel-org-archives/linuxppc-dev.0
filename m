Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7691BC282D7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:26:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB3BE20820
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mwR5n5mL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3BE20820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tHmT0YWBzDqCg
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 17:26:49 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tHSK63v5zDqGb
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 17:12:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="mwR5n5mL"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43tHSK0TNpz9sMr; Mon,  4 Feb 2019 17:12:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549260769;
 bh=a/N99ZIohKV5ixlSg8sG+ouN5khBSVNoTyGBkUzZSGY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mwR5n5mLKtKHx5NBkU4jEEK4IF7yRt1/qmzOHwhUllWI0qPRcJ5BUNtx76oiIzAGH
 vI53fRX95W1KVjU05nwRH6qOv9Zeiej4G0mq4LAnhX5tT0t35zb4IoP18FVUUS82e1
 zgIUlbhdEKURSam6YbAQXFzY3mGnjX/eIQ6qcw98=
Date: Mon, 4 Feb 2019 16:18:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 14/19] KVM: PPC: Book3S HV: add a control to make the
 XIVE EQ pages dirty
Message-ID: <20190204051833.GG1927@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-15-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="m0vRWufqUC70IDnR"
Content-Disposition: inline
In-Reply-To: <20190107184331.8429-15-clg@kaod.org>
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--m0vRWufqUC70IDnR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 07, 2019 at 07:43:26PM +0100, C=E9dric Le Goater wrote:
> When the VM is stopped in a migration sequence, the sources are masked
> and the XIVE IC is synced to stabilize the EQs. When done, the KVM
> ioctl KVM_DEV_XIVE_SAVE_EQ_PAGES is called to mark dirty the EQ pages.
>=20
> The migration can then transfer the remaining dirty pages to the
> destination and start collecting the state of the devices.

Is there a reason to make this a separate step from the SYNC
operation?

>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/include/uapi/asm/kvm.h   |  1 +
>  arch/powerpc/kvm/book3s_xive_native.c | 40 +++++++++++++++++++++++++++
>  2 files changed, 41 insertions(+)
>=20
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/u=
api/asm/kvm.h
> index f3b859223b80..1a8740629acf 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -680,6 +680,7 @@ struct kvm_ppc_cpu_char {
>  #define   KVM_DEV_XIVE_GET_ESB_FD	1
>  #define   KVM_DEV_XIVE_GET_TIMA_FD	2
>  #define   KVM_DEV_XIVE_VC_BASE		3
> +#define   KVM_DEV_XIVE_SAVE_EQ_PAGES	4
>  #define KVM_DEV_XIVE_GRP_SOURCES	2	/* 64-bit source attributes */
>  #define KVM_DEV_XIVE_GRP_SYNC		3	/* 64-bit source attributes */
> =20
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/boo=
k3s_xive_native.c
> index a8052867afc1..f2de1bcf3b35 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -373,6 +373,43 @@ static int kvmppc_xive_native_get_tima_fd(struct kvm=
ppc_xive *xive, u64 addr)
>  	return put_user(ret, ubufp);
>  }
> =20
> +static int kvmppc_xive_native_vcpu_save_eq_pages(struct kvm_vcpu *vcpu)
> +{
> +	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> +	unsigned int prio;
> +
> +	if (!xc)
> +		return -ENOENT;
> +
> +	for (prio =3D 0; prio < KVMPPC_XIVE_Q_COUNT; prio++) {
> +		struct xive_q *q =3D &xc->queues[prio];
> +
> +		if (!q->qpage)
> +			continue;
> +
> +		/* Mark EQ page dirty for migration */
> +		mark_page_dirty(vcpu->kvm, gpa_to_gfn(q->guest_qpage));
> +	}
> +	return 0;
> +}
> +
> +static int kvmppc_xive_native_save_eq_pages(struct kvmppc_xive *xive)
> +{
> +	struct kvm *kvm =3D xive->kvm;
> +	struct kvm_vcpu *vcpu;
> +	unsigned int i;
> +
> +	pr_devel("%s\n", __func__);
> +
> +	mutex_lock(&kvm->lock);
> +	kvm_for_each_vcpu(i, vcpu, kvm) {
> +		kvmppc_xive_native_vcpu_save_eq_pages(vcpu);
> +	}
> +	mutex_unlock(&kvm->lock);
> +
> +	return 0;
> +}
> +
>  static int xive_native_validate_queue_size(u32 qsize)
>  {
>  	switch (qsize) {
> @@ -498,6 +535,8 @@ static int kvmppc_xive_native_set_attr(struct kvm_dev=
ice *dev,
>  		switch (attr->attr) {
>  		case KVM_DEV_XIVE_VC_BASE:
>  			return kvmppc_xive_native_set_vc_base(xive, attr->addr);
> +		case KVM_DEV_XIVE_SAVE_EQ_PAGES:
> +			return kvmppc_xive_native_save_eq_pages(xive);
>  		}
>  		break;
>  	case KVM_DEV_XIVE_GRP_SOURCES:
> @@ -538,6 +577,7 @@ static int kvmppc_xive_native_has_attr(struct kvm_dev=
ice *dev,
>  		case KVM_DEV_XIVE_GET_ESB_FD:
>  		case KVM_DEV_XIVE_GET_TIMA_FD:
>  		case KVM_DEV_XIVE_VC_BASE:
> +		case KVM_DEV_XIVE_SAVE_EQ_PAGES:
>  			return 0;
>  		}
>  		break;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--m0vRWufqUC70IDnR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxXyykACgkQbDjKyiDZ
s5Lo8RAAtJxKIsQQTqRRCdy2Ceug0oOAku4wnCWEQZKjNSzTY/38prpNSKatRPFm
mPWb/Vlbe8ebNjU9KYTOh+i4Gamry5yzMgD0PqsNf2iFTpomvJwUuPO1ElePdqBk
fplJfspEgHdu0wSmz4KCDNTnBLqgptpw9FAUK9IlZVBwTYMM26hpKWOx8Th2CRkv
CCSprh8AzeS8PIhjsZweNYCDmO+CfMvWseiuXw5loTjvMQwzPw1yogXwrsh72qti
0D/Oj8ikRU+xXsPn7LEKNtxGu2u/Yp9YWhGWoRtdBY6S45y7OyHxkD/P9vjHXqKz
pGDKIH1wYbdthYTXdBUpVen43scC6cAQtDVLfEdEdQNXoVn/FCYZC8k6N5kfuuZQ
uAj+q4VZAUlIYdDCAdaY93JP0jjLEpj4DGcTWAXlGj+1mvm/OrZgaSMqjowXGhzz
iJIDlJGl2Az2gnn24HDsECMhlHLWAPs9o7Tl/pkF5Mqdd7pENVeCKk7deGGZrM3c
TA1Gnl9kZS1yPCZtxoR0OyxYNJR/m7nf6FXeqjMPmwYeRZ/46vv6wRZqNh3h0YlG
boHLZ7zqJLJUwl0eC3TI2tyyGVON7txcKY0f4kLHsN41aVqJgpURTw0DXaodynuw
bfWDb9rIghSdqe39408RPH7wfO4/oCAG9W3vjwIwBjsrhO89kVY=
=+JoK
-----END PGP SIGNATURE-----

--m0vRWufqUC70IDnR--
