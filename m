Return-Path: <SRS0=Y6lA=T6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E4EC28CC0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 May 2019 13:50:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A36DF24D63
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 May 2019 13:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36DF24D63
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gondor.apana.org.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45F89C4P3ZzDqKP
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 May 2019 23:50:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gondor.apana.org.au
 (client-ip=216.24.177.18; helo=deadmen.hmeau.com;
 envelope-from=herbert@gondor.apana.org.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=gondor.apana.org.au
Received: from deadmen.hmeau.com (helcar.hmeau.com [216.24.177.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45F7yN0MNtzDqVD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2019 23:40:57 +1000 (AEST)
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
 by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
 id 1hWLIZ-0005V5-Tu; Thu, 30 May 2019 21:40:52 +0800
Received: from herbert by gondobar with local (Exim 4.89)
 (envelope-from <herbert@gondor.apana.org.au>)
 id 1hWLIW-0003ca-FG; Thu, 30 May 2019 21:40:48 +0800
Date: Thu, 30 May 2019 21:40:48 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] crypto: vmx - convert to SPDX license identifiers
Message-ID: <20190530134048.xg3jdm53mydtxcd4@gondor.apana.org.au>
References: <20190520164232.159053-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520164232.159053-1-ebiggers@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
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
Cc: Nayna Jain <nayna@linux.ibm.com>,
 Paulo Flabiano Smorigo <pfsmorigo@gmail.com>, linux-crypto@vger.kernel.org,
 Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>,
 linuxppc-dev@lists.ozlabs.org, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, May 20, 2019 at 09:42:32AM -0700, Eric Biggers wrote:
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

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
