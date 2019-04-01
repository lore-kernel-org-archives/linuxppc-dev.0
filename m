Return-Path: <SRS0=9RGo=SD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27274C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 06:24:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA2C2070B
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 06:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=neuling.org header.i=@neuling.org header.b="TWw5SZak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA2C2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Xj3T44LhzDqNJ
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Apr 2019 17:24:05 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Xj0d5SPxzDqMW
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Apr 2019 17:21:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=neuling.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=neuling.org header.i=@neuling.org header.b="TWw5SZak"; 
 dkim-atps=neutral
Received: from spoke.localdomain (localhost [127.0.0.1])
 by ozlabs.org (Postfix) with ESMTP id 44Xj0d3SsGz9sQw;
 Mon,  1 Apr 2019 17:21:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=neuling.org;
 s=201811; t=1554099697;
 bh=07q8tXMo88WI7t77jFF7qGxdsavc2yv3LQLXa8qvsTg=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=TWw5SZakcuTVHPsCiwox2cRwlDaiUoTEZ5LE86NCrvdUeXpleRTVuG7UtHeU9VKMK
 Oxoq0BjEj1gakvJAQx6FbXbnIbCOSLMB30QJC3pSK5YmR0iHFTDpAO91Nhksco64dK
 M1kWDLQUSdxsYmEgdHoKx7/G73MtqZQXJWTqWypwqmwkL+ELM+aTMZTI9qtWkjuZLq
 PV0Kf0tu5Om7svdL2KKRbnc6oTtpkhS4L5ucAjoMRE1Xnw1PTiXN5ifq1Wj4OCtFAA
 pHm2Dc8ijneVXje/lRAu0hXKaz6dScnNP1oqIpPZ3RPlAuwFyTYrMbDhnEM4LNHMkT
 mDVIFPlZbj2Ww==
Received: by spoke.localdomain (Postfix, from userid 1000)
 id 6B8992A0352; Mon,  1 Apr 2019 17:21:37 +1100 (AEDT)
Message-ID: <282f7310ef16e0d37161b0bb2d03baa57c40db69.camel@neuling.org>
Subject: Re: [PATCH] Documentation: powerpc: Expand the DAWR acronym
From: Michael Neuling <mikey@neuling.org>
To: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 01 Apr 2019 17:21:37 +1100
In-Reply-To: <20190401061156.31366-1-joel@jms.id.au>
References: <20190401061156.31366-1-joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
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
Cc: linux-doc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-04-01 at 16:41 +1030, Joel Stanley wrote:
> Those not of us not drowning in POWER might not know what this means.

Hehe... thanks!

> Signed-off-by: Joel Stanley <joel@jms.id.au>

Acked-by: Michael Neuling <mikey@neuling.org>

> ---
>  Documentation/powerpc/DAWR-POWER9.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/powerpc/DAWR-POWER9.txt
> b/Documentation/powerpc/DAWR-POWER9.txt
> index 2feaa6619658..f6c24e54ce83 100644
> --- a/Documentation/powerpc/DAWR-POWER9.txt
> +++ b/Documentation/powerpc/DAWR-POWER9.txt
> @@ -1,10 +1,10 @@
>  DAWR issues on POWER9
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> =20
> -On POWER9 the DAWR can cause a checkstop if it points to cache
> -inhibited (CI) memory. Currently Linux has no way to disinguish CI
> -memory when configuring the DAWR, so (for now) the DAWR is disabled by
> -this commit:
> +On POWER9 the Data Address Watchpoint Register (DAWR) can cause a checks=
top
> +if it points to cache inhibited (CI) memory. Currently Linux has no way =
to
> +disinguish CI memory when configuring the DAWR, so (for now) the DAWR is
> +disabled by this commit:
> =20
>      commit 9654153158d3e0684a1bdb76dbababdb7111d5a0
>      Author: Michael Neuling <mikey@neuling.org>

