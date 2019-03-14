Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88947C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 03:03:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01BF2213A2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 03:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="a0DZHEqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BF2213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KYSg6ydGzDqMb
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 14:03:47 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KYQY1cVqzDqLx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 14:01:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="a0DZHEqA"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44KYQX6n78z9sD4; Thu, 14 Mar 2019 14:01:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552532516;
 bh=3EEf2i6cQ48Rj+tVo6y4u+7BN0Ah443NTaBEvuAYumo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a0DZHEqAYj6+vqKFreemEx+xvoGXYAWdDCVPeDbpRAdhTxLM7DLPwfmVUXM1J2/54
 gTuNFX3ID2GUP7eC7jwXoB6NAQ/GxeiOqclHMXm29FRK0Xl+gOhTZugmnVLjTRirkd
 YneX5CPQrqQWm0ksbiT83djhDquirIGNO1Hb1wJI=
Date: Thu, 14 Mar 2019 13:33:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 09/16] KVM: PPC: Book3S HV: XIVE: add a control to
 dirty the XIVE EQ pages
Message-ID: <20190314023316.GM8211@umbus.fritz.box>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-10-clg@kaod.org>
 <20190225025329.GM7668@umbus.fritz.box>
 <e952c257-dbc9-fd4c-fd10-20533c4b2c42@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Tnj+unmjHTqEM5y0"
Content-Disposition: inline
In-Reply-To: <e952c257-dbc9-fd4c-fd10-20533c4b2c42@kaod.org>
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


--Tnj+unmjHTqEM5y0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2019 at 12:48:57PM +0100, C=E9dric Le Goater wrote:
> On 2/25/19 3:53 AM, David Gibson wrote:
> > On Fri, Feb 22, 2019 at 12:28:33PM +0100, C=E9dric Le Goater wrote:
> >> When migration of a VM is initiated, a first copy of the RAM is
> >> transferred to the destination before the VM is stopped, but there is
> >> no guarantee that the EQ pages in which the event notification are
> >> queued have not been modified.
> >>
> >> To make sure migration will capture a consistent memory state, the
> >> XIVE device should perform a XIVE quiesce sequence to stop the flow of
> >> event notifications and stabilize the EQs. This is the purpose of the
> >> KVM_DEV_XIVE_EQ_SYNC control which will also marks the EQ pages dirty
> >> to force their transfer.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >> ---
> >>  arch/powerpc/include/uapi/asm/kvm.h        |  1 +
> >>  arch/powerpc/kvm/book3s_xive_native.c      | 67 ++++++++++++++++++++++
> >>  Documentation/virtual/kvm/devices/xive.txt | 29 ++++++++++
> >>  3 files changed, 97 insertions(+)
> >>
> >> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/includ=
e/uapi/asm/kvm.h
> >> index 289c504b7c1d..cd78ad1020fe 100644
> >> --- a/arch/powerpc/include/uapi/asm/kvm.h
> >> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> >> @@ -678,6 +678,7 @@ struct kvm_ppc_cpu_char {
> >>  /* POWER9 XIVE Native Interrupt Controller */
> >>  #define KVM_DEV_XIVE_GRP_CTRL		1
> >>  #define   KVM_DEV_XIVE_RESET		1
> >> +#define   KVM_DEV_XIVE_EQ_SYNC		2
> >>  #define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source attributes */
> >>  #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source attributes =
*/
> >>  #define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit eq attributes */
> >> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/=
book3s_xive_native.c
> >> index dd2a9d411fe7..3debc876d5a0 100644
> >> --- a/arch/powerpc/kvm/book3s_xive_native.c
> >> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> >> @@ -640,6 +640,70 @@ static int kvmppc_xive_reset(struct kvmppc_xive *=
xive)
> >>  	return 0;
> >>  }
> >> =20
> >> +static void kvmppc_xive_native_sync_sources(struct kvmppc_xive_src_bl=
ock *sb)
> >> +{
> >> +	int j;
> >> +
> >> +	for (j =3D 0; j < KVMPPC_XICS_IRQ_PER_ICS; j++) {
> >> +		struct kvmppc_xive_irq_state *state =3D &sb->irq_state[j];
> >> +		struct xive_irq_data *xd;
> >> +		u32 hw_num;
> >> +
> >> +		if (!state->valid)
> >> +			continue;
> >> +		if (state->act_priority =3D=3D MASKED)
> >=20
> > Is this correct?  If you masked an irq, then immediately did a sync,
> > couldn't there still be some of the irqs in flight?  I thought the
> > reason we needed a sync was that masking and other such operations
> > _didn't_ implicitly synchronize.
>=20
> The struct kvmppc_xive_irq_state reflects the state of the EAS=20
> configuration and not the state of the source. The source is masked=20
> setting the PQ bits to '-Q', which is what is being done before calling=
=20
> the KVM_DEV_XIVE_EQ_SYNC control.=20
>=20
> If a source EAS is configured, OPAL syncs the XIVE IC of the source and
> the XIVE IC of the previous target if any. =20
>=20
> So I think we are fine.

Ok.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Tnj+unmjHTqEM5y0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyJvWwACgkQbDjKyiDZ
s5L0Lg//VSoUG231d1KgdIeBpAPlsGbSR8lsstgPuRItnHaDV6U4hGw1l3o0O/to
+nKUVBJf5mSpui5pepj8tCK7Drbgdm3G2BRppzY2DPRS+8F4uoXj2aX3iy25dF+8
xQYmOu0OdW3t3TmPjiv+W2tIRG6nTRDY7MXtrglWkGZ5h+ReY5giqecx4XTBMAee
mP2xjIhRPmyc8vfhH1iKxyWYMVcujcK+2yEqLxITCR0yqISD3Za8s89vyQgTDeth
oN4uvBVtk/PKNdMcO/5urYu/zEtYR+sQYAoZs2SY9ezltw719B1pw3xOzt6JI0lp
nWAQ9coAMgk0XfZ5aVjKsT2ni6aDq+MgvMmVHawwgpzMdxlxYBaIp1Jt8uG7PvW7
d4x+HBt+oTKLZ3nxZfOwT4S57rubBVzMW6f3BwL/w/4aPb8wAfg+ZUYyRwYq8iNg
g9G66Qdgn3zeMHwsVw6HN9tJYP19dEAjbDlSGoILKIwsbKor/jwFi6uTiL5umwgG
BFm4lDfqbNQMhQQDyXyGDYz/f6212naONAPfZbZFIOp2UgdPWDxit2kIIPO64/BJ
oa+XMVpabA+xg73Ut70hAnNJB5Ras2QcqHJJGW/UbbC+/P7g+SEoaaMaaW8XJ4aV
3GHZbvKtpIWVCNvWlpJQAcEtpyDfikARlzj3koK+pW48MUW6TqQ=
=/P88
-----END PGP SIGNATURE-----

--Tnj+unmjHTqEM5y0--
