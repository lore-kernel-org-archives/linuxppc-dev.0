Return-Path: <SRS0=TFg7=Q7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50355C43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Feb 2019 22:49:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C492084D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Feb 2019 22:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="g9mwJwMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C492084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4470cd6xrFzDqS1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 09:49:05 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4470Zs0mNTzDqKK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 09:47:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="g9mwJwMQ"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 4470Zr5bH8z9s9y;
 Mon, 25 Feb 2019 09:47:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1551048452;
 bh=jipf+2Op/SRk48bH6yU7znHexb6tu97H3EnSph3rg2k=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=g9mwJwMQ88r0F9YZgj95QiHcVf91QyanWjjl1stmIWUqrSe6aCyNz18LB0PRx9wcc
 IfBlkWIaD48RoK9ZW2aB/Lpi8Ev6lp08IkSnVeQm24PkJueHT+U6oOj7cmjJelJFV9
 xZWQ6riXVM0ear3y7XIiJ13G1kQf2e3TtixByIUz7p35BRb9Iew/W34IlwpHmTte6a
 qj9R8+1aCEUMj0PxjbnJYgnfh8ucPgQmzhE6YSBBmcoddrZ2/Q2h9ewcEq11gZ2/Lz
 NMiWJSCPA5x7duEluWs+9WeF7DWuOLWH6xF8TC3NwKlmaxym/h7AVt875Y1GYbQ9ve
 ELUJdgwVkSBVw==
Date: Mon, 25 Feb 2019 09:47:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: linux-next: Signed-off-by missing for commit in the powerpc tree
Message-ID: <20190225094659.741bf42f@canb.auug.org.au>
In-Reply-To: <8736odl846.fsf@concordia.ellerman.id.au>
References: <20190224010511.74f25272@canb.auug.org.au>
 <8736odl846.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/==0L43=u6mND1Rkb1uxqnn9"; protocol="application/pgp-signature"
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/==0L43=u6mND1Rkb1uxqnn9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Sun, 24 Feb 2019 22:48:57 +1100 Michael Ellerman <mpe@ellerman.id.au> wr=
ote:
>
> But do they need SOBs?

I think so, since they modify the code ..

> The DCO says:
>=20
> By making a contribution to this project, I certify that:
>=20
>         (a) The contribution was created in whole or in part by me and I
>             have the right to submit it under the open source license
>             indicated in the file; or
>=20
>         (b) The contribution is based upon previous work that, to the best
>             of my knowledge, is covered under an appropriate open source
>             license and I have the right under that license to submit that
>             work with modifications, whether created in whole or in part
>             by me, under the same open source license (unless I am
>             permitted to submit under a different license), as indicated
>             in the file; or
>=20
>         (c) The contribution was provided directly to me by some other
>             person who certified (a), (b) or (c) and I have not modified
>             it.
>=20
>         (d) I understand and agree that this project and the contribution
>             are public and that a record of the contribution (including a=
ll
>             personal information I submit with it, including my sign-off)=
 is
>             maintained indefinitely and may be redistributed consistent w=
ith
>             this project or the open source license(s) involved.
>=20
>=20
> Only d) really applies to a revert, and as the maintainer I feel like d)
> is kind of implied.

I read this as (a || b || c) && d.  And if there is no SOB, then none
of the above is certified.

> Anyway I'll try and remember to do it in future if that's The Rule ;)

Its just as effective as the rest of our rules ... i.e. a strong
suggestion :-)

Thanks
--=20
Cheers,
Stephen Rothwell

--Sig_/==0L43=u6mND1Rkb1uxqnn9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlxzHv0ACgkQAVBC80lX
0Gz4KAf/YaVU9s53s+KgK+SNwYdSYd42mRJmfXVyrrUb0M6tubHkFyFsMmrI4apo
lSaMmDwtrlOMf0Q8zm34TLUpyGtN0qGlhIlWgQJJSycLHZdh8BTkmzpyM5F9Byoa
Yjiqx5eHBl1Bzd4K6BlJp0LdQG1FIuJcYKPD9iJ/mmqYhOLpEjs5KGiVmwQeML7g
nzdG+lnBTlxdV/ja2VYqxtNK7Elb6PP6RpBSgqvWbPM1bIn95Ajk3HBJ93W9qvVK
ykYz515cx8NvKj+OeKdnRX1uUDrjdU+vO06xFNL15/2ta5isXrdfbNiejglSChYh
ZjfEz58DI2UdEoFIs8pqO7nCb9m3GA==
=Vw1t
-----END PGP SIGNATURE-----

--Sig_/==0L43=u6mND1Rkb1uxqnn9--
