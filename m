Return-Path: <SRS0=q2Dt=QN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A013C282CB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 01:53:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B4D2184E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 01:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bO5uGonu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B4D2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43vPbd4FThzDqNr
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 12:53:01 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43vPSQ1fXnzDqLg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 12:46:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="bO5uGonu"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43vPSQ034Gz9sNH; Wed,  6 Feb 2019 12:46:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549417606;
 bh=mWDhgurBVaJ27aViCyXXFgoNn7cKVC8HUIeAdFg38kY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bO5uGonuAS3Zm1eTnQ+uEFaYwHJxPSaP4UrKNJNVTZO/5d3mJf2ZG1CCfhkEqeprI
 q9AMgaQCylGuCMUxxR+8ghARMK7/ZJIKpDv+rDCLmo/FoSCHtlPnUUnhL/0lcoDKqZ
 diAykQoHQLfwAVIqQ0i246J0XuvzXmR8k7wWL8S0=
Date: Wed, 6 Feb 2019 12:24:47 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 15/19] KVM: PPC: Book3S HV: add get/set accessors for the
 source configuration
Message-ID: <20190206012447.GR22661@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-16-clg@kaod.org>
 <20190204052148.GH1927@umbus.fritz.box>
 <02ee0470-3c6a-5c5c-a903-44e172ce1ed5@kaod.org>
 <20190205053233.GG22661@umbus.fritz.box>
 <c0faf4dd-7af1-d97a-f8f1-838fcf412ab8@kaod.org>
 <20190206012329.GQ22661@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IUSVF+LtaR4kWxuH"
Content-Disposition: inline
In-Reply-To: <20190206012329.GQ22661@umbus.fritz.box>
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


--IUSVF+LtaR4kWxuH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 12:23:29PM +1100, David Gibson wrote:
> On Tue, Feb 05, 2019 at 02:03:11PM +0100, C=E9dric Le Goater wrote:
> > On 2/5/19 6:32 AM, David Gibson wrote:
> > > On Mon, Feb 04, 2019 at 05:07:28PM +0100, C=E9dric Le Goater wrote:
> > >> On 2/4/19 6:21 AM, David Gibson wrote:
> > >>> On Mon, Jan 07, 2019 at 07:43:27PM +0100, C=E9dric Le Goater wrote:
> > >>>> Theses are use to capure the XIVE EAS table of the KVM device, the
> > >>>> configuration of the source targets.
> > >>>>
> > >>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> > >>>> ---
> > >>>>  arch/powerpc/include/uapi/asm/kvm.h   | 11 ++++
> > >>>>  arch/powerpc/kvm/book3s_xive_native.c | 87 ++++++++++++++++++++++=
+++++
> > >>>>  2 files changed, 98 insertions(+)
> > >>>>
> > >>>> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/in=
clude/uapi/asm/kvm.h
> > >>>> index 1a8740629acf..faf024f39858 100644
> > >>>> --- a/arch/powerpc/include/uapi/asm/kvm.h
> > >>>> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> > >>>> @@ -683,9 +683,20 @@ struct kvm_ppc_cpu_char {
> > >>>>  #define   KVM_DEV_XIVE_SAVE_EQ_PAGES	4
> > >>>>  #define KVM_DEV_XIVE_GRP_SOURCES	2	/* 64-bit source attributes */
> > >>>>  #define KVM_DEV_XIVE_GRP_SYNC		3	/* 64-bit source attributes */
> > >>>> +#define KVM_DEV_XIVE_GRP_EAS		4	/* 64-bit eas attributes */
> > >>>> =20
> > >>>>  /* Layout of 64-bit XIVE source attribute values */
> > >>>>  #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
> > >>>>  #define KVM_XIVE_LEVEL_ASSERTED		(1ULL << 1)
> > >>>> =20
> > >>>> +/* Layout of 64-bit eas attribute values */
> > >>>> +#define KVM_XIVE_EAS_PRIORITY_SHIFT	0
> > >>>> +#define KVM_XIVE_EAS_PRIORITY_MASK	0x7
> > >>>> +#define KVM_XIVE_EAS_SERVER_SHIFT	3
> > >>>> +#define KVM_XIVE_EAS_SERVER_MASK	0xfffffff8ULL
> > >>>> +#define KVM_XIVE_EAS_MASK_SHIFT		32
> > >>>> +#define KVM_XIVE_EAS_MASK_MASK		0x100000000ULL
> > >>>> +#define KVM_XIVE_EAS_EISN_SHIFT		33
> > >>>> +#define KVM_XIVE_EAS_EISN_MASK		0xfffffffe00000000ULL
> > >>>> +
> > >>>>  #endif /* __LINUX_KVM_POWERPC_H */
> > >>>> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/=
kvm/book3s_xive_native.c
> > >>>> index f2de1bcf3b35..0468b605baa7 100644
> > >>>> --- a/arch/powerpc/kvm/book3s_xive_native.c
> > >>>> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> > >>>> @@ -525,6 +525,88 @@ static int kvmppc_xive_native_sync(struct kvm=
ppc_xive *xive, long irq, u64 addr)
> > >>>>  	return 0;
> > >>>>  }
> > >>>> =20
> > >>>> +static int kvmppc_xive_native_set_eas(struct kvmppc_xive *xive, l=
ong irq,
> > >>>> +				      u64 addr)
> > >>>
> > >>> I'd prefer to avoid the name "EAS" here.  IIUC these aren't "raw" E=
AS
> > >>> values, but rather essentially the "source config" in the terminolo=
gy
> > >>> of the PAPR hcalls.  Which, yes, is basically implemented by setting
> > >>> the EAS, but since it's the PAPR architected state that we need to
> > >>> preserve across migration, I'd prefer to stick as close as we can to
> > >>> the PAPR terminology.
> > >>
> > >> But we don't have an equivalent name in the PAPR specs for the tuple=
=20
> > >> (prio, server). We could use the generic 'target' name may be ? even=
=20
> > >> if this is usually referring to a CPU number.
> > >=20
> > > Um.. what?  That's about terminology for one of the fields in this
> > > thing, not about the name for the thing itself.
> > >=20
> > >> Or, IVE (Interrupt Vector Entry) ? which makes some sense.=20
> > >> This is was the former name in HW. I think we recycle it for KVM.
> > >=20
> > > That's a terrible idea, which will make a confusing situation even
> > > more confusing.
> >=20
> > Let's use SOURCE_CONFIG and QUEUE_CONFIG. The KVM ioctls are very=20
> > similar to the hcalls anyhow.
>=20
> Yes, I think that's a good idea.

