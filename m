Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F094C169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 02:00:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844B22083B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 02:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="m1uKrs0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844B22083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43t9rf2JtFzDqGY
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 13:00:02 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43t9pk5ZWqzDqFw
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 12:58:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="m1uKrs0c"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43t9pk38Wzz9sDX; Mon,  4 Feb 2019 12:58:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549245502;
 bh=LgaMeKQsK1oVKYKuQCGqnxs1Pbzeq9qd91RWx2d6U+Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=m1uKrs0cRPBNTLIMlcjWLkJuvcpulT84jk6BvGqf7NPUognPy2Svn2PSgyuErl3P8
 6FfGekTmYwE4P+C39jE9IyezxgkjAnHdcjUDJyjg2ycB3eCXhNwyRPEazEiU0o0Nr7
 th/Qqc0LjeFAF7jwaS8RoTejHMluP5uwgRI0feM0=
Date: Mon, 4 Feb 2019 11:50:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 03/19] KVM: PPC: Book3S HV: check the IRQ controller type
Message-ID: <20190204005056.GC2593@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-4-clg@kaod.org>
 <20190122045642.GB15124@blackberry>
 <29eab965-3e98-714c-7686-f6caa59f3672@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <29eab965-3e98-714c-7686-f6caa59f3672@kaod.org>
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 23, 2019 at 05:24:13PM +0100, C=E9dric Le Goater wrote:
> On 1/22/19 5:56 AM, Paul Mackerras wrote:
> > On Mon, Jan 07, 2019 at 07:43:15PM +0100, C=E9dric Le Goater wrote:
> >> We will have different KVM devices for interrupts, one for the
> >> XICS-over-XIVE mode and one for the XIVE native exploitation
> >> mode. Let's add some checks to make sure we are not mixing the
> >> interfaces in KVM.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  arch/powerpc/kvm/book3s_xive.c | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_=
xive.c
> >> index f78d002f0fe0..8a4fa45f07f8 100644
> >> --- a/arch/powerpc/kvm/book3s_xive.c
> >> +++ b/arch/powerpc/kvm/book3s_xive.c
> >> @@ -819,6 +819,9 @@ u64 kvmppc_xive_get_icp(struct kvm_vcpu *vcpu)
> >>  {
> >>  	struct kvmppc_xive_vcpu *xc =3D vcpu->arch.xive_vcpu;
> >> =20
> >> +	if (!kvmppc_xics_enabled(vcpu))
> >> +		return -EPERM;
> >> +
> >>  	if (!xc)
> >>  		return 0;
> >> =20
> >> @@ -835,6 +838,9 @@ int kvmppc_xive_set_icp(struct kvm_vcpu *vcpu, u64=
 icpval)
> >>  	u8 cppr, mfrr;
> >>  	u32 xisr;
> >> =20
> >> +	if (!kvmppc_xics_enabled(vcpu))
> >> +		return -EPERM;
> >> +
> >>  	if (!xc || !xive)
> >>  		return -ENOENT;
> >=20
> > I can't see how these new checks could ever trigger in the code as it
> > stands.  Is there a way at present?=20
>=20
> It would require some custom QEMU doing silly things : create the XICS=20
> KVM device, and then call kvm_get_one_reg(KVM_REG_PPC_ICP_STATE) or=20
> kvm_set_one_reg(icp->cs, KVM_REG_PPC_ICP_STATE) without connecting the
> vCPU to its presenter.=20
>=20
> Today, you get a ENOENT.

TBH, ENOENT seems fine to me.

> > Do following patches ever add a path where the new checks could trigger=
,=20
> > or is this just an excess of caution?=20
>=20
> With the following patches, QEMU could to do something even more silly,
> which is to mix the interrupt mode interfaces : create a KVM XICS device =
  =20
> and call KVM CPU ioctls of the KVM XIVE device, or the opposite.

AFAICT, like above, that won't really differ from calling the XIVE CPU
ioctl()s when no irqchip is set up at all, and should be covered by
just a !xive check.

>=20
> > (Your patch description should ideally have answered these questions > =
for me.)
>=20
> Yes. I also think that I introduced this patch to early in the series.
> It make more sense when the XICS and the XIVE KVM devices are available. =
=20
>=20
> Thanks,
>=20
> C.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxXjG0ACgkQbDjKyiDZ
s5JdxBAAu9jVdvgAubApIe5fFdxZuqfau4R5OGIq98z/iEc685DvPAoCEoxknfBM
ozvOHCc4ylNfWOpDbongndCut1JhhWTDd7H8hZ5NcDkPyGzh5eQzoDPGZhJcMsoi
fIXe5P7kb6HtWzY2iILlnE7Ya3HAxGICh3AUm4tuQ+U+BYh3XxewEVuSIjFY7mkr
6b4wpYRPOpE2p2uSBek0p/PDOZR4DVLn+GW2T+4guo+/TblxrXEKG/LJryY9Awf8
n3KBf8zS/X2jSptQ5J8U4XQY7BuJp13Y0Ktc879UICoX6X+a5yxO2DtID/DQS4Md
MqLTpd53Cd1IO0I+4ypvtp8kq9RU48EfZkQVzJ/+GHHpzyli9IdX81kDcEv1/Om4
y+/CIYQ4PigP68OmGutaHMisJLiLu3OtdIKARa4KUv/7thRHdHlLKz8IEa4UynES
jbY2zoRGVgNetGI0eSZTk97VSnDSWgIampC9auKiDOmRp/fslEp4vPRYNIGzMD9Y
5ohwaRNdorfcV2owGu3WtY9TUyytKq48C0QWK6d2B4+oSL4XegD34b2xU/m0RV8/
roB5eFQVBy+3v+aj15UXnRcsehY+281id+SyUdvAhEKyIoagHoO6Qx36QgO4RyPO
h9OttCU5nYzZDT6jc6eND0FLNcBzSeixQN9FLUAnR3TWW5PKccg=
=Nc4Y
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
