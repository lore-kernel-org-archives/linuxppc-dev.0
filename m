Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C6DC282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 05:44:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBDA32081B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 05:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="MysyApm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBDA32081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ttnK5NZGzDqMH
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 16:44:37 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ttfM3KnJzDqKZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 16:38:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="MysyApm/"; dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1007)
 id 43ttfM1Kqsz9sMM; Tue,  5 Feb 2019 16:38:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1549345115;
 bh=tRJ4W+pocH8UYPA9FrXTgJwvR1lfbqse6K/bIprSmbY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MysyApm/yDPuP4msJsbA9ROpso6xTvEiakRFq2jHhBX46sNasR6pE+GsvqrGAh3vt
 oG8daEHXEZnDasTMV+Ixan/cF4wxNeQKeZkMYdYsrcOPddWp6fiF3yXCwEvyZhVv3D
 CXMGCRazD5q0bOdA8fGgwKRABabuFi3uR116WeqQ=
Date: Tue, 5 Feb 2019 16:30:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 14/19] KVM: PPC: Book3S HV: add a control to make the
 XIVE EQ pages dirty
Message-ID: <20190205053058.GF22661@umbus.fritz.box>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-15-clg@kaod.org>
 <20190204051833.GG1927@umbus.fritz.box>
 <c5c3f60a-dfb0-4641-901d-a41f412d80fc@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
Content-Disposition: inline
In-Reply-To: <c5c3f60a-dfb0-4641-901d-a41f412d80fc@kaod.org>
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


--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 04, 2019 at 04:46:00PM +0100, C=E9dric Le Goater wrote:
> On 2/4/19 6:18 AM, David Gibson wrote:
> > On Mon, Jan 07, 2019 at 07:43:26PM +0100, C=E9dric Le Goater wrote:
> >> When the VM is stopped in a migration sequence, the sources are masked
> >> and the XIVE IC is synced to stabilize the EQs. When done, the KVM
> >> ioctl KVM_DEV_XIVE_SAVE_EQ_PAGES is called to mark dirty the EQ pages.
> >>
> >> The migration can then transfer the remaining dirty pages to the
> >> destination and start collecting the state of the devices.
> >=20
> > Is there a reason to make this a separate step from the SYNC
> > operation?
>=20
> Hmm, apart from letting QEMU orchestrate the migration step by step, no.
>=20
> We could merge the SYNC and the SAVE_EQ_PAGES in a single KVM operation.=
=20
> I think that should be fine.

I think that makes sense.  SYNC is supposed to complete delivery of
any in-flight interrupts, and to me writing to the queue page and
marking it dirty as a result is a logical part of that.

> However, it does not make sense to call this operation without the VM=20
> being stopped. I wonder how this can checked from KVM. May be we
> can't.

I don't think it matters.  qemu is allowed to shoot itself in the
foot.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxZH5IACgkQbDjKyiDZ
s5JS9BAA30gFIgvUZHxJzKwRH1asbUzKh0BEJ5jDYlBlpoWoOsq3zpPGw8cTr9pd
qtNHy2aaMnWGcfhm2LZYbgmW7F3zCgiKXLLoFOSiCQVKNLRp7s3H1tlipA1F/Pgc
4QPD1AHZykA9K1bKjLNXqqCLCJNLWY5HLeCbxSv8noojwADxk8ZZdTv3SJsUw0K/
MygO8hgsDmM7EDj5ud3iFmd9P9nf4q8+z7Z5RfpmkYwyvQGe5t7/3AhOmQR2QAct
MKXgwl9goJIgFOoCJXj24cx+jkQXKY3GyVXKclIm3bpO9JJPjxM32LnRcYe88zB6
AtQA9o+FGF9vnhrwsWp4aHarPfdj/0c9A+u3xnDtf7PcoFnd9s9zbQSWNXKrB/ti
2O2iKBGf5I7eMaNyBEUVk7wxe3BQPRFgF57I8akIqdyv5OZOevLTZTgUwGqz+ndb
zTdM2FRLDZYeSrNBVkEs0QgFffn4RD435DNYedpofs/PD0sLvLi+om+NWi95u02H
aSUHGcCimPYp5x6V+OZS8+zxcC8S9p/3St6YczJdlOiqUWFHrO0Dya1WvAZw2hdk
5LLrwVOqsU3g0Riz96DhdVizQWLzUrOU5NUozBPvc/c8/+SYzvN8xzPVmYijMHeI
XrNqY2XdYvUrtVN6So6mQt40//EBZRxYGEUU+BX+ohiOA+7/sJs=
=aJ8z
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--
