Return-Path: <SRS0=N2MO=QO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2566C169C4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 03:03:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA37217F9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 03:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="o0L39Heb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA37217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43w3654C8LzDqP3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Feb 2019 14:03:09 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43w30M5HY1zDqMT
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2019 13:58:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="o0L39Heb"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43w30M3Drpz9s6w; Thu,  7 Feb 2019 13:58:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549508291;
 bh=kWpV1pDmVi7sHK3czwf5RBFRiOpsX/SwSvaO8I0WrgE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o0L39HebRZItmwG1svp2q1NqUM/A3ZbCNZLx4jyVkQrjjgpIxcghpa4VsCTa/bmWb
 48LjEzl15VWmCRGuBDZxEjCQCCszsQ5DI8+pOwVy/IJuctrvIUBTxpvrs75x8pfi8p
 QLzriRdpeWg9JIt6Xj8HG2BOOFOJJ0UZ0XIEhTVk=
Date: Thu, 7 Feb 2019 13:51:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 00/19] KVM: PPC: Book3S HV: add XIVE native exploitation
 mode
Message-ID: <20190207025111.GB22661@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190122044654.GA15124@blackberry>
 <2f9b4420-ef90-20b8-d31b-dc547a6aa6b4@kaod.org>
 <a420acfb9f375b27bc1203fbb15312a61eb0c34d.camel@kernel.crashing.org>
 <06b7c4d2-72ba-ca4f-aded-789280798136@kaod.org>
 <20190204053610.GK1927@umbus.fritz.box>
 <dc59257b-c780-7b81-f3d8-46269b834c2d@kaod.org>
 <20190205221315.GB29038@blackberry>
 <20190206011800.GN22661@umbus.fritz.box>
 <bf3725b6-9881-74a0-ec4f-43ac409cb496@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DaTEgnRu5pEC8TLg"
Content-Disposition: inline
In-Reply-To: <bf3725b6-9881-74a0-ec4f-43ac409cb496@kaod.org>
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


--DaTEgnRu5pEC8TLg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 08:35:24AM +0100, C=E9dric Le Goater wrote:
> On 2/6/19 2:18 AM, David Gibson wrote:
> > On Wed, Feb 06, 2019 at 09:13:15AM +1100, Paul Mackerras wrote:
> >> On Tue, Feb 05, 2019 at 12:31:28PM +0100, C=E9dric Le Goater wrote:
> >>>>>> As for nesting, I suggest for the foreseeable future we stick to X=
ICS
> >>>>>> emulation in nested guests.
> >>>>>
> >>>>> ok. so no kernel_irqchip at all. hmm.=20
> >>>
> >>> I was confused with what Paul calls 'XICS emulation'. It's not the QE=
MU
> >>> XICS emulated device but the XICS-over-XIVE KVM device, the KVM XICS=
=20
> >>> device KVM uses when under a P9 processor.=20
> >>
> >> Actually there are two separate implementations of XICS emulation in
> >> KVM.  The first (older) one is almost entirely a software emulation
> >> but does have some cases where it accesses an underlying XICS device
> >> in order to make some things faster (IPIs and pass-through of a device
> >> interrupt to a guest).  The other, newer one is the XICS-on-XIVE
> >> emulation that Ben wrote, which uses the XIVE hardware pretty heavily.
> >> My patch was about making the the older code work when there is no
> >> XICS available to the host.
> >=20
> > Ah, right.  To clarify my earlier statements in light of this:
> >=20
> >  * We definitely want some sort of kernel-XICS available in a nested
> >    guest.  AIUI, this is now accomplished, so, Yay!
> >=20
> >  * Implementing the L2 XICS in terms of L1's PAPR-XIVE would be a
> >    bonus, but it's a much lower priority.
>=20
> Yes. In this case, the L1 KVM-HV should not advertise KVM_CAP_PPC_IRQ_XIVE
> to QEMU which will restrict CAS to the XICS only interrupt mode.

Uh... no... we shouldn't change what's available to the guest based on
host configuration only.  We should just stop advertising the CAP
saying that *KVM implemented* is available so that qemu will fall back
to userspace XIVE emulation.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DaTEgnRu5pEC8TLg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxbnR8ACgkQbDjKyiDZ
s5IuzBAAyBpvYb+cVNWgnlGNW2eEtdNPixG1B2SfMPkxhCbNceP5VUWFecFL8IVV
g+40FNr6WExE2ap6uMoQfCFQj5oKqWWpEtxUzqWlJEaadVqeQaes5h9teXzDIEcx
icnNf9XlveqvAoTND9n9d8HZFXtiXMQXhGaiskUUHrZ264GD3nriq0YnuSZ7hD6j
YaRCPD/WFg9GlD5dP8QXwKAp+wQMFy852lmVALenfJhvSF+qSR1DU4aFWMXsjzsL
7xa8r36ODZ+yX0FOVJAKqCsnpeXMDDjScG9dnqF9dynH7RvscyCsp66Ga3mhtlP7
Ys8YKBHgSoOhqWevTaUjkmGuGOQ4dSLCvuZP70Xwa95yNzlu7CkloTNXyP8TVhsO
JlGSWYcwH0+qtICb+LryzInZEoG8w1Man732cl5tHaXxD/vjqzkr5mIuOT6okbpe
237FQNETfdlcpVF8/hpNl5ldcyVTd5OlM739KtmSdMLWa9JuE48jHW2+307b1vFh
jKZ7PnyoZOTyboDIAP4ACrvJpTGhBQtMODfqZaJbIcc84yL3Uy1kApskhRR/GBxi
NbfScnNbhIjAl2zPgm4AiJWLNM6JcpeoHtPebNu9WQkhdsmMwTB/GNEM3WAoRRLN
isg/zVGmQTPdh0FW4xpzWHeE72peUDlfBS/jfF+YH6/Tb6ujA40=
=H9op
-----END PGP SIGNATURE-----

--DaTEgnRu5pEC8TLg--
