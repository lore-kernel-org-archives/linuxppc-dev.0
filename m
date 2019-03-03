Return-Path: <SRS0=weZV=RG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2028DC43381
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Mar 2019 20:40:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B9F02070B
	for <linuxppc-dev@archiver.kernel.org>; Sun,  3 Mar 2019 20:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TifcXp9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B9F02070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44CFQk0dzGzDqKh
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Mar 2019 07:40:14 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44CFNw4tsQzDqFw
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Mar 2019 07:38:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=canb.auug.org.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=canb.auug.org.au header.i=@canb.auug.org.au
 header.b="TifcXp9T"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44CFNw1SFZz9s6w;
 Mon,  4 Mar 2019 07:38:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
 s=201702; t=1551645520;
 bh=0d+YISAhExSxWFF/8jItjD2KxF+92pSF797e3FpqCG0=;
 h=Date:From:To:Cc:Subject:From;
 b=TifcXp9TJT6JxAFSSEcnpdTewBUrwnjmbwL28bjezMCk4E5U2cUuki/X2QUHiq2jc
 8k/vtTIc27XpQ8o80IRwqOQNc4/+OUi9wccMyI7fdcLgausfrdx5nk4PS8a53JWeq9
 aC2uRyd6sqRF0RmMlvvHfIip/1zLHaaZ/MrqFk1WhB2gCc9XpfCcQr4hWyFC1SpYN8
 tLcq2PmK8K5DWsmjpRgKJPPJK/Ku8hjpejQfccG9SfixMqRYic5neZLYTQgD2Ufwr0
 2cG+/ZlzFffEVx6S32QgjYxRWHO6IYqvCVG/J3ljQ8iN1XwVBlbLb9snST4geurSZy
 F8W1vBouo4YXA==
Date: Mon, 4 Mar 2019 07:38:31 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: Fixes tag needs some work in the powerpc tree
Message-ID: <20190304073831.228d3bff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VQR8vZIc74a6hsBJZ4U8JoN"; protocol="application/pgp-signature"
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
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

--Sig_/VQR8vZIc74a6hsBJZ4U8JoN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  bd3524feac21 ("powerpc/64s: Fix unrelocated interrupt trampoline address =
test")

Fixes tag

  Fixes: ccd477028a ("powerpc/64s: Fix HV NMI vs HV interrupt recoverabilit=
y test")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/VQR8vZIc74a6hsBJZ4U8JoN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx8O0cACgkQAVBC80lX
0GyytAf/Z0tAAGHIvVIc8xBWFHBFgmFbZuycPMRvnV+8K8pHfN1wkGQr2KN1Nwsh
DdSR5ZVAxnn0gZJU9AXlpJCAetoDOxY/GRuoBJ3UD8UrAm7JLpoDKIaXWkaxKmpX
uxChu7WwEN1keYqDAqB6CspUrUDzS6Q0Qr1kjtsVvZ//FxfdBB2qLkRnPrGxIS8B
to0UK0pCX7W4juPiGnTKSINz9FeWOk1aNDZQz69iz9hQQaUYKVGwbPXrd52phrbb
SAI6DPeSX+zTcX5eSiWNo7fjaM4i6ufSRcZjuGUnLouTPWYpcRhETk1WmPK3pvIp
ZwX+A/kXwlHIpkrGrALRk3TB9+Ku9A==
=FgZP
-----END PGP SIGNATURE-----

--Sig_/VQR8vZIc74a6hsBJZ4U8JoN--
