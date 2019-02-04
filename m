Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57706C282D7
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:29:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C17542177E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 06:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jayhnYYi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17542177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tHqx15Q0zDqGb
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 17:29:49 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tHSL1qBnzDqGQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 17:12:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="jayhnYYi"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43tHSK6Fq1z9sNH; Mon,  4 Feb 2019 17:12:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549260769;
 bh=8DBqDp7bYWJlsnhUAl8pHH5mqp5dTUyUbox1Rl+49b4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jayhnYYiEjKWaSIWbWLgSdfEVoEYT2rU7QPrrkviuNR7kgq1FfMB/jNuI/QPUeRgB
 X5/YSugEQqpYWYmZ4y/NetYksDG0aUMABtyTw5JxVKwx5zU5waj0nIVF2JqkS3EQFW
 tDRqz3FoZU+2nk5Ms0r+4aWtc10sTBnrSEkvWqXM=
Date: Mon, 4 Feb 2019 16:36:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 00/19] KVM: PPC: Book3S HV: add XIVE native exploitation
 mode
Message-ID: <20190204053610.GK1927@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190122044654.GA15124@blackberry>
 <2f9b4420-ef90-20b8-d31b-dc547a6aa6b4@kaod.org>
 <a420acfb9f375b27bc1203fbb15312a61eb0c34d.camel@kernel.crashing.org>
 <06b7c4d2-72ba-ca4f-aded-789280798136@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d6d1KVhp94hk3Jrm"
Content-Disposition: inline
In-Reply-To: <06b7c4d2-72ba-ca4f-aded-789280798136@kaod.org>
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


--d6d1KVhp94hk3Jrm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 26, 2019 at 09:25:04AM +0100, C=E9dric Le Goater wrote:
> Was there a crashing.org shutdown ?=20
>=20
>   Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
> 	by in5.mail.ovh.net (Postfix) with ESMTPS id 43mYnj0nrlz1N7KC
> 	for <clg@kaod.org>; Fri, 25 Jan 2019 22:38:00 +0000 (UTC)
>   Received: from localhost (localhost.localdomain [127.0.0.1])
> 	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x0NLZf4K021092;
> 	Wed, 23 Jan 2019 15:35:43 -0600
>=20
>=20
> On 1/23/19 10:35 PM, Benjamin Herrenschmidt wrote:
> > On Wed, 2019-01-23 at 20:07 +0100, C=E9dric Le Goater wrote:
> >>  Event Assignment Structure, a.k.a IVE (Interrupt Virtualization Entry)
> >>
> >> All the names changed somewhere between XIVE v1 and XIVE v2. OPAL and
> >> Linux should be adjusted ...
> >=20
> > All the names changed between the HW design and the "architecture"
> > document. The HW guys use the old names, the architecture the new
> > names, and Linux & OPAL mostly use the old ones because frankly the new
> > names suck big time.
>=20
> Well, It does not make XIVE any clearer ... I did prefer the v1 names
> but there was some naming overlap in the concepts.=20
>=20
> >> It would be good to talk a little about the nested support (offline=20
> >> may be) to make sure that we are not missing some major interface that=
=20
> >> would require a lot of change. If we need to prepare ground, I think
> >> the timing is good.
> >>
> >> The size of the IRQ number space might be a problem. It seems we=20
> >> would need to increase it considerably to support multiple nested=20
> >> guests. That said I haven't look much how nested is designed. =20
> >=20
> > The size of the VP space is a bigger concern. Even today. We really
> > need qemu to tell the max #cpu to KVM so we can allocate less of them.
>=20
> ah yes. we would also need to reduce the number of available priorities=
=20
> per CPU to have more EQ descriptors available if I recall well.=20
>=20
> > As for nesting, I suggest for the foreseeable future we stick to XICS
> > emulation in nested guests.
>=20
> ok. so no kernel_irqchip at all. hmm. =20

That would certainly be step 0, making sure the capability advertises
this correctly.  I think we do want to make XICs-on-XIVE emulation
work in a KVM L1 (so we'd need to have it make XIVE hcalls to the L0
instead of OPAL calls).

XIVE-on-XIVE for L1 would be nice too, which would mean implementing
the XIVE hcalls from the L2 in terms of XIVE hcalls to the L0.  I
think it's ok to delay this indefinitely as long as the caps advertise
correctly so that qemu will use userspace emulation until its ready.

> I was wondering how possible it was to have L2 initialize the underlying=
=20
> OPAL structures in the L0 hypervisor. May be with a sort of proxy hcall=
=20
> which would perform the initialization in QEMU L1 on behalf of L2.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--d6d1KVhp94hk3Jrm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxXz0oACgkQbDjKyiDZ
s5IIqQ//T4mY2mR8V5zvfzz59IoHL4G1+V97HmzSqSWOQxYe+W4V4+9/tjvCPlF2
aUY8VZP6IDrZjND4GWk8mx1YMZ+aHYwf2sB6tNnUnXykBVfwOQMPSBKsNJB20TM6
IRSnyP6VFFbMM5c2fmNVhyt3l6iWvcxvsC3f9TonoGDB9xAETr9fg+P4kTnbExXg
uZYbuh+Plam1fncLzaxXiAvLrmA4nHt7sjRB6DAMjOEfWY7M4xfySl27zDLDBBFg
TSYhOfVP1TEkP2ML6126BW1FPdS7uBxwZd/cM/m95rLOiZrSGEqATPZrCZiB/GYa
WHH2Vy/UOOEEfbHGDEKjgl5H0oVf86g8AeRgJJ8F0t2S+08QzTQVpWiHCJDjrOAp
6YjmdmPmgo3DATWvZADBx97Wc+j9FT5YENlh3L9GtvTMp96OUhv3jIQL96O1U+Ck
FZ2Q0RMJh9iT9qJpSzIcAfON04WZhYTN+D5EI76RyXcv9lA/1/u0lSbv/Zn304cG
QQXhrYrsZSpHXL0vD+NTA39UnERKNpFICcNADpExFwGZloJaGKBTR0p3bLLP8GeA
e8t0PtrOJPOp0kQAc6BxO8QQKXdrmSjE5RoygC7czzvAj3cyn8JoOz4XquQ2J9Fs
4x+NwDNxkMnJzT/9S8VYe5+t+P2pPAKb0/wakmDORSVCb83Jq7s=
=w1Yu
-----END PGP SIGNATURE-----

--d6d1KVhp94hk3Jrm--
