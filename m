Return-Path: <SRS0=/Qvz=43=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA33C10F27
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2020 11:25:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7502253D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2020 11:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7502253D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48cCSN4YKRzDqNp
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2020 22:25:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=the-dreams.de (client-ip=88.99.104.3; helo=pokefinder.org;
 envelope-from=wsa@the-dreams.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=the-dreams.de
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 48cCP46Mz0zDqNH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2020 22:22:32 +1100 (AEDT)
Received: from localhost (p54B33196.dip0.t-ipconnect.de [84.179.49.150])
 by pokefinder.org (Postfix) with ESMTPSA id 190462C1EB6;
 Tue, 10 Mar 2020 12:22:31 +0100 (CET)
Date: Tue, 10 Mar 2020 12:22:30 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] macintosh: windfarm: fix MODINFO regression
Message-ID: <20200310112230.GU1987@ninjato>
References: <20200303125046.5157-1-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DFFMAMYvrfM3lt66"
Content-Disposition: inline
In-Reply-To: <20200303125046.5157-1-wsa@the-dreams.de>
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
Cc: Erhard Furtner <erhard_f@mailbox.org>, Mathieu Malaterre <malat@debian.org>,
 debian-powerpc@lists.debian.org, linux-i2c@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--DFFMAMYvrfM3lt66
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2020 at 01:50:46PM +0100, Wolfram Sang wrote:
> Commit af503716ac14 made sure OF devices get an OF style modalias with
> I2C events. It assumed all in-tree users were converted, yet it missed
> some Macintosh drivers.
>=20
> Add an OF module device table for all windfarm drivers to make them
> automatically load again.
>=20
> Fixes: af503716ac14 ("i2c: core: report OF style module alias for devices=
 registered via OF")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D199471
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Tested-by: Erhard Furtner <erhard_f@mailbox.org>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Thanks, Michael! Applied to for-current.


--DFFMAMYvrfM3lt66
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5neHIACgkQFA3kzBSg
KbZ42Q//dNfEfjPawt+cDqqGh5+CwK//7eIn09Pr4z4UdJZoLMzuatBhzhuS4bo3
P0j7vBn05v8p32Vc1uUl0bMlfMlWLE3sP56yIv3R8zdx+fRrO/48cA+TiEiX/B6S
mbcQ5/0V7ejXRvB74L73KtiT+Crzh5+Yy7B6BAREzwn4U37fjIxF55YAB2pGAedb
UHrUkH6eVk6PGFMVmJyWU0hquI7sVyRUHE/UKnHyTK+vHMt+Ymt2zSF8cov7HlG0
kIR4xp6zqzfVKbksEVJpgvaoe9q5N2YEc5Y/ylh04EwauCEjGi0PjYemFUChmE4i
VrifBEmKYR1jPA2vjehBeKkaHrshsHi78hRC4PURC2YPL2fz8V+ETpXlOoP+8Zqh
83K4Go50LMWC9Vq039hdWQ+tgGu1228le33uvuAwNh5uwrDHGlMZ51ttYnr2d3gj
F30mIp8qfxaWsdFCuRhsXRKUWotY5+zQJiyD3KbS67VtKuxkyU+k5OXx4/wT7eiI
ZrRNcO+6skAfeBKHaCli4bJ1/yUofjJUGZMH1qTGBxK7FHDO2TfgkBdJUeyREeWx
HDrV7E1pjLl48M7qPRl4kPJ5eVyFGDbm8yRQBhc4DbFcKNpwKB1czrNqXbkMg8Bj
btJRrmxxBTWElCTO/ETcEN4WWHaFp8B4HKsV/By6UMpGUNLw1RY=
=PQWK
-----END PGP SIGNATURE-----

--DFFMAMYvrfM3lt66--
