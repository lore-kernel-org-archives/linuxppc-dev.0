Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0298DC00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:17:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60B0B20834
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 05:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GO0J/wUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60B0B20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RJ0M2XHlzF3KL
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 15:17:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GO0J/wUG";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RGjX3B8nzF3Hd
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 14:19:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="GO0J/wUG"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42RGjX1sN6zB2xk; Fri,  5 Oct 2018 14:19:12 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42RGjX0XZzz9sj2; Fri,  5 Oct 2018 14:19:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538713152;
 bh=n8UKnnn2cKtxY8EsUB5USH/aeDJzLbkfjJ0iohzSdhM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GO0J/wUGBPUugP2qKwdzunN+GXcee8hI8wJZlsp3LRMVsGHKG/odUoJxWFi+C0wT8
 dpgLHZoPlyIanGUjcFOsl3xEUZnnH7TASNiv4A6DSLLYWsNrJlzbNimrmI8BE0CbOq
 zYVW9uUFUo8YnXXP2EHnCJt4iGAYOHoiSdVpHkvM=
Date: Fri, 5 Oct 2018 13:29:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v3 33/33] KVM: PPC: Book3S HV: Add a VM capability to
 enable nested virtualization
Message-ID: <20181005032922.GC13763@umbus.fritz.box>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
 <1538479892-14835-34-git-send-email-paulus@ozlabs.org>
 <20181003062144.GY1886@umbus.fritz.box>
 <20181004094826.GC3255@fergus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
In-Reply-To: <20181004094826.GC3255@fergus>
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


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 04, 2018 at 07:48:26PM +1000, Paul Mackerras wrote:
> On Wed, Oct 03, 2018 at 04:21:44PM +1000, David Gibson wrote:
> > On Tue, Oct 02, 2018 at 09:31:32PM +1000, Paul Mackerras wrote:
> > > With this, userspace can enable a KVM-HV guest to run nested guests
> > > under it.
> [snip]
> > > +/* If set, guests are allowed to create and control nested guests */
> > > +static bool enable_nested =3D true;
> > > +module_param(enable_nested, bool, S_IRUGO | S_IWUSR);
> > > +MODULE_PARM_DESC(enable_nested, "Enable nested virtualization (only =
on POWER9)");
> >=20
> > I'd suggest calling the module parameter just "nested" to match x86.
>=20
> OK.
>=20
> > >  /* If set, the threads on each CPU core have to be in the same MMU m=
ode */
> > >  static bool no_mixing_hpt_and_radix;
> > > =20
> > > @@ -5188,6 +5193,17 @@ static int kvmhv_configure_mmu(struct kvm *kvm=
, struct kvm_ppc_mmuv3_cfg *cfg)
> > >  	return err;
> > >  }
> > > =20
> > > +static int kvmhv_enable_nested(struct kvm *kvm, bool enable)
> > > +{
> > > +	if (!(enable_nested && cpu_has_feature(CPU_FTR_ARCH_300)))
> > > +		return -EINVAL;
> >=20
> > Maybe EPERM, rather than EINVAL.  There's nothing invalid about the
> > ioctl() parameters - we just can't do what they want.
>=20
> Just for pedantry's sake, I'll make it EPERM for !enable_nested and
> ENODEV for !POWER9. :)

Sounds fair.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu22pAACgkQbDjKyiDZ
s5JuEhAA0c/od/SWKpzb/mNeF758xTwySEWScTrtMHwKsm+8wQAlwXZKVyzuuOnF
DOn8zihObGuRyQm7TykHSuVrz+NOUytwvVh8W7kV4ofAFa/uAlX9lIBbULct89s1
klg2QVTnls7p24siEQlrM+7AbJh/0j2/DL2j7S4Ngemcwx8VKZR5WHp7uifX/wxa
/Anw0mxrbl7uuDA3MjpF5iRiIO8hqCNxRntoJHR7kWqjN9BNlMvjlqa9XSA5AgTV
M56VaDvAAHSLb47VLa0vdtrvfByThmk709fqrBpObtFpj5rF7Ir5H2zhCrS/0LrP
nEWKfQDd0Jvf3PaZwhmOWLwuHOVkCup9Ayx38ujzGFYoU4kGm4tMVEHMs7x6Omom
ITEkaHguLsi975Af0JxX2XpsmF5Q/aCmAorCiFp++15El7o+1bff5WlCKg0i2MWW
Wge21I4RCTO+thtM2iW5VKaUOkpxy2Yf4U8WMDQxwuR8lXxWN0IzGnr9/11W2BAT
RXpqmedMD3Pg4evbrdwYpSuCCEVPYj0ZOqsWnlgm+624Fndym3RveHasT5jaMI+H
AS5I6DfWlzkAvuwhEWIxCa4EAUKqnnKds3om96pnIca/994nwz9yJiiJsITcRI6B
5CGqKKGTQ7UaXM0IKy1zwyPenotZiRG8T1prQRwo5Ibu1EGgVhI=
=Yxab
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
