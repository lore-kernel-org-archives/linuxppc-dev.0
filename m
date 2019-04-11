Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B31C10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 04:42:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71602133D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 04:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="opSq6O5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71602133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fpKP2VK4zDqQQ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 14:42:17 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fpHf2bzDzDqBM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 14:40:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="opSq6O5z"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44fpHd3vPVz9s4V; Thu, 11 Apr 2019 14:40:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1554957645;
 bh=Am+EAbJJq81ROnUgl5i87uuZIM8ffUyg7vfrG1Cd5f4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=opSq6O5zdX5vsd0gs4kaPGAwtMRxPBuPCZsG8IG2VQE3LVioFebnl+kUM/XCfLQzs
 fAyvwpn1zMdp1xP7lr7y3lvEr7feljo6d2DQ4oJGVNHAZr6ojH/L5T3j5nIcRpYIQu
 jbhVLYksROLLqCjPekMPrVPjHfIzff7j94opkIeU=
Date: Thu, 11 Apr 2019 14:38:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v5 16/16] KVM: PPC: Book3S HV: XIVE: introduce a
 'release' device operation
Message-ID: <20190411043834.GA20857@umbus.fritz.box>
References: <20190410170448.3923-1-clg@kaod.org>
 <20190410170448.3923-17-clg@kaod.org>
 <20190411031625.GA21252@blackberry>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20190411031625.GA21252@blackberry>
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
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2019 at 01:16:25PM +1000, Paul Mackerras wrote:
> On Wed, Apr 10, 2019 at 07:04:48PM +0200, C=E9dric Le Goater wrote:
> > When a P9 sPAPR VM boots, the CAS negotiation process determines which
> > interrupt mode to use (XICS legacy or XIVE native) and invokes a
> > machine reset to activate the chosen mode.
> >=20
> > To be able to switch from one mode to another, we introduce the
> > capability to release a KVM device without destroying the VM. The KVM
> > device interface is extended with a new 'release' operation which is
> > called when the file descriptor of the device is closed.
>=20
> I believe the release operation is not called until all of the mmaps
> using the fd are unmapped - which is a good thing for us, since it
> means the guest can't possibly be accessing the XIVE directly.
> You might want to reword that last paragraph to mention that.
>=20
> > Such operations are defined for the XICS-on-XIVE and the XIVE native
> > KVM devices. They clear the vCPU interrupt presenters that could be
> > attached and then destroy the device.
> >=20
> > This is not considered as a safe operation as the vCPUs are still
> > running and could be referencing the KVM device through their
> > presenters. To protect the system from any breakage, the kvmppc_xive
> > objects representing both KVM devices are now stored in an array under
> > the VM. Allocation is performed on first usage and memory is freed
> > only when the VM exits.
>=20
> One quick comment below:
>=20
> > diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_x=
ive.c
> > index 480a3fc6b9fd..064a9f2ae678 100644
> > --- a/arch/powerpc/kvm/book3s_xive.c
> > +++ b/arch/powerpc/kvm/book3s_xive.c
> > @@ -1100,11 +1100,19 @@ void kvmppc_xive_disable_vcpu_interrupts(struct=
 kvm_vcpu *vcpu)
> >  void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcpu)
> >  {
> >  	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> > -	struct kvmppc_xive *xive =3D xc->xive;
> > +	struct kvmppc_xive *xive;
> >  	int i;
> > =20
> > +	if (!kvmppc_xics_enabled(vcpu))
> > +		return;
>=20
> Should that be kvmppc_xive_enabled() rather than xics?

I think I asked that on an earlier iteration, and the answer is no.
The names are confusing, but this file is all about xics-on-xive
rather than xive native.  So here we're checking what's available from
the guest's point of view, so "xics", but most of the surrounding
functions are named "xive" because that's the backend.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyuxMcACgkQbDjKyiDZ
s5LocxAAy8OzoXgS0yo0VMPhVvhDSMQb6cgvk+/Yq62ftCphWDoexQDsFycimHFf
Quqlfm6dK0pLMc3ozqMafgIcEo+tYPz8QKZTFABaZYa4AsNVREdCXw+RSL9LRAE/
sUjZmXwgJLvIirr0y7JFGGyoFKxm0txqBs5Q+TwlxJlUMx48iqB8axEzjnidHs7J
Q0gz2YtGN1zPvX0LL0q1kYs0lU6kPDN3DmsxYaOcvynR52Awfb/oxMJHDGpoHxlE
tgJwFnNIVuq275Ps14bFp3dKewRaulcMAH4iYwBtM57qWvSrGhUIn2nVce/1yzut
p5xWbtlrLrCqY0MzxYG76AtIho7DfhIbvdcYt5xXNoA31gqKm0dem4D/rdlZSGwL
kaDJIe4I9O3/1kQBR5WUfqcKRZlaoO4bEKdTerTd6HxTSjDKinQFpIy14BfYvzMA
8nfVHpxRCIy6+bP8rSUJkaBUA6tQrAKtablN21Vmr69tMzsSwQO+supf7OHkvQYM
07CbEvavk1Gdanr1xECOTgd5Oky/EPmolj4pZujqk035MWEQdmrubR/s7FNv94Rp
NL3C1YuXJHrkmNmcOPi8Djrvh4S+lgfTVYO/aAy4DJb48caalp8uvBRHA0wAjwFZ
92m/xhM9w3TcThpH8BY6aw90Tbn1AVcvSz2H/vsNOB6C8+eN6Xo=
=+nls
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
