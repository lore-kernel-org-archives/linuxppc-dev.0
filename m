Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4BFECAAA1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Oct 2022 11:51:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MzLW220Crz3f3M
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Oct 2022 22:51:58 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MzLTs5TCtz3cC0
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2022 22:50:57 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4MzLTs0zBdz4x1V;
	Fri, 28 Oct 2022 22:50:57 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <20221013230710.1987253-1-npiggin@gmail.com>
References: <20221013230710.1987253-1-npiggin@gmail.com>
Subject: Re: [PATCH 1/3] powerpc/64s: Add lockdep for HPTE lock
Message-Id: <166695778345.1609528.8674193804254145251.b4-ty@ellerman.id.au>
Date: Fri, 28 Oct 2022 22:49:43 +1100
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
Cc: Nicholas Miehlbradt <nicholas@linux.ibm.com>, Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 14 Oct 2022 09:07:08 +1000, Nicholas Piggin wrote:
> Add lockdep annotation for the HPTE bit-spinlock. Modern systems don't
> take the tlbie lock, so this shows up some of the same lockdep warnings
> that were being reported by the ppc970. And they're not taken in exactly
> the same places so this is nice to have in its own right.
> 
> 

Applied to powerpc/fixes.

[1/3] powerpc/64s: Add lockdep for HPTE lock
      https://git.kernel.org/powerpc/c/be83d5485da549d934ec65463ea831709f2827b1
[2/3] powerpc/64s: make HPTE lock and native_tlbie_lock irq-safe
      https://git.kernel.org/powerpc/c/35159b5717fa9c6031fdd6a2193c7a3dc717ce33
[3/3] powerpc/64s: make linear_map_hash_lock a raw spinlock
      https://git.kernel.org/powerpc/c/b12eb279ff552bd67c167b0fe701ae602aa7311e

cheers
