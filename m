Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76D4C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 03:56:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209CF20828
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 03:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209CF20828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SL693p9JzDqLZ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 14:56:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=decadent.org.uk
 (client-ip=88.96.1.126; helo=shadbolt.e.decadent.org.uk;
 envelope-from=ben@decadent.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=decadent.org.uk
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
 [88.96.1.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SL4P0YTNzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 14:54:45 +1100 (AEDT)
Received: from [192.168.4.242] (helo=deadeye)
 by shadbolt.decadent.org.uk with esmtps
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <ben@decadent.org.uk>)
 id 1h8Ggp-0002Jh-Uh; Mon, 25 Mar 2019 03:54:23 +0000
Received: from ben by deadeye with local (Exim 4.92)
 (envelope-from <ben@decadent.org.uk>)
 id 1h8Ggp-00030g-PY; Mon, 25 Mar 2019 03:54:23 +0000
Message-ID: <cf9154f1812e0e9a328a1e21ef13d80a46e5feb6.camel@decadent.org.uk>
Subject: Re: powerpc/mm: Only define MAX_PHYSMEM_BITS in SPARSEMEM
 configurations
From: Ben Hutchings <ben@decadent.org.uk>
To: Andreas Schwab <schwab@linux-m68k.org>
Date: Mon, 25 Mar 2019 03:54:18 +0000
In-Reply-To: <87ftrbq0qe.fsf@igel.home>
References: <20190317011756.abjylw3nzfnc6gnh@decadent.org.uk>
 <44QjSh4zGhz9sV2__48832.6491251186$1553257542$gmane$org@ozlabs.org>
 <87k1gnq5lp.fsf@igel.home>
 <eb21be1ac183dd206da3a389b426707c535c463c.camel@decadent.org.uk>
 <87ftrbq0qe.fsf@igel.home>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-AjXEkY+U0IbMKufkYmQY"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk);
 SAEximRunCond expanded to false
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
Cc: Michael Ellerman <patch-notifications@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--=-AjXEkY+U0IbMKufkYmQY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2019-03-25 at 01:03 +0100, Andreas Schwab wrote:
> On M=C3=A4r 24 2019, Ben Hutchings <ben@decadent.org.uk> wrote:
>=20
> > Presumably you have CONFIG_PPC_BOOK3S_64 enabled and
> > CONFIG_SPARSEMEM
> > disabled?  Was this configuration actually usable?
>=20
> Why not?

I assume that CONFIG_SPARSEMEM is the default for a good reason.
What I don't know is how strong that reason is (I am not a Power expert
at all).  Looking a bit further, it seems to be related to CONFIG_NUMA
in that you can enable CONFIG_FLATMEM if and only if that's disabled.=20
So I suppose the configuration you used works for non-NUMA systems.

Anyway, does the patch I sent work for you?

Ben.

--=20
Ben Hutchings
I'm not a reverse psychological virus.
Please don't copy me into your signature.



--=-AjXEkY+U0IbMKufkYmQY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlyYUOoACgkQ57/I7JWG
EQlxkQ/9EJopyyqXLAcbh2/aZ693JehVl4yXMuuZJ5kc8cmWbjoQnBWag/nkRyaI
5LdBoLun/gzgfpIAVwfY4c7CtFV4h7ebYA6hgFEfOCe94ggb/7YUDlYWLAzu7vL9
tGlqDAJ6PnQ5BQ2xK53vAtoVO5lDFD1o34QXdiRqhBonmWzRbe9pF2Qxn39733vi
mn6590alBcF9l12RS62Z7F6ZHvdm/tPUU7KzRazWWuQXZi321NArBn9IR6A5CYev
hhDoy6eGZNYd6Aa6t8E6ZgReOBF7ggZQLiswhzfTZqJWY4k+pzNdRHjsNlZLfBot
q+Ebpt5XzVR9iiPoiEWrFp3LArqPbBg4pavE3PqzDL9gDOP0JpEj2x7tbZiJcV35
Yksl3o+M45P+UnneSOe7BpZI96tKJ76bOx2W29qCY05wessd7tXPSS1KQX/wKhsm
Rgbi0EirOk33NxcUOQCLyWbZcJx9D1lCUAZGYq0VnbLgkfesI2X7bTc7NXqy0JZH
y8Eclukmbp5njeK7UOJAT3PTzfJFQTJmbdGRRXAwGYxWy8dkr58h4Imz3Moyl8M6
p5AsEj7KS+dwNVMOboidwQSaYELdtFJPrOEoV10sqLubd7cKvN1kJYIw05KGu1rl
vF1PqU8+zYr10QGYh6rm2p2LLEdxwzZCZJGaSqFHKkrLdKdStIs=
=9SR6
-----END PGP SIGNATURE-----

--=-AjXEkY+U0IbMKufkYmQY--
