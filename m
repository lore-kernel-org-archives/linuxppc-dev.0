Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4032C54E58
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2024 13:28:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TvrtS2qNcz3vcn
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2024 00:28:16 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tvrt10SyXz3dTt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2024 00:27:53 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tvrsy5b40z4x1R;
	Thu, 14 Mar 2024 00:27:50 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <dc9a794f82ab62572d7d0be5cb4b8b27920a4f78.1708078316.git.christophe.leroy@csgroup.eu>
References: <dc9a794f82ab62572d7d0be5cb4b8b27920a4f78.1708078316.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Implement set_memory_rox()
Message-Id: <171033598336.517247.4075878005606513732.b4-ty@ellerman.id.au>
Date: Thu, 14 Mar 2024 00:19:43 +1100
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

On Fri, 16 Feb 2024 11:12:05 +0100, Christophe Leroy wrote:
> Same as x86 and s390, add set_memory_rox() to avoid doing
> one pass with set_memory_ro() and a second pass with set_memory_x().
> 
> See commit 60463628c9e0 ("x86/mm: Implement native set_memory_rox()")
> and commit 22e99fa56443 ("s390/mm: implement set_memory_rox()") for
> more information.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Implement set_memory_rox()
      https://git.kernel.org/powerpc/c/09ca1b11716f96461a4675eb0418d5cb97687389

cheers