Actually... AIUI the SET_CONFIG hcalls shouldn't be a fast path.  Can
we simplify things further by removing the hcall implementation from
the kernel entirely, and have qemu implement them by basically just
forwarding them to the appropriate SET_CONFIG ioctl()?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IUSVF+LtaR4kWxuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxaN18ACgkQbDjKyiDZ
s5Ib5RAAnBPWne1f+5r8DVripgRBuj+bTIpvb3NVI3aaSmOJIulAIkCY9mKULCRK
CgYAUfHqWvers9zRkPGCnttlE6brvncugI+sKhrYJBOQN9O5epgP5Ve3iLWNBaOK
rcKQ/j4SbfpccQiYmZcw/dRkJANVKRS08UBfmkC891MfSUjhRXRRQwqBefvTksEp
EUmE4QTJET9L/nhRwzd5LTnOwNl5gYjHOO72EWUQznodctysmWm5J1Ko4u9Zvpvc
0VcVL670OfxoJtTzn0D0gyuL087iHZt7glWBSVQC1r/EilWQg0hX/CJ3TJKjCfBu
WWP9Xsz2oJe/oSJzlTjgO2lWcNbZze/kSVsmJpO334D1heAKFD98UfXOSjuXSI5I
ToQ2udl8jdIGNuyV1Dy6J4G5zMTf/RIoN+vh+PDgB441tbO2NRaYUOeURdmXmMdV
OJsMTKbOpAmm7Gd8kUuRoKqlaYXp0x46XeqevqSgJ+E0gpQd9OVgfYRYFHi2ACYO
3TsWa689+YVpDzhEsAtTJuzWC0IpBr+V4UbZa1De8Y+59zkbuAO3Al1tsbAOCQfF
W+gcRRnfUEdP1axhJ1uq54anKJkuri3NDoxz1Bn2yXgNrodWmdh9NHVD1Rm9Jyij
jM9UX4RiVmSDUTwlTYcvyKsUnLsvz9rku3jEFqMJ21J01m2aDa0=
=JKCz
-----END PGP SIGNATURE-----

--IUSVF+LtaR4kWxuH--
