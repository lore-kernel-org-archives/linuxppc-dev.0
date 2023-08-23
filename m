Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9D9EE4993
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Aug 2023 12:11:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RW4nW0ffnz3gk3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Aug 2023 22:11:27 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RW4cm6zVwz3c40
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2023 22:03:52 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cm5bctz4x2Q;
	Wed, 23 Aug 2023 22:03:52 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <cf652e47ea9e453e89813611b6f76d0939a12063.1687344017.git.christophe.leroy@csgroup.eu>
References: <cf652e47ea9e453e89813611b6f76d0939a12063.1687344017.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/reg: Remove #ifdef around mtspr macro
Message-Id: <169279175565.797584.12691137360042115730.b4-ty@ellerman.id.au>
Date: Wed, 23 Aug 2023 21:55:55 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 21 Jun 2023 12:40:50 +0200, Christophe Leroy wrote:
> That ifdef was introduced by commit 1458dd951f7c ("powerpc/8xx:
> Handle CPU6 ERRATA directly in mtspr() macro") and left over by
> commit 2a45addd21de ("powerpc/8xx: Remove CPU6 ERRATA Workaround")
> 
> Remove it.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/reg: Remove #ifdef around mtspr macro
      https://git.kernel.org/powerpc/c/6039fcd3fba99451ea9d013c4d3a65a40b2feff0

cheers
