Return-Path: <SRS0=oIc7=TV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B300C04AAF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 May 2019 03:59:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C798A21479
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 May 2019 03:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C798A21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 457MTQ6vSqzDqMX
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 May 2019 13:59:22 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 457MS26d7WzDqJ1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 May 2019 13:58:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 457MS06LgNz9s9T;
 Tue, 21 May 2019 13:58:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] crypto: vmx - convert to SPDX license identifiers
In-Reply-To: <20190520164232.159053-1-ebiggers@kernel.org>
References: <20190520164232.159053-1-ebiggers@kernel.org>
Date: Tue, 21 May 2019 13:58:06 +1000
Message-ID: <874l5o8nn5.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Breno =?utf-8?Q?Leit=C3=A3o?= <leitao@debian.org>,
 linuxppc-dev@lists.ozlabs.org, Nayna Jain <nayna@linux.ibm.com>,
 Paulo Flabiano Smorigo <pfsmorigo@gmail.com>, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Eric Biggers <ebiggers@kernel.org> writes:
> From: Eric Biggers <ebiggers@google.com>
>
> Remove the boilerplate license text and replace it with the equivalent
> SPDX license identifier.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  drivers/crypto/vmx/aes.c     | 14 +-------------
>  drivers/crypto/vmx/aes_cbc.c | 14 +-------------
>  drivers/crypto/vmx/aes_ctr.c | 14 +-------------
>  drivers/crypto/vmx/aes_xts.c | 14 +-------------
>  drivers/crypto/vmx/vmx.c     | 14 +-------------
>  5 files changed, 5 insertions(+), 65 deletions(-)

Looks good to me.

Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
