Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72722C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 03:06:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0EC8213A2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 03:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fSM7bp9R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0EC8213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KYXB11hQzDqMr
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 14:06:50 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KYQY093tzDqLk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 14:01:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="fSM7bp9R"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44KYQX5tZdz9sMM; Thu, 14 Mar 2019 14:01:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552532516;
 bh=xOEo0JesKsdWYH87xScLDRjzWsJp7x2a84eWgGExJsg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=fSM7bp9RE5JjL/raYJRqUO0a6fvpCouko7F2sKmaINBPwk66gYZOwBpq7CbwKBcu4
 i9C+kfu3cIUYruSp7TkaGfZT7SQMsonVUE+usq40TwNfqxDmOFq4BVIO0YgbquYdP6
 XIzvskW4bcsyo4BQ34epP/G2cgVvr6hxZDnPAxp4=
Date: Thu, 14 Mar 2019 13:26:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 16/16] KVM: PPC: Book3S HV: XIVE: clear the vCPU
 interrupt presenters
Message-ID: <20190314022609.GJ8211@umbus.fritz.box>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-17-clg@kaod.org>
 <20190225041858.GT7668@umbus.fritz.box>
 <3604baf2-0a39-6990-968f-1222d32f9278@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="I/5syFLg1Ed7r+1G"
Content-Disposition: inline
In-Reply-To: <3604baf2-0a39-6990-968f-1222d32f9278@kaod.org>
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


--I/5syFLg1Ed7r+1G
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2019 at 09:17:17AM +0100, C=E9dric Le Goater wrote:
> On 2/25/19 5:18 AM, David Gibson wrote:
> > On Fri, Feb 22, 2019 at 12:28:40PM +0100, C=E9dric Le Goater wrote:
> >> When the VM boots, the CAS negotiation process determines which
> >> interrupt mode to use and invokes a machine reset. At that time, the
> >> previous KVM interrupt device is 'destroyed' before the chosen one is
> >> created. Upon destruction, the vCPU interrupt presenters using the KVM
> >> device should be cleared first, the machine will reconnect them later
> >> to the new device after it is created.
> >>
> >> When using the KVM device, there is still a race window with the early
> >> checks in kvmppc_native_connect_vcpu(). Yet to be fixed.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  arch/powerpc/kvm/book3s_xics.c        | 19 +++++++++++++
> >>  arch/powerpc/kvm/book3s_xive.c        | 39 +++++++++++++++++++++++++--
> >>  arch/powerpc/kvm/book3s_xive_native.c | 16 +++++++++++
> >>  3 files changed, 72 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_=
xics.c
> >> index f27ee57ab46e..81cdabf4295f 100644
> >> --- a/arch/powerpc/kvm/book3s_xics.c
> >> +++ b/arch/powerpc/kvm/book3s_xics.c
> >> @@ -1342,6 +1342,25 @@ static void kvmppc_xics_free(struct kvm_device =
*dev)
> >>  	struct kvmppc_xics *xics =3D dev->private;
> >>  	int i;
> >>  	struct kvm *kvm =3D xics->kvm;
> >> +	struct kvm_vcpu *vcpu;
> >> +
> >> +	/*
> >> +	 * When destroying the VM, the vCPUs are destroyed first and
> >> +	 * the vCPU list should be empty. If this is not the case,
> >> +	 * then we are simply destroying the device and we should
> >> +	 * clean up the vCPU interrupt presenters first.
> >> +	 */
> >> +	if (atomic_read(&kvm->online_vcpus) !=3D 0) {
> >> +		/*
> >> +		 * call kick_all_cpus_sync() to ensure that all CPUs
> >> +		 * have executed any pending interrupts
> >> +		 */
> >> +		if (is_kvmppc_hv_enabled(kvm))
> >> +			kick_all_cpus_sync();
> >> +
> >> +		kvm_for_each_vcpu(i, vcpu, kvm)
> >> +			kvmppc_xics_free_icp(vcpu);
> >> +	}
> >> =20
> >>  	debugfs_remove(xics->dentry);
> >> =20
> >> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_=
xive.c
> >> index 7a14512b8944..0a1c11d6881c 100644
> >> --- a/arch/powerpc/kvm/book3s_xive.c
> >> +++ b/arch/powerpc/kvm/book3s_xive.c
> >> @@ -1105,11 +1105,19 @@ void kvmppc_xive_disable_vcpu_interrupts(struc=
t kvm_vcpu *vcpu)
> >>  void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcpu)
> >>  {
> >>  	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> >> -	struct kvmppc_xive *xive =3D xc->xive;
> >> +	struct kvmppc_xive *xive;
> >>  	int i;
> >> =20
> >> +	if (!kvmppc_xics_enabled(vcpu))
> >=20
> > This should be kvmppc_xive_enabled(), no?
>=20
> This is the KVM XICS-on-XIVE device and its IRQ type is KVMPPC_IRQ_XICS.
> So this is correct :/=20

Ah, right, sorry.

> May be we should introduce a KVMPPC_IRQ_XICS_ON_XIVE macro to
> clarify.

Yeah, maybe.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--I/5syFLg1Ed7r+1G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyJu74ACgkQbDjKyiDZ
s5LKFA/+LzfjqE5drr5Ofe5gBMqFYKtgh2EfJOxxudjr+clIpCccJZp3esC7sXLD
JUHWUlPd+k+LRc99ekNtv0XiGqix2zovuKzeaMIVVouNEF/WZO/i1waZUG8jfMdN
7KW6JOQjxphIwXEmcbg0A7WXj8du7Uh6bpABjw2F+a6l8I1cxXrNyH1a97Ju2F99
2dUEdzBehptrgnDHRd/srNI9Q4BFLxSKw3xVpGCyHWP1i+KVhZvTDKQJZzdWnpc9
85X22q7WPSLG4Us8oJQ42vmVTygyDA2kIRZMQoLzvlFAfYEjUgrXiO/mroCezKmL
5vIW2SLIA5wPJYkWuCOaM2VT1/2CMeEdkKiN/CkYOrllsGUUTQzfgFLWxVl4yt1R
B17sq1fVHqGQGYeNNJPfhnGFNTd0P4FqvlJSHx0eJO8LZxEM74NR16zGqlhqGZMC
96/jtP9Fj3YEYlwflmwh3QniXwqRaH78sJRjgJ88DdPQHqgFfRj8QSGrcAXDLAUH
26A5E58lIQSSHH21KPMqlKVhWWaXCRps5AfQC1jwb/TKXaB6sGsR1NBZr+jQIsWl
/p7TR1VHTQc1cTQs1pfp0eR8cLKqZyzCr0S/1dTnQSs2u34jQLiYfDKxfNdYSg82
s6H2B5kJx6v1tRwWNJdVK81zxqpLnU/bEgZ2+XdtZA5fORy45Os=
=rBt5
-----END PGP SIGNATURE-----

--I/5syFLg1Ed7r+1G--
