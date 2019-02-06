Return-Path: <SRS0=q2Dt=QN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FFEC282CB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 01:51:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD29E2184E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 01:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ll0tAyxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD29E2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43vPZ042DYzDqM4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Feb 2019 12:51:36 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43vPSP6pvXzDqLb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2019 12:46:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="ll0tAyxo"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43vPSP5BhFz9sN9; Wed,  6 Feb 2019 12:46:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549417605;
 bh=wW/8kwsIiagLdsZWpPopYyBf9Xc1zJlUbrMigm1vJUQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ll0tAyxovtX3s/eMt2/QOsFzlwZnTtOEOYQq0aZ2MAvwdQ3IPhQLRfH+Z0x3jLEn7
 HWREjswOmqGJuqliqLski9+sjWZaqP7DgU/8pT1c9K2PtmTzuQOxRbyQuqO3XPUtUC
 UY07tHsvcGzNn0jH4uBXT/cQj6qOVvL0vPi6jwnc=
Date: Wed, 6 Feb 2019 12:23:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 06/19] KVM: PPC: Book3S HV: add a GET_ESB_FD control to
 the XIVE native device
Message-ID: <20190206012308.GP22661@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-7-clg@kaod.org>
 <20190204044531.GB1927@umbus.fritz.box>
 <69791b73-f93e-6957-92e8-5b8620b87731@kaod.org>
 <20190205052822.GE22661@umbus.fritz.box>
 <4d565738-a99b-0333-8533-037677358faa@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="v9g2r9e2kvGs7M7R"
Content-Disposition: inline
In-Reply-To: <4d565738-a99b-0333-8533-037677358faa@kaod.org>
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


--v9g2r9e2kvGs7M7R
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 05, 2019 at 01:55:40PM +0100, C=E9dric Le Goater wrote:
> On 2/5/19 6:28 AM, David Gibson wrote:
> > On Mon, Feb 04, 2019 at 12:30:39PM +0100, C=E9dric Le Goater wrote:
> >> On 2/4/19 5:45 AM, David Gibson wrote:
> >>> On Mon, Jan 07, 2019 at 07:43:18PM +0100, C=E9dric Le Goater wrote:
> >>>> This will let the guest create a memory mapping to expose the ESB MM=
IO
> >>>> regions used to control the interrupt sources, to trigger events, to
> >>>> EOI or to turn off the sources.
> >>>>
> >>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>> ---
> >>>>  arch/powerpc/include/uapi/asm/kvm.h   |  4 ++
> >>>>  arch/powerpc/kvm/book3s_xive_native.c | 97 ++++++++++++++++++++++++=
+++
> >>>>  2 files changed, 101 insertions(+)
> >>>>
> >>>> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/incl=
ude/uapi/asm/kvm.h
> >>>> index 8c876c166ef2..6bb61ba141c2 100644
> >>>> --- a/arch/powerpc/include/uapi/asm/kvm.h
> >>>> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> >>>> @@ -675,4 +675,8 @@ struct kvm_ppc_cpu_char {
> >>>>  #define  KVM_XICS_PRESENTED		(1ULL << 43)
> >>>>  #define  KVM_XICS_QUEUED		(1ULL << 44)
> >>>> =20
> >>>> +/* POWER9 XIVE Native Interrupt Controller */
> >>>> +#define KVM_DEV_XIVE_GRP_CTRL		1
> >>>> +#define   KVM_DEV_XIVE_GET_ESB_FD	1
> >>>
> >>> Introducing a new FD for ESB and TIMA seems overkill.  Can't you get
> >>> to both with an mmap() directly on the xive device fd?  Using the
> >>> offset to distinguish which one to map, obviously.
> >>
> >> The page offset would define some sort of user API. It seems feasible.
> >> But I am not sure this would be practical in the future if we need to=
=20
> >> tune the length.
> >=20
> > Um.. why not?  I mean, yes the XIVE supports rather a lot of
> > interrupts, but we have 64-bits of offset we can play with - we can
> > leave room for billions of ESB slots and still have room for billions
> > of VPs.
>=20
> So the first 4 pages could be the TIMA pages and then would come =20
> the pages for the interrupt ESBs. I think that we can have different=20
> vm_fault handler for each mapping.

Um.. no, I'm saying you don't need to tightly pack them.  So you could
have the ESB pages at 0, the TIMA at, say offset 2^60.

> I wonder how this will work out with pass-through. As Paul said in=20
> a previous email, it would be better to let QEMU request a new=20
> mapping to handle the ESB pages of the device being passed through.
> I guess this is not a special case, just another offset and length.

Right, if we need multiple "chunks" of ESB pages we can given them
each their own terabyte or several.  No need to be stingy with address
space.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--v9g2r9e2kvGs7M7R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxaNvwACgkQbDjKyiDZ
s5LZbQ//Z8rGXvbT3WT9eTos2kBsnCDO+PRirLlo4YnBAGxGV3o+umxTugKYJ9n8
dRQNKhQWOTLwaPvunCj4S9DqX8NePF4qO2wbtF0GByfIFEYnXOEvS1ejzSxYikb6
zzOAfJ4IU/Nlw1t11v5DnO4QRwxm9r9CPse4s/Yw2OWjVun+IWL7INz5qIG/gAWA
8bjwPcLrUoNDFn69kTrLJNzp83XK/vOeCpgA9h9etFtD6fWLJqH6g289vTg9JTRy
70/SQYBmnh64gTYIJOHV16qUHX3oUJGh0fdTY+9kMZIe9uewwcRNrdhqV6SQ/3lc
LAx7T7nWGxF7y0QDkLCiFhJGHGZuM8sbZFkYAKdSyirj0Dli8Z42K7Tv7Tfrbxtr
k9hkg+KhAoTMPC3f9cm1DwhDJX2wljnEkoIbZ2iv1p7z6BvQJgLpdscSETlDhdAs
QwGsSu6MChKz4QQETt+KBlTRMUoMDhwBGKW+fHWfwIFsNg5pZHkosAJfj8M0q4nB
XLwDTIkD6xdZuFsaVu17L9ijD00gZD2E/J9d0a/KjCjPjy0zU7Ce0aNNACOFNCtb
b4KGtmDTT9egtSLXAVMHHZ+HeQiYluFgyK+38+FYuhK8Cit7PCr/V/YiLDDaTwAp
Jywd+vy2oqjLV2RgUKxiwQhFwZXhpPKDuxMn1EWYV9tb7YrWrfs=
=HgWx
-----END PGP SIGNATURE-----

--v9g2r9e2kvGs7M7R--
