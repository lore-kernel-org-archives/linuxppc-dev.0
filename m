Return-Path: <SRS0=OgF1=RR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BBFC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 03:53:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E4D2085A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 03:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="lOmGdj/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0E4D2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44KZZR32yBzDqKP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2019 14:53:51 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44KZXg2CqczDq67
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2019 14:52:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="lOmGdj/v"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44KZXg0vZ2z9s4Y; Thu, 14 Mar 2019 14:52:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552535539;
 bh=hM7O1q7KFrc9lGQGaqRbo8O1YEuG2oAoCf7j6mHEuA4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lOmGdj/v7i0OVWnVKA/XUpqfmeSglgNSrrYlFlI5MH5mZY6MNIthc+tqApOg5xD3h
 eZSwkRzIAzANFUdXw5gEDqDqrpi3odvBRJnVV7y0wX3nIeESswretZJ4QCLeUBmNSH
 Jq5FsqLcRWmjCQW/Mu+962Y0TZLd7h+fvJUC5hR4=
Date: Thu, 14 Mar 2019 14:29:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 06/16] KVM: PPC: Book3S HV: XIVE: add controls for the
 EQ configuration
Message-ID: <20190314032927.GP8211@umbus.fritz.box>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-7-clg@kaod.org>
 <20190225023955.GJ7668@umbus.fritz.box>
 <9e732140-b2c0-dfb7-d753-ba0ec7f3b930@kaod.org>
 <20190313040327.GK9881@umbus.fritz.box>
 <badcd1dc-2eef-590e-b362-0d3dfdf52d34@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yEbVe0JFHWhrOjGA"
Content-Disposition: inline
In-Reply-To: <badcd1dc-2eef-590e-b362-0d3dfdf52d34@kaod.org>
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


--yEbVe0JFHWhrOjGA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2019 at 09:46:08AM +0100, C=E9dric Le Goater wrote:
> On 3/13/19 5:03 AM, David Gibson wrote:
> > On Tue, Mar 12, 2019 at 06:00:38PM +0100, C=E9dric Le Goater wrote:
> >> On 2/25/19 3:39 AM, David Gibson wrote:
> >>> On Fri, Feb 22, 2019 at 12:28:30PM +0100, C=E9dric Le Goater wrote:
> >>>> These controls will be used by the H_INT_SET_QUEUE_CONFIG and
> >>>> H_INT_GET_QUEUE_CONFIG hcalls from QEMU. They will also be used to
> >>>> restore the configuration of the XIVE EQs in the KVM device and to
> >>>> capture the internal runtime state of the EQs. Both 'get' and 'set'
> >>>> rely on an OPAL call to access from the XIVE interrupt controller the
> >>>> EQ toggle bit and EQ index which are updated by the HW when event
> >>>> notifications are enqueued in the EQ.
> >>>>
> >>>> The value of the guest physical address of the event queue is saved =
in
> >>>> the XIVE internal xive_q structure for later use. That is when
> >>>> migration needs to mark the EQ pages dirty to capture a consistent
> >>>> memory state of the VM.
> >>>>
> >>>> To be noted that H_INT_SET_QUEUE_CONFIG does not require the extra
> >>>> OPAL call setting the EQ toggle bit and EQ index to configure the EQ,
> >>>> but restoring the EQ state will.
> >>
> >> I think we need to add some kind of flags to differentiate the hcall
> >> H_INT_SET_QUEUE_CONFIG from the restore of the EQ. The hcall does
> >> not need OPAL support call and this could help in the code
> >> transition.
> >=20
> > Hrm.  What's the actual difference in the semantics between the two
> > cases. =20
>=20
> None.=20
>=20
> But we don't need to set the EQ state in the case of the HCALL and it's=
=20
> (very) practical to run guests with XIVE enabled without the OPAL support=
=2E=20
> The latter is the main reason clearly.
>=20
> Thinking of it, I could test the EQ toggle bit and index passed to KVM=20
> and skip the OPAL call which restores the EQ state if they are zero.=20
> This is because I know that the OPAL call configuring the EQ resets them.=
=20
>=20
> That will do. No need for a flag.

That's a much better idea.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yEbVe0JFHWhrOjGA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyJypcACgkQbDjKyiDZ
s5KCxw//WNmsL5h8dPdmmkHFiUwiEnh4vShQ/u8lpyi/gEx6ML50BxS58Qxgnd3H
uyeQK009V3kM9rNr5gjg0rt3IaRBFiuUgh7avt+bvb9DJj9wwRdJJ2pyUgZVwBT2
o8T62qJQ5nAHAlCZRGbHtxNcorglkZbdiewWG94gc5CHTvLT+bokFzffP0HppszS
6xKewtxTeQRmsnpMnKX6l45CDvFgdJlcsLOsd5jpao+43hqqR9A9hMbkDS3CLurn
fkyrrGNheCuE8o/4wRW+Lino9hI2jzxEpfYt3GAWSTGwbP8FQKuwj4vyzJ3s14jR
uAS6O48R6xuSAXfwbIpEcEDhyerhyC5EspIscqFb2B9YGw0vdqjbnrJjDkN6y+7S
IcnPx+VwO7GR2YMMJUAdHs4LI6E1GIwIEYCD5l0bePjf632dsG1p3cehdUvDIoj1
j2o/ts8NHeCGxMQ26Ro09LpL/Fzi/k8zmS8hwF6ph4MJiPTbzMHeWx6lUcLlYFMu
gu+yAVs7rD3z8eJXcKdKsPYiK8W/xV0jeWeqPGlo7DeXmV/S6ZJ+stQ9FszqVlWS
Emc31bRcZ/djf1RQqfmPYHMIVBhv1GS3fYQyrKjOEq4djgLJDDqUlFGlznuNmgSC
wyzZR90VzjzRfMSYkGI4vEsmhwJCXkClMgnSsqHHCR8Ra+ovvoQ=
=+zOv
-----END PGP SIGNATURE-----

--yEbVe0JFHWhrOjGA--
