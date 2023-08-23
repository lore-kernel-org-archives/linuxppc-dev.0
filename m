Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95077EE4993
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Aug 2023 12:11:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RW4p123Rmz3f0j
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Aug 2023 22:11:53 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RW4cn5rhBz3c2T
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2023 22:03:53 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4RW4cn3m1rz4x2P;
	Wed, 23 Aug 2023 22:03:53 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <f1d4a15da70190f8c2fcddb377bbc1e09827242c.1687343857.git.christophe.leroy@csgroup.eu>
References: <f1d4a15da70190f8c2fcddb377bbc1e09827242c.1687343857.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/step: Mark __copy_mem_out() and __emulate_dcbz() __always_inline
Message-Id: <169279175564.797584.4721586858055546179.b4-ty@ellerman.id.au>
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

On Wed, 21 Jun 2023 12:38:10 +0200, Christophe Leroy wrote:
> objtool reports two folliwng warnings:
>   arch/powerpc/lib/sstep.o: warning: objtool: copy_mem_out+0x3c
>     (.text+0x30c): call to __copy_mem_out() with UACCESS enabled
>   arch/powerpc/lib/sstep.o: warning: objtool: emulate_dcbz+0x70
>     (.text+0x4dc): call to __emulate_dcbz() with UACCESS enabled
> 
> Mark __copy_mem_out() and __emulate_dcbz() __always_inline
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/step: Mark __copy_mem_out() and __emulate_dcbz() __always_inline
      https://git.kernel.org/powerpc/c/0d5769f9503d9a88661b82fee6a320e711f8b01a

cheers
