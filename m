Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DF8C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 03:13:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B3F214C6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 03:13:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B3F214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Jjl53gkSzDqYn
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 14:13:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmx.net
 (client-ip=212.227.17.22; helo=mout.gmx.net;
 envelope-from=j.neuschaefer@gmx.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.net
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Jjhw0S9ZzDqFK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Dec 2018 14:11:11 +1100 (AEDT)
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LufbI-1hYiqS0Vgu-00zqfU; Tue, 18
 Dec 2018 04:05:40 +0100
Date: Tue, 18 Dec 2018 04:05:38 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v1 03/13] powerpc/mm/32s: rework mmu_mapin_ram()
Message-ID: <20181218030538.GA24278@latitude>
References: <cover.1543517818.git.christophe.leroy@c-s.fr>
 <8835330baa77d88e0267b0b1215b78c991e6d17a.1543517818.git.christophe.leroy@c-s.fr>
 <20181203215558.GK15324@latitude>
 <84624899-bbda-9f08-2527-151fddbd1b01@c-s.fr>
 <a253e9f8-1e0a-1596-e0ea-54261ac62212@c-s.fr>
 <20181217012837.GT15324@latitude>
 <18ba3a7c-ebfa-66aa-e231-b56985d0e89a@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
In-Reply-To: <18ba3a7c-ebfa-66aa-e231-b56985d0e89a@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:WipPLp+OgFYtVGKKVsk29qrSTLpvF4f2h992eqjU4Q+1C77WkXm
 WYdhbElKUKEc2wxoBknxRfs8roAkpqxCxEX+5ciD9qdPwAFFxaGpfvSM437D/5vCQropigo
 tyz0Pgvjh7mJSzraleX/BMOoxx5Te1SeEBHXDlpNdXmheIx7SncbQNwPwnj0OhIi4iVyd3E
 m/DbM9+tG0ordhQPrh7qw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CXXNh7tsgdg=:YAiEUcM//K1tnqlWe7xtUg
 Yu4DzKZjdlsrhW38fH6DUhMHFklbXsgrU2J7sQIskSMvaWnHGw7ucrDK5N3go8j70AZa5VVUh
 7Xsp+/N+xrhJ1XLFyO1k093uN+H0zsh5ZAoNoNfWzmOSbigPkgIfBG2WH8VSqlLtzTZtlSCuq
 rzQP8/+dUNNQuOSgrJyCqhm+t0NBmxjlBqpWX2JMFRwQee0iQ9SnzvIHSMN4EBLfgPvHwZHn2
 MgNFIGgZyZOxbtJF3t8XSeGK4GCD1ekQsvvcjvgqPeVw0W74BBIlwwt1CvgQ2qbvpia8lX08G
 LNN/6YEXwWVNSjqqO0DHXiZxWeuhILOu23bcaKTgIQMKoledFmsgd2aePLDrkEn2g1e7ywWlI
 nMxc3teK5xMexApD6oVjvn9fSejk7mRP1xomNsXSTich5hUnSpuAhbAxD62ben+E3zKp8CaB1
 aKsLdx56neMzm3SHJLxU+r5qnhue2+Av0DbetqhRUSQWIVJSXiQ1TtZ+5bvJsn+ulQvlM9LEu
 hP2o/jyNhjj2rLAHCKEFl/swp6pP2qT855v2XQl/NvmideD1gg81OhAzj0fH3B1E95qo5DwIT
 x3i5Mss4w5UIG97naIR5CwoeUuM1sqXoRonDjpNjXrR9U85tk9ONBu338VJl3Vd9LU4ORoWNV
 KegHszlxCGGAy6WJbDCwaLckgGHXtSzX2cb2h7ND2yAixuSPTowz79QRRlEQ7RepMyYiST/D+
 D+jGzj+n7c21nCYGCE1za65kstjBvltAWrV8BCBl55aMB41sx6KfE6e4u2hcNrOiaRnXYhcLi
 kBEL94kUNU5g6BNlSpXUm/syypfsUKXT79WFBbtBwMHNdjrx/Ux+uChKAeCW1oU2nIzKlCD/G
 zmT6jEdLR4+/y3Km0gfPmXOtnIYNA2fAwLA+/vEENq/A3Zg7GWyP13BSOj/1Nn
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:29:18AM +0100, Christophe Leroy wrote:
> > With patches 1-3:
> > [    0.000000] setbat(0, c0000000, 00000000, 01000000, 311)
> > [    0.000000] setbat(2, c1000000, 01000000, 00800000, 311)
> > [    0.000000] setbat(4, d0000000, 10000000, 02000000, 791)
>=20
> What we see is that BAT0 is not used in the origin. I have always wondered
> the reason, maybe there is something odd behind and BAT0 shall no ne used.
>=20
> Could you try and modify find_free_bat() so that it starts at b =3D 1 ins=
tead
> of b =3D 0 ?

In this case, setbat is called with index 2, 3, and 4, but the Wii still
doesn't boot.

> > According to arch/powerpc/include/asm/book3s/32/hash.h,
> >   - 0x591 =3D _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_COHERENT =
| _PAGE_PRESENT
> >   - 0x311 =3D _PAGE_EXEC | _PAGE_ACCESSED | _PAGE_COHERENT | _PAGE_PRES=
ENT
> >   - 0x791 =3D _PAGE_RW | _PAGE_EXEC | _PAGE_ACCESSED | _PAGE_DIRTY | _P=
AGE_COHERENT | _PAGE_PRESENT
> >=20
>=20
> Yes, patch 1 added _PAGE_EXEC which explains this 0x200.
> Do you confirm it still works well with only patch 1 ?

Patch 1 alone boots to userspace.


Jonathan

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlwYY/kACgkQCDBEmo7z
X9srjQ//YkSw5N9QwnyF4TE1jp1QLg5wnwHtbepzoxOfaZ4xDejB9bVXT6+smkhH
aUa+AVVkkBwiBv6Ce6X4DHaYTHxu2kXoDJWt3pN28ZZ99F64oNgnHbQpy+XWJ1sJ
mc/MQlaIDsoDjwniZQjr+gp55rZkrDVdI2GaAbVeFUlGEMKYvIGmM/w+K8X/K87N
eBJHfXM1ztnfoUqeto9H/DsajuYqxXAuGqIHyw9KqRTnUYpCXztdgfOmyiR/QlRO
9O4W9xv1eS5FiOR0XwC/QBBhE2rgOp7uRbk9d6eh8ii4edrO3oe/61xFF9E+uRJf
EP2fDPUnsHY83l8UosYcillYbsZBlIbjojflXTuyqbb+HSRl8lFxl0JDsokkCrUi
dYwbB/up8ljHlfb9Zku/h4LhOpYklWYNeAMcAJZY6W2ewiQkazIw2NA5o6YFyG1N
dowfvYPUGqbfG7OtqWbhRkfTYlliLojFpifjH1jpkwm7jDOcno4eATKojfDf0qUt
40vXg/P3UCvX+T5jkr92peYwL5S5ChCWNZQ9GlvpigFCnP0BY5NKY+KqBqDpzBuM
Z7VrVZ4WIQkoebpW90gt0DAofubFJII+4pINM/HPuiBBkq/FyFyRRfEl58DO+kqT
KorhpRuKkUb+z4bI44+6A1WM6HlORjXBpDBPe/vkqLNXAbOtEkU=
=UInt
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
