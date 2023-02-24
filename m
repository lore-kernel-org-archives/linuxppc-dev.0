Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB20FC64ED6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Feb 2023 02:26:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PNDKh2YDKz3fH2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Feb 2023 13:26:32 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PNDHv2tgyz3cJK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2023 13:24:59 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4PNDHp3Tm6z4x5Q;
	Fri, 24 Feb 2023 13:24:54 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>, Pali Rohár <pali@kernel.org>, Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <ac9107acf24135e1a07e8f84d2090572d43e3fe4.1676712510.git.christophe.leroy@csgroup.eu>
References: <ac9107acf24135e1a07e8f84d2090572d43e3fe4.1676712510.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/e500: Add missing prototype for 'relocate_init'
Message-Id: <167720547468.3316778.7561014088346218012.b4-ty@ellerman.id.au>
Date: Fri, 24 Feb 2023 13:24:34 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 18 Feb 2023 10:28:50 +0100, Christophe Leroy wrote:
> Kernel test robot reports:
> 
>  arch/powerpc/mm/nohash/e500.c:314:21: warning: no previous prototype for 'relocate_init' [-Wmissing-prototypes]
>      314 | notrace void __init relocate_init(u64 dt_ptr, phys_addr_t start)
>          |                     ^~~~~~~~~~~~~
> 
> Add it in mm/mmu_decl.h, close to associated is_second_reloc
> variable declaration.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/e500: Add missing prototype for 'relocate_init'
      https://git.kernel.org/powerpc/c/6f8675a6b06dabe62015c6747df5e957cd159338

cheers
