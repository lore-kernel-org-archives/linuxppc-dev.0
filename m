Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA3BC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 04:35:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B92742177E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 04:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="G+1YmFfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B92742177E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44JzYR6H26zDqGB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 15:35:55 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44JzNl10FBzDqCM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 15:28:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="G+1YmFfS"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 44JzNk1rvrz9s3l; Wed, 13 Mar 2019 15:28:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1552451302;
 bh=KuLs11aMCF5UWhDuOOzmVacmod9f+FaTWz27iFlb5BM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G+1YmFfS2wQ7gOBui1WvetlPzg3TJLy7g/uaZz0G8fIJH4dPbD/Rrp77VGBrd/BGZ
 IHbL8+x96x/W+u7fOKy0niR9w3B+sRBD8iln/bUne6f2KgfJpgNXWBqcNAddxywfqn
 4G8S5MrUx4QSJeARK8+oVLdbajaYe6+OyBg6DFAQ=
Date: Wed, 13 Mar 2019 15:03:27 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 06/16] KVM: PPC: Book3S HV: XIVE: add controls for the
 EQ configuration
Message-ID: <20190313040327.GK9881@umbus.fritz.box>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-7-clg@kaod.org>
 <20190225023955.GJ7668@umbus.fritz.box>
 <9e732140-b2c0-dfb7-d753-ba0ec7f3b930@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vbzKE9fGfpHIBC6T"
Content-Disposition: inline
In-Reply-To: <9e732140-b2c0-dfb7-d753-ba0ec7f3b930@kaod.org>
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


--vbzKE9fGfpHIBC6T
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2019 at 06:00:38PM +0100, C=E9dric Le Goater wrote:
> On 2/25/19 3:39 AM, David Gibson wrote:
> > On Fri, Feb 22, 2019 at 12:28:30PM +0100, C=E9dric Le Goater wrote:
> >> These controls will be used by the H_INT_SET_QUEUE_CONFIG and
> >> H_INT_GET_QUEUE_CONFIG hcalls from QEMU. They will also be used to
> >> restore the configuration of the XIVE EQs in the KVM device and to
> >> capture the internal runtime state of the EQs. Both 'get' and 'set'
> >> rely on an OPAL call to access from the XIVE interrupt controller the
> >> EQ toggle bit and EQ index which are updated by the HW when event
> >> notifications are enqueued in the EQ.
> >>
> >> The value of the guest physical address of the event queue is saved in
> >> the XIVE internal xive_q structure for later use. That is when
> >> migration needs to mark the EQ pages dirty to capture a consistent
> >> memory state of the VM.
> >>
> >> To be noted that H_INT_SET_QUEUE_CONFIG does not require the extra
> >> OPAL call setting the EQ toggle bit and EQ index to configure the EQ,
> >> but restoring the EQ state will.
>=20
> I think we need to add some kind of flags to differentiate the hcall
> H_INT_SET_QUEUE_CONFIG from the restore of the EQ. The hcall does
> not need OPAL support call and this could help in the code
> transition.

Hrm.  What's the actual difference in the semantics between the two
cases.  The guest shouldn't have awareness of whether or not OPAL is
involved.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vbzKE9fGfpHIBC6T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyIgQ0ACgkQbDjKyiDZ
s5L/1Q//erRNSYYxNvUsPx9AaPFsPgbBotmJDa0GleY/oU8MMPZ/78dWeL/Ytkl7
yHpzUHz6yJVjwpBaZSm9amNg5d+6rJbqkpzP4PoUzRcRvo7FQzQFkUgMCib0hSxD
8nyVZq9jnbzzY0QmOlufLE4JhAel2lKKmlz9rPD8Q7A/N0CGYLDMxccQCElHPwDD
v82FC2fQxTMANpjhAMWKZ4NT1jeo4np81mBrxalObtBU4BbXmcLRfAe1lVbJPugm
6Y83JwwcJ/Jrt8kwq+CNpl8HqyyyUnibScShZr3MzXD6Iusn2pNK7KSAsUhmZbQA
UDDkWhNVPvXFscCa8h/JmOUIbknfSE4BfD2aYiVqFqUxxzzPr7saIz3znluAo+Ho
jvXE2h7kXe4yzsX9KJlLRgrTLncf73+Db4jJV8vUe/asIRmGvWV6PTNsceKWUPSa
XpGvagmAqFUKNhQbdtKfYLPqWyiGg1cgmD5qMbe1iAkGJYwnTfAz+PjHULQbWEbT
gA2X2FpM1e75GELhCVApEJDmBlLzRKotrhDbERlOZiLH9uIHmCMnVXWa6pTG6/Q+
H6ikPLSMRW9b+uioJMtNo8/n4ttojgHrJLOwuAGn2aF65WMTkOHtXc8Bcaaer1jf
fNsS18QQ14cL47jGew2v7S9Z4Ijsz4wJR2scJVt0tqg+o9g4fPg=
=LmHG
-----END PGP SIGNATURE-----

--vbzKE9fGfpHIBC6T--
