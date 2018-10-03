Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4608EC00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 05:25:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C66E206B2
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 05:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PC+z97p2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C66E206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q4Gf40x1zF325
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 15:25:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="PC+z97p2";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q43m40tqzF36w
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 15:15:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gibson.dropbear.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au
 header.b="PC+z97p2"; dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42Q43m2wvYz9sBh; Wed,  3 Oct 2018 15:15:48 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1007)
 id 42Q43m2NQGz9s55; Wed,  3 Oct 2018 15:15:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1538543748;
 bh=UPsSkMaJ5mP/XBz+sKeHFLyZ8gpaMhxI0Q/tOAXxwy0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=PC+z97p2NJblBTyWj1vZCE8mdYQCwY5y2KdJZ5ECBvHrXSaZd/abzrGmygHBy8EMp
 AosSAnC2k1GLZjUlKt7l7nXLdZuPzwGTy3omEs0NePhuUrboUBmxCbH0ztEF+2+LQZ
 bZZeGYiLZoUNddB91UfpwY4LIRbtcsf8/CJESm0w=
Date: Wed, 3 Oct 2018 15:12:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v3 18/33] KVM: PPC: Book3S HV: Nested guest entry via
 hypercall
Message-ID: <20181003051210.GN1886@umbus.fritz.box>
References: <1538479892-14835-1-git-send-email-paulus@ozlabs.org>
 <1538479892-14835-19-git-send-email-paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FX+Db2fp7WJhXKrW"
Content-Disposition: inline
In-Reply-To: <1538479892-14835-19-git-send-email-paulus@ozlabs.org>
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
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--FX+Db2fp7WJhXKrW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 02, 2018 at 09:31:17PM +1000, Paul Mackerras wrote:
> This adds a new hypercall, H_ENTER_NESTED, which is used by a nested
> hypervisor to enter one of its nested guests.  The hypercall supplies
> register values in two structs.  Those values are copied by the level 0
> (L0) hypervisor (the one which is running in hypervisor mode) into the
> vcpu struct of the L1 guest, and then the guest is run until an
> interrupt or error occurs which needs to be reported to L1 via the
> hypercall return value.
>=20
> Currently this assumes that the L0 and L1 hypervisors are the same
> endianness, and the structs passed as arguments are in native
> endianness.  If they are of different endianness, the version number
> check will fail and the hcall will be rejected.
>=20
> Nested hypervisors do not support indep_threads_mode=3DN, so this adds
> code to print a warning message if the administrator has set
> indep_threads_mode=3DN, and treat it as Y.
>=20
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FX+Db2fp7WJhXKrW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlu0T6oACgkQbDjKyiDZ
s5KWCxAAg3nBsdyPbcGuXFYcpIk1DERAKEhqEqccj2qL8VHfbSBN9RibHiqgip5b
759Iat6RunL7HtmoOcA0Yi3rp2P/oaIffPgKouzWoVvjEG9qT4ofyMFVSB6tmPnj
S3j1NjjEp+cGAZK5Jp6ZJypy0oiMgz+lHFHkDvXBPuYeG0YLucikY56J1cRpAZkp
5JFLoOcttFproii9m3Y13hAkazUzYF/1v76f4LzghyTiLX/vjHpnfr5qfG8LIqTa
gr26rG8SW/HEbkrigwnHB00tjLgfWVHuM/8lxGiGaCrdEbN3uXHmiP+2u7ukoPLW
HB8i7Ro6WtZfV9gBdvvO1PxX0B9RTwRaDH/uKnU2tnJh10TRkYLrHewQMVWqhK92
MPbQW3Mx2nBj3Ep7aqaaViR4eMghMyOPG3jX7AbjSE5dMtmjZ61/RhAfci7DFAsf
cg5dIiHhWCRDzq9LfKAbMJZR1PvZbaGcuu5OWOalWoPAGJK8MabNLt9y4BADIIDh
19BONd90HDXJ1ACOgaMgHTjn+jICa9yuGo3Br1y7jTST62QQAf8FYHLIF3ir4pVv
/cZVI3fJALWcJ8emcReHdg7XWU8NePXohSHsLW3qA26ZqyBGO0pru0wmkw0B791I
L+eEu3j9mjsytoCKAdMxdIR/YV9uMYsqH09DMr4QO5dMrXgb9N8=
=Ni9Z
-----END PGP SIGNATURE-----

--FX+Db2fp7WJhXKrW--
