Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75C0C10F15
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2024 09:22:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VNKXM3h9jz3vZP
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2024 19:22:27 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VNKWX59CKz3bsT
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2024 19:21:44 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNKWS1hfjz4wyh;
	Mon, 22 Apr 2024 19:21:40 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20240328130200.3041687-1-mpe@ellerman.id.au>
References: <20240328130200.3041687-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/crypto/chacha-p10: Fix failure on non Power10
Message-Id: <171377768068.1735812.767688634260933265.b4-ty@ellerman.id.au>
Date: Mon, 22 Apr 2024 19:21:20 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Cc: dtsen@linux.ibm.com, msuchanek@suse.de, herbert@gondor.apana.org.au, wireguard@lists.zx2c4.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 29 Mar 2024 00:02:00 +1100, Michael Ellerman wrote:
> The chacha-p10-crypto module provides optimised chacha routines for
> Power10. It also selects CRYPTO_ARCH_HAVE_LIB_CHACHA which says it
> provides chacha_crypt_arch() to generic code.
> 
> Notably the module needs to provide chacha_crypt_arch() regardless of
> whether it is loaded on Power10 or an older CPU.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/crypto/chacha-p10: Fix failure on non Power10
      https://git.kernel.org/powerpc/c/69630926011c1f7170a465b7b5c228deb66e9372

cheers
