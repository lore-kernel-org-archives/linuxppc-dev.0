Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE21DEE4993
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Aug 2023 12:08:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RW4jj4rwYz3fbp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Aug 2023 22:08:09 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RW4cg28Vpz2yDM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2023 22:03:47 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cg0fXrz4x2F;
	Wed, 23 Aug 2023 22:03:47 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <38fe1078eb403eef74dc8f29387636fd7ecdf43c.1692276041.git.christophe.leroy@csgroup.eu>
References: <38fe1078eb403eef74dc8f29387636fd7ecdf43c.1692276041.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/4xx: Remove WatchdogHandler() to fix no previous prototype error
Message-Id: <169279175575.797584.15357260120526935864.b4-ty@ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 17 Aug 2023 14:40:49 +0200, Christophe Leroy wrote:
> Building ppc40x_defconfig throws the following error:
> 
>   CC      arch/powerpc/kernel/traps.o
> arch/powerpc/kernel/traps.c:2232:29: warning: no previous prototype for 'WatchdogHandler' [-Wmissing-prototypes]
>  2232 | void __attribute__ ((weak)) WatchdogHandler(struct pt_regs *regs)
>       |                             ^~~~~~~~~~~~~~~
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/4xx: Remove WatchdogHandler() to fix no previous prototype error
      https://git.kernel.org/powerpc/c/ca13c130a43fe3ab625d22ada0a61e5c0b612229

cheers
