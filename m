Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B10C169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 03:01:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B11D2217F9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 03:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YlAmKKU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B11D2217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w34H5vmXzDqMb
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 14:01:35 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w30M60dJzDqMX
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 13:58:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="YlAmKKU0"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43w30M4Q9mz9sN8; Thu,  7 Feb 2019 13:58:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549508291;
 bh=7X9TIj71WiyYmvnibicoKLKMVlTek4chAz0f0QKNqpI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YlAmKKU0cMp6jXwYLSqDCMXp6mZOPwdWa56GNACC0nZb1GkQf60sE+ugcnWj8C872
 MmOVBeeiuMTTyYJhCUPQNQ+UToASriXUD3hIlUJVOR+BbwYHxBgzEYHrYT43rehuq6
 eKdrnR9GWpBY6PfDnMECtVfRnwdZz5dnI7K3r/UM=
Date: Thu, 7 Feb 2019 13:49:50 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 06/19] KVM: PPC: Book3S HV: add a GET_ESB_FD control to
 the XIVE native device
Message-ID: <20190207024950.GA22661@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-7-clg@kaod.org>
 <20190204044531.GB1927@umbus.fritz.box>
 <69791b73-f93e-6957-92e8-5b8620b87731@kaod.org>
 <20190205052822.GE22661@umbus.fritz.box>
 <4d565738-a99b-0333-8533-037677358faa@kaod.org>
 <20190206012308.GP22661@umbus.fritz.box>
 <1745dd9f-2927-cae6-e8da-c350b0bd0a66@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+9kyDs7IugQ0lHaC"
Content-Disposition: inline
In-Reply-To: <1745dd9f-2927-cae6-e8da-c350b0bd0a66@kaod.org>
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


--+9kyDs7IugQ0lHaC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 08:21:10AM +0100, C=E9dric Le Goater wrote:
> On 2/6/19 2:23 AM, David Gibson wrote:
> > On Tue, Feb 05, 2019 at 01:55:40PM +0100, C=E9dric Le Goater wrote:
> >> On 2/5/19 6:28 AM, David Gibson wrote:
> >>> On Mon, Feb 04, 2019 at 12:30:39PM +0100, C=E9dric Le Goater wrote:
> >>>> On 2/4/19 5:45 AM, David Gibson wrote:
> >>>>> On Mon, Jan 07, 2019 at 07:43:18PM +0100, C=E9dric Le Goater wrote:
> >>>>>> This will let the guest create a memory mapping to expose the ESB =
MMIO
> >>>>>> regions used to control the interrupt sources, to trigger events, =
to
> >>>>>> EOI or to turn off the sources.
> >>>>>>
> >>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>>>> ---
> >>>>>>  arch/powerpc/include/uapi/asm/kvm.h   |  4 ++
> >>>>>>  arch/powerpc/kvm/book3s_xive_native.c | 97 ++++++++++++++++++++++=
+++++
> >>>>>>  2 files changed, 101 insertions(+)
> >>>>>>
> >>>>>> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/in=
clude/uapi/asm/kvm.h
> >>>>>> index 8c876c166ef2..6bb61ba141c2 100644
> >>>>>> --- a/arch/powerpc/include/uapi/asm/kvm.h
> >>>>>> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> >>>>>> @@ -675,4 +675,8 @@ struct kvm_ppc_cpu_char {
> >>>>>>  #define  KVM_XICS_PRESENTED		(1ULL << 43)
> >>>>>>  #define  KVM_XICS_QUEUED		(1ULL << 44)
> >>>>>> =20
> >>>>>> +/* POWER9 XIVE Native Interrupt Controller */
> >>>>>> +#define KVM_DEV_XIVE_GRP_CTRL		1
> >>>>>> +#define   KVM_DEV_XIVE_GET_ESB_FD	1
> >>>>>
> >>>>> Introducing a new FD for ESB and TIMA seems overkill.  Can't you get
> >>>>> to both with an mmap() directly on the xive device fd?  Using the
> >>>>> offset to distinguish which one to map, obviously.
> >>>>
> >>>> The page offset would define some sort of user API. It seems feasibl=
e.
> >>>> But I am not sure this would be practical in the future if we need t=
o=20
> >>>> tune the length.
> >>>
> >>> Um.. why not?  I mean, yes the XIVE supports rather a lot of
> >>> interrupts, but we have 64-bits of offset we can play with - we can
> >>> leave room for billions of ESB slots and still have room for billions
> >>> of VPs.
> >>
> >> So the first 4 pages could be the TIMA pages and then would come =20
> >> the pages for the interrupt ESBs. I think that we can have different=
=20
> >> vm_fault handler for each mapping.
> >=20
> > Um.. no, I'm saying you don't need to tightly pack them.  So you could
> > have the ESB pages at 0, the TIMA at, say offset 2^60.
>=20
> Well, we know that the TIMA is 4 pages wide and is "directly" related
> with the KVM interrupt device. So being at offset 0 seems a good idea.
> While the ESB segment is of a variable size depending on the number
> of IRQs and it can come after I think.
>=20
> >> I wonder how this will work out with pass-through. As Paul said in=20
> >> a previous email, it would be better to let QEMU request a new=20
> >> mapping to handle the ESB pages of the device being passed through.
> >> I guess this is not a special case, just another offset and length.
> >=20
> > Right, if we need multiple "chunks" of ESB pages we can given them
> > each their own terabyte or several.  No need to be stingy with address
> > space.
>=20
> You can not put them anywhere. They should map the same interrupt range
> of ESB pages, overlapping with the underlying segment of IPI ESB pages.=
=20

I don't really follow what you're saying here.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+9kyDs7IugQ0lHaC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxbnM4ACgkQbDjKyiDZ
s5J5/hAAjM27mh638q+AU4PALSM254/wSvHKLqrXHz8kaZXBDq+InhxS/W15TKMf
d7nCjya8ScTONeQ9C+G+ljOHFezGvLkpP8k+3UoGzf2rK4zteVa3RJsqbRifC30v
IB0PEnOw5cyLuzcVcDWnibaHzbf31y7+mOOsp8Qmn4taWwd0RHKSUwKU9i7EZLvZ
P7toWyvSQ9PwKFzkwe3HKjXr9gUi8XGF0unImr0zuzWMZdfBPnoT5J+spcGC9DlD
oTseMxP7EdAvzTJFqCat+Tu9CmV4YOfpIHB6sSN/2PZl9/9dJgJrdDpdKCj5qANZ
An6O9zaLmFguQeq0MP6MJMyO+3o2kS1wMJQbUQdawzz/KXeGjYuMr2gpGyJsX5A3
yZOJihnOmFWDoksFTWVLKqL+pE+ocv/+k0qM5gQX9PZia+avzW5LtRgsXhTcZnb5
WZCiDkQ87ppAbyS+GQA+a/cBR6zD2ln2IwpbBrirEKe5XpLm+g6CA7+nByh3aF2Q
Dx2nIMycyq+wln07pGKbEjHwUOIC5DIIBm5xBhwZssJeTbPCDYssgsWiXQds1dGz
vrmdIQGPid55RCId5GPaWQ0qviM1kSvrNunQpjMNJFxP0Mlxa2+BzmcwUlj1U7rp
eoqXbSRvwg/ESs//u1vp5Lq2+H5nZufNyKD4h4l61CJuM7QsrN4=
=LMB+
-----END PGP SIGNATURE-----

--+9kyDs7IugQ0lHaC--
