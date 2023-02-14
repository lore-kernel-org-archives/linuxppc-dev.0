Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBE2C05027
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Feb 2023 06:13:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PG9rc3gHPz3c63
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Feb 2023 17:13:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.a=rsa-sha256 header.s=201702 header.b=tH6/Erb/;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PG9qb5Bzmz3bgn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2023 17:12:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.a=rsa-sha256 header.s=201702 header.b=tH6/Erb/;
	dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4PG9qX5S9Kz4x7w;
	Tue, 14 Feb 2023 17:12:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1676355176;
	bh=wWjOzCsGqomhwugnRB9+/uFRB4wXCtiwDrBMDMUTWT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tH6/Erb/bv3eoP8xKOwBu8vTjaMKlxhtQ3Ao/Vzy2ORviLcPlDuiEiGZF9EuxJkYV
	 VMqSsGNcZMPggr86yxNTJ0f1zv4yeXU5AzAlh6JTqv760oQD0YOzuqEnyOZuXw9hlk
	 0BpmccLJFlpFOmBaHpwQmD+xZ7ONz70K8S5QKaet7KKmZPXJloyyIZjuKyAjYsk9aH
	 O+sMncM+akclNXaRux/GLwmWlkMfxdxsUMhEW4B62dcz2uYK80jNoP2tNOLD9KJAd2
	 FiGoT1jHfqerv8WtRWyssTvANOUNA2gSoMxKHACS8YOsFD1LCAawAfUDZNcm/fHbLa
	 nj5pNVpt3uUYA==
Date: Tue, 14 Feb 2023 17:12:56 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Nathan Lynch <nathanl@linux.ibm.com>
Subject: Re: linux-next: qemu boot log difference today
Message-ID: <20230214171256.556defbb@canb.auug.org.au>
In-Reply-To: <878rh0aknk.fsf@linux.ibm.com>
References: <20230214143150.7c7fdd05@canb.auug.org.au>
	<878rh0aknk.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0YtnMci.O9bXV5csRpD7yI6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/0YtnMci.O9bXV5csRpD7yI6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Nathan,

On Mon, 13 Feb 2023 23:19:43 -0600 Nathan Lynch <nathanl@linux.ibm.com> wro=
te:
>
> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> >
> > Today's qemu boot log shows 256k extra in reserved memory:
> >
> > - Memory: 2046080K/2097152K available (14720K kernel code, 2944K rwdata=
, 18048K rodata, 5184K init, 1431K bss, 51072K reserved, 0K cma-reserved)
> > + Memory: 2045824K/2097152K available (14720K kernel code, 2944K rwdata=
, 18048K rodata, 5184K init, 1439K bss, 51328K reserved, 0K cma-reserved)
> >
> > I don't know what has caused this. =20
>=20
> Assuming it's pseries, it's the RTAS work area allocator reserving the
> memory.
>=20
> 43033bc62d34 powerpc/pseries: add RTAS work area allocator

Yeah, pseries_le_defconfig.  Thanks, I will stop worrying about it.

--=20
Cheers,
Stephen Rothwell

--Sig_/0YtnMci.O9bXV5csRpD7yI6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPrJmgACgkQAVBC80lX
0GxxFQf6A7pXQn80RvrHINP1N5fdDkJtGfgLJZcQodnwkrUFZkPBpFxVw83PAyWj
DDSIHLRd7DCVs32qs2l2wQvy43o/3G/tMBlUmKxjdBcQGEdj2N10qICfLxHhZGkt
7r/YiSDC1AUVV78099tuVJuCrS+LM112YWEsWizVDYT/zUdOK8SEFyF2GGxm6dtl
eRYqqSnrdzaUACY+ACJlNX8qubYHwayX579/sr8+5iG0mxlSY7qonZ3FGA+ED6Kl
Y1YbYC3Bgt3aJe0wJC+MxvOyfcFQEow6uC2RYkMVZ3xS9JKechRAUqD5YoDSe4WW
HLyjQuTGGcti3Wpm0DKHeL/5v7b5RQ==
=UyxE
-----END PGP SIGNATURE-----

--Sig_/0YtnMci.O9bXV5csRpD7yI6--
