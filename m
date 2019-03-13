Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8792C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 04:34:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2CBC2177E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 04:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jLBv1CpF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2CBC2177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44JzWl3XlGzDqDG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 15:34:27 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44JzNl1bsvzDqJR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 15:28:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="jLBv1CpF"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44JzNk5CMCz9s70; Wed, 13 Mar 2019 15:28:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552451302;
 bh=M3qL3fbDGGyoZrCtPJtPzuq8db4yuscTJPRjGD6lK6Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jLBv1CpFmvSbVslLeKnbqDi4rv14ARyRftve5yWoG9naiXOmXPTbtEXeks//8Tjd2
 K1KoLgABaErmFoYrPFeGlzp4ok1vVFvI3214/gcXBvrEu1HPe5rqrA1qUN5ukLzgI5
 5i8FPvDIqB8BNXqdRmLEUNbPBnC0OK4u+LYV0osQ=
Date: Wed, 13 Mar 2019 15:05:42 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 03/16] KVM: PPC: Book3S HV: XIVE: introduce a new
 capability KVM_CAP_PPC_IRQ_XIVE
Message-ID: <20190313040542.GL9881@umbus.fritz.box>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-4-clg@kaod.org>
 <20190225003527.GG7668@umbus.fritz.box>
 <2f029721-0b20-2706-6627-0bac36afd03e@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="c8JyeaiReRNoiMDS"
Content-Disposition: inline
In-Reply-To: <2f029721-0b20-2706-6627-0bac36afd03e@kaod.org>
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


--c8JyeaiReRNoiMDS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 03:03:25PM +0100, C=E9dric Le Goater wrote:
> On 2/25/19 1:35 AM, David Gibson wrote:
> > On Fri, Feb 22, 2019 at 12:28:27PM +0100, C=E9dric Le Goater wrote:
[snip]
> >> +int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
> >> +				    struct kvm_vcpu *vcpu, u32 cpu)
> >> +{
> >> +	struct kvmppc_xive *xive =3D dev->private;
> >> +	struct kvmppc_xive_vcpu *xc;
> >> +	int rc;
> >> +
> >> +	pr_devel("native_connect_vcpu(cpu=3D%d)\n", cpu);
> >> +
> >> +	if (dev->ops !=3D &kvm_xive_native_ops) {
> >> +		pr_devel("Wrong ops !\n");
> >> +		return -EPERM;
> >> +	}
> >> +	if (xive->kvm !=3D vcpu->kvm)
> >> +		return -EPERM;
> >> +	if (vcpu->arch.irq_type !=3D KVMPPC_IRQ_DEFAULT)
> >> +		return -EBUSY;
> >> +	if (kvmppc_xive_find_server(vcpu->kvm, cpu)) {
> >=20
> > You haven't taken the kvm->lock yet, so couldn't a race mean a
> > duplicate server gets inserted after you make this check?
> >=20
> >> +		pr_devel("Duplicate !\n");
> >> +		return -EEXIST;
> >> +	}
> >> +	if (cpu >=3D KVM_MAX_VCPUS) {
> >> +		pr_devel("Out of bounds !\n");
> >> +		return -EINVAL;
> >> +	}
> >> +	xc =3D kzalloc(sizeof(*xc), GFP_KERNEL);
> >> +	if (!xc)
> >> +		return -ENOMEM;
> >> +
> >> +	mutex_lock(&vcpu->kvm->lock);
> >> +	vcpu->arch.xive_vcpu =3D xc;
> >=20
> > Similarly you don't verify this is NULL after taking the lock, so
> > couldn't another thread race and make a connect which gets clobbered
> > here?
>=20
> Yes. this is not very safe ... We need to clean up all the KVM device=20
> methods doing the connection of the presenter to the vCPU AFAICT.=20
> I will fix the XIVE native one for now.=20
>=20
> And also, this CPU parameter is useless. There is no reason to connect=20
> a vCPU from another vCPU.

Hmm.. I thought the point of the 'cpu' parameter (not a great name) is
that it lets userspace chose the guest visible irq server ID.  I think
that's preferable to tying it to an existing cpu id, if possible.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--c8JyeaiReRNoiMDS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyIgZYACgkQbDjKyiDZ
s5JZshAAlJTbgUEzm/PuGQSZ8a7JqBhImKIbcZgeM6ZMcPpWOMWluJ6PWM9qDRDl
Wh9lGWxEneoPGbES7TWp5vVd43ro1ncHyE6WbyTOHFgSfjKjargr70pdW0vQTXz2
sPV/5D3RfiuTs2kz4aOLF7KuVJH3ktCnSLIYSHDdSRTo38e5NVL06giRFRUugQvm
lwQng7UOmkQji1EZ9wTtbjQ3DVOKdrMoRZSdqHxICmYREVuF17oDhRPHwkh6lMku
FoC5SvPRWejI4PjDT3sxWwvezRgGInrW9oLiH/Y9hmf96uS+i+VqqvNcvuaPF+7v
5FpafHUxEEyag4s6IvHl2jC6OGnVgbA6qtYm+o75whsEeohQNokRwbLzPuEgudi5
XkuOkHkxf2lfHe0vXm3ivsG9LGVSePBJ2eVQ38Dzg5ZWu/Hs5ZiMXJTafb3BoTBq
WknL/p48rxUcUM+r/pPzrx4pVD4AmQ5qvHS5rrMz+C5FhWV68p64UZWgCovUlzEB
2dks3I6V5CQOKuQykxYP1kmMTQ/nReiInLHHsS4LzkGRmiiMQcVZGyANOT36L59j
H9zOR/1rLV2KrvITrXloTpxz/YWWjmGBQBLLOVn/nn032aEYQiLtvYHAlJBSixAO
KK40uB9XvfD6fBNXgsswax6cLidEBw/RWzNwj6WUVY0DCiiGhRE=
=YaVr
-----END PGP SIGNATURE-----

--c8JyeaiReRNoiMDS--
