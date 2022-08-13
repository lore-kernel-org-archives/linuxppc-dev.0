Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A2EC25B0E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Aug 2022 22:39:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M4wSk0Cg6z3c8C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Aug 2022 08:39:02 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M4wSH561Lz2xGv
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Aug 2022 08:38:39 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4M4wSG1t2qz4x2c;
	Sun, 14 Aug 2022 08:38:38 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <eca9251f1e1f82c4c46ec6380ddb28356ab3fdfe.1659527244.git.christophe.leroy@csgroup.eu>
References: <eca9251f1e1f82c4c46ec6380ddb28356ab3fdfe.1659527244.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/ppc-opcode: Fix PPC_RAW_TW()
Message-Id: <166043029294.1050412.7867126278150984193.b4-ty@ellerman.id.au>
Date: Sun, 14 Aug 2022 08:38:12 +1000
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
Cc: "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 3 Aug 2022 13:47:33 +0200, Christophe Leroy wrote:
> PPC_RAW_TW() is erroneously defined with base code 0x7f000008
> instead of 0x7c000008.
> 
> That's invisible because its only user is PPC_RAW_TRAP() which is
> 0x7fe00008, but fix it anyway to avoid any risk of future bug.
> 
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/ppc-opcode: Fix PPC_RAW_TW()
      https://git.kernel.org/powerpc/c/59bab33a4f57f886c5f8a4d1f2bed728ec185d16

cheers
