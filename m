Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FFBC433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Sep 2021 05:14:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A87E60FDC
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Sep 2021 05:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5A87E60FDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H15Zg05Nlz3bj3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Sep 2021 15:14:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.a=rsa-sha256 header.s=201602 header.b=pi4gUp4Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=dgibson@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.a=rsa-sha256 header.s=201602 header.b=pi4gUp4Y; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H15Yt1kl7z2yJN
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Sep 2021 15:14:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gibson.dropbear.id.au; s=201602; t=1630646041;
 bh=6ILjOh+kIuiDJYXTi/RPyp3NIhH+Al2Jv7RlEtYBSbU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pi4gUp4YG5ns5iot1nsYqUDbV7rdNGQN64aFAaUQ4zj2UZy/qE6vLSeCzpD+dO3la
 johT1E8S3d1Eb/BNp4RoeyiRqNwqv4tBOgVeumJEn7hcRN2M3s9oefAxl+mKzNGb/9
 qQcQCzBv38lVHRkYb4qWjgXkZZXt1IX1Mca2fhcY=
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4H15Yj1MXRz9sW4; Fri,  3 Sep 2021 15:14:01 +1000 (AEST)
Date: Fri, 3 Sep 2021 15:13:55 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Fabiano Rosas <farosas@linux.ibm.com>
Subject: Re: [PATCH 0/5] KVM: PPC: Book3S: Modules cleanup and unification
Message-ID: <YTGvE9o9e0qCz9xA@yekko>
References: <20210901173357.3183658-1-farosas@linux.ibm.com>
 <YTAownlTy46X4jGV@yekko> <875yvjujxy.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZzHFj0RmvuubG6he"
Content-Disposition: inline
In-Reply-To: <875yvjujxy.fsf@linux.ibm.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--ZzHFj0RmvuubG6he
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 02, 2021 at 11:32:41AM -0300, Fabiano Rosas wrote:
> David Gibson <david@gibson.dropbear.id.au> writes:
>=20
> > On Wed, Sep 01, 2021 at 02:33:52PM -0300, Fabiano Rosas wrote:
> >> This series merges our three kvm modules kvm.ko, kvm-hv.ko and
> >> kvm-pr.ko into one kvm.ko module.
> >
> > That doesn't sound like a good idea to me.  People who aren't on BookS
> > servers don't want - and can't use - kvm-hv.  Almost nobody wants
> > kvm-pr.  It's also kind of inconsistent with x86, which has the
> > separate AMD and Intel modules.
>=20
> But this is not altering the ability of having only kvm-hv or only
> kvm-pr. I'm taking the Kconfig options that used to produce separate
> modules and using them to select which code gets built into the one
> kvm.ko module.

>=20
> Currently:
>=20
> CONFIG_KVM_BOOK3S_64=3Dm     <-- produces kvm.ko
> CONFIG_KVM_BOOK3S_64_HV=3Dm  <-- produces kvm-hv.ko
> CONFIG_KVM_BOOK3S_64_PR=3Dm  <-- produces kvm-pr.ko
>=20
> I'm making it so we now have one kvm.ko everywhere, but there is still:
>=20
> CONFIG_KVM_BOOK3S_64=3Dm           <-- produces kvm.ko
> CONFIG_KVM_BOOK3S_HV_POSSIBLE=3Dy  <-- includes HV in kvm.ko
> CONFIG_KVM_BOOK3S_PR_POSSIBLE=3Dy  <-- includes PR in kvm.ko
>=20
> In other words, if you are going to have at least two modules loaded at
> all times (kvm + kvm-hv or kvm + kvm-pr), why not put all that into one
> module? No one needs to build code they are not going to use, this is
> not changing.

Ah.. I see, you're removing the runtime switch from one to the other
at the same time as having just a single one loaded, but leaving the
ability to compile time switch.  And compile time is arguably good
enough for the cases I've described.

Ok, I see your point.

I still think it's conceptually not ideal, but the practical benefit
is more important.  Objection withdrawn.


> About consistency with x86, this situation is not analogous because we
> need to be able to load both modules at the same time, which means
> kvm.ko needs to stick around when one module goes away in case we want
> to load the other module. The KVM common code states that it expects to
> have at most one implementation:
>=20
>         /*
>          * kvm_arch_init makes sure there's at most one caller
>          * for architectures that support multiple implementations,
>          * like intel and amd on x86.
>          (...)
>=20
> which is not true in our case due to this requirement of having two
> separate modules loading independently.
>=20
> (tangent) We are already quite different from other architectures since
> we're not making use of kvm_arch_init and some other KVM hooks, such as
> kvm_arch_check_processor_compat. So while other archs have their init
> dispatched by kvm common code, our init and cleanup happens
> independently in the ppc-specific modules, which obviously works but is
> needlessly different and has subtleties in the ordering of operations
> wrt. the kvm common code. (tangent)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ZzHFj0RmvuubG6he
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmExrxMACgkQbDjKyiDZ
s5KohA/9Gfq6pHibFuBWjrN/3iQF/0n0TzlL6x1jWavUn8C6eW+QySpkHDQ1CMV0
27NLIaan0NNq7H4TDxeI4QnVlJOQUXxeTKmtbi8F3fdTceF61M4frRMtH5sMS5fC
0g+t5vzD4Hd1cz8d/fuVVGWiR8HI+L6+ft+V2F7qQA1ruHcG1TPhMFKg+iZidfnL
JEfQHgyQseyYxux96pMumgXHWnX5N5jvvcjMKl22PWQaQRGuavt+iqNeeUTFFrCD
q7VTBsJwvmaXZ255MrbMT7DDtNMFEy/PbV5tWbM7Lb6Y5IQvDeK+kwUsZKi1cYph
U8RzVueTpF2yeK58ZyypXNB8EgMK6SiSycy/Wc1eyiPE4MCFmw0eVgjW4AdUtZpv
4/H8u4+izQOBOLZZ1MoXU36Tdap8v1ApPnFiMTRycIrbEBKJURzjakrI+IDerJF5
6fvfTP1/60PUhdNkjSBDa6SoLi3AKAhetiNcIwAoo4jhIykwoRe+QLTg+ZAzQi2X
SXAKwMKlF8AacTfilP5qiZ0P00UO7fDyDwHXJ5IrPeHNwb+38MbA33d+K9eOgqCv
LtNw6HuGK7G9Z6RPWEB0hrhEPVjeqw3XPLxxkXesEHOnnA+nBMC/gcoiEGCkTF2s
Hw7nJGIsPDYug//XJxY9LQkIV82qkkM9t407sEEoQC2Q+XEstpQ=
=hJiE
-----END PGP SIGNATURE-----

--ZzHFj0RmvuubG6he--
