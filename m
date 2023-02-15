Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7267CC636D4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Feb 2023 12:43:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PGyRm6HF4z3f4M
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Feb 2023 23:43:32 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PGyRF4pRlz3cKG
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2023 23:43:05 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4PGyRF2QHWz4x7s;
	Wed, 15 Feb 2023 23:43:05 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <e62892e32c14a7a5738c597e39e0082cb0abf21c.1675335659.git.christophe.leroy@csgroup.eu>
References: <e62892e32c14a7a5738c597e39e0082cb0abf21c.1675335659.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Disable CPU unknown by CLANG when CC_IS_CLANG
Message-Id: <167646485519.1421441.15913006369717887437.b4-ty@ellerman.id.au>
Date: Wed, 15 Feb 2023 23:40:55 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2 Feb 2023 12:01:04 +0100, Christophe Leroy wrote:
> CLANG only knows the following CPUs:
> 
> generic, 440, 450, 601, 602, 603, 603e, 603ev, 604, 604e, 620, 630,
> g3, 7400, g4, 7450, g4+, 750, 8548, 970, g5, a2, e500, e500mc, e5500,
> power3, pwr3, power4, pwr4, power5, pwr5, power5x, pwr5x, power6,
> pwr6, power6x, pwr6x, power7, pwr7, power8, pwr8, power9, pwr9,
> power10, pwr10, powerpc, ppc, ppc32, powerpc64, ppc64, powerpc64le,
> ppc64le, futur
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Disable CPU unknown by CLANG when CC_IS_CLANG
      https://git.kernel.org/powerpc/c/4b10306e98456aed03cad75ce467e8b1efdccca0

cheers
