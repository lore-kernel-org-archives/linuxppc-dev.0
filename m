Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A357C43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 06:05:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCDA820878
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 06:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mBHhnu7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCDA820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PTBx48wszF3Dx
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 16:04:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="mBHhnu7f";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PT7W0G9JzF37B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 16:01:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="mBHhnu7f"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42PT7V6P8hz9sj1; Tue,  2 Oct 2018 16:01:58 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42PT7V5fvqz9shx; Tue,  2 Oct 2018 16:01:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538460118;
 bh=14SlnH8iVN2DHKneG4mNnzT/GRaKt4S/ukHLSisLqK4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mBHhnu7fQNfFcIW4LvhlZemHWd3qvLWmJp5ehoPqyCYS1a/aTj7mKYh6EZgewRiJ7
 WLYyngKzElzRcFIt7r9N8C3DGu76R+xOFwlUucO/oM9/2V1ss1lNj7BAIOtqkSTu2U
 Ki/tb44ZJjEXc015o4pALfjkY8+htowp5o2s8PaQ=
Date: Tue, 2 Oct 2018 14:49:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v2 02/33] KVM: PPC: Book3S HV: Remove left-over code in
 XICS-on-XIVE emulation
Message-ID: <20181002044937.GF1886@umbus.fritz.box>
References: <1538127963-15645-1-git-send-email-paulus@ozlabs.org>
 <1538127963-15645-3-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="b8GWCKCLzrXbuNet"
Content-Disposition: inline
In-Reply-To: <1538127963-15645-3-git-send-email-paulus@ozlabs.org>
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


--b8GWCKCLzrXbuNet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2018 at 07:45:32PM +1000, Paul Mackerras wrote:
> This removes code that clears the external interrupt pending bit in
> the pending_exceptions bitmap.  This is left over from an earlier
> iteration of the code where this bit was set when an escalation
> interrupt arrived in order to wake the vcpu from cede.  Currently
> we set the vcpu->arch.irq_pending flag instead for this purpose.
> Therefore there is no need to do anything with the pending_exceptions
> bitmap.
>=20
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/kvm/book3s_xive_template.c | 8 --------
>  1 file changed, 8 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_xive_template.c b/arch/powerpc/kvm/b=
ook3s_xive_template.c
> index 203ea65..033363d 100644
> --- a/arch/powerpc/kvm/book3s_xive_template.c
> +++ b/arch/powerpc/kvm/book3s_xive_template.c
> @@ -280,14 +280,6 @@ X_STATIC unsigned long GLUE(X_PFX,h_xirr)(struct kvm=
_vcpu *vcpu)
>  	/* First collect pending bits from HW */
>  	GLUE(X_PFX,ack_pending)(xc);
> =20
> -	/*
> -	 * Cleanup the old-style bits if needed (they may have been
> -	 * set by pull or an escalation interrupts).
> -	 */
> -	if (test_bit(BOOK3S_IRQPRIO_EXTERNAL, &vcpu->arch.pending_exceptions))
> -		clear_bit(BOOK3S_IRQPRIO_EXTERNAL,
> -			  &vcpu->arch.pending_exceptions);
> -
>  	pr_devel(" new pending=3D0x%02x hw_cppr=3D%d cppr=3D%d\n",
>  		 xc->pending, xc->hw_cppr, xc->cppr);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--b8GWCKCLzrXbuNet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAluy+OEACgkQbDjKyiDZ
s5K6ZhAAwgX0yEBTyUT+cFn2zXKK1oQ8C1eLCTRIWcEsx6nrCt/44/fBEyvn7moG
oXjoALUWiiKCxwlZqBb8G4tAe9UHTcCRHlGCglt57F7YPS0yTneMSZrUCnqWzglb
BnSLcsJalNgI84sI7JeiEDfDpVjh/c0NOPI2RPRlv9FuB/gTZTuePBhLDSH2u3y2
fcVJh4ZeMbmOULTlOKTHzgBb1BZWSdyqz1WCJY4bVayUA/CVcuMfngEsMxiQ6McD
ji+tRxPMVNrJZJWr0ZFxifPF3D4BfCaJlYX/yMj/0Lgw9eWodiaA0OYZsqOlf2Uv
NIDn6SIzQ7MeEyvtbetR517eZ6ZHL12BwCg67MPCbEbd8bytSxX5d8ANvd2NaPTw
wQUXCwcnBBW1IEaTE2BuF+XAgND34bR2y4QykARQ5lKQEe1UDhxqT+lFKj0Xnmex
/nxOWOnHMQHNijBw49cxDlsJsw/aB9cFnsAJKgpmObIKmxRI/D1Lgjlmn7nZ/XkS
pAg44kfaxr55L55qqRfTnBjO4++YVpfqPNd6b5n5zcvYUQlIbpc6UxeYVBi9esOF
VemQLbB/O2U98aaKWZV4/mN4iY501dxJDvTlPPz6bh6g9LXSNz8OxMazlkGBwHZv
eA3Se8lGOn4V9mJwWXYEutwlGCONPIs7tlv2YiKADGiCgc3BTi0=
=Gnco
-----END PGP SIGNATURE-----

--b8GWCKCLzrXbuNet--
