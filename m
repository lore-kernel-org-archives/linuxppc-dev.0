Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 887C7C433EF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 May 2022 10:18:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L1JHL1gWZz3fJH
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 May 2022 20:18:06 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L1JG62swvz3f6f
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 May 2022 20:17:02 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1JG60GkKz4xXS;
 Sun, 15 May 2022 20:17:02 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>
In-Reply-To: <20220330112437.540214-1-joel@jms.id.au>
References: <20220330112437.540214-1-joel@jms.id.au>
Subject: Re: [PATCH] powerpc/boot: Build wrapper for an appropriate CPU
Message-Id: <165260954461.1040779.3013932363413899123.b4-ty@ellerman.id.au>
Date: Sun, 15 May 2022 20:12:24 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 30 Mar 2022 21:54:37 +1030, Joel Stanley wrote:
> Currently the boot wrapper lacks a -mcpu option, so it will be built for
> the toolchain's default cpu. This is a problem if the toolchain defaults
> to a cpu with newer instructions.
> 
> We could wire in TARGET_CPU but instead use the oldest supported option
> so the wrapper runs anywhere.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/boot: Build wrapper for an appropriate CPU
      https://git.kernel.org/powerpc/c/40a75584e526cc489234dac0897cd599e6013483

cheers
