Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C487CC43334
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Jul 2022 11:39:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lc3kW1bb3z3f3F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Jul 2022 21:39:47 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lc3fC0vdTz3c4j
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2022 21:36:03 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lc3fB4CwDz4xZh;
	Mon,  4 Jul 2022 21:36:02 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <715e644fb3c7d992c0b71f6165ab6cf8c682055a.1655706069.git.christophe.leroy@csgroup.eu>
References: <715e644fb3c7d992c0b71f6165ab6cf8c682055a.1655706069.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Remove _PAGE_SAO stub for book3e/64
Message-Id: <165693441123.9954.5396439090389348451.b4-ty@ellerman.id.au>
Date: Mon, 04 Jul 2022 21:33:31 +1000
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

On Mon, 20 Jun 2022 08:21:22 +0200, Christophe Leroy wrote:
> Since commit 634093c59a12 ("powerpc/mm: enable
> ARCH_HAS_VM_GET_PAGE_PROT"), _PAGE_SAO is used only in
> arch/powerpc/mm/book3s64/pgtable.c
> 
> The _PAGE_SAO stub defined as 0 for book3e/64 can be removed.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Remove _PAGE_SAO stub for book3e/64
      https://git.kernel.org/powerpc/c/12a9eddd239e14ccbf0ea50b3504a21bda002ba9

cheers
