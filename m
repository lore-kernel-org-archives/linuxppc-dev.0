Return-Path: <SRS0=BXao=BG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BDAC433E0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2020 07:34:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC8E2070B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2020 07:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC8E2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BFWm30pK6zF1RC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2020 17:34:43 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BFWZw0SP9zDqlZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2020 17:26:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BFWZv3Rl1z9sSP; Mon, 27 Jul 2020 17:26:47 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Finn Thain <fthain@telegraphics.com.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <cover.1590880623.git.fthain@telegraphics.com.au>
References: <cover.1590880623.git.fthain@telegraphics.com.au>
Subject: Re: [PATCH 0/8] Mac ADB IOP driver fixes
Message-Id: <159583478164.602200.6100049166996515383.b4-ty@ellerman.id.au>
Date: Mon, 27 Jul 2020 17:26:47 +1000 (AEST)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org,
 Joshua Thompson <funaho@jurai.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 31 May 2020 09:17:03 +1000, Finn Thain wrote:
> The adb-iop driver was never finished. Some deficiencies have become
> apparent over the years. For example,
> 
>  - Mouse and/or keyboard may stop working if used together
> 
>  - SRQ autopoll list cannot be changed
> 
> [...]

Applied to powerpc/next.

[1/8] macintosh/adb-iop: Remove dead and redundant code
      https://git.kernel.org/powerpc/c/8384c82ab0860cd7db2ce4ec403e574f4ee54b6e
[2/8] macintosh/adb-iop: Correct comment text
      https://git.kernel.org/powerpc/c/ff785e179faf4bb06a2f73b8dcde6dabb66a83d2
[3/8] macintosh/adb-iop: Adopt bus reset algorithm from via-macii driver
      https://git.kernel.org/powerpc/c/303511edb859b1fbf48b3c1d1d53b33a6ebd2a2b
[4/8] macintosh/adb-iop: Access current_req and adb_iop_state when inside lock
      https://git.kernel.org/powerpc/c/aac840eca8fec02d594560647130d4e4447e10d9
[5/8] macintosh/adb-iop: Resolve static checker warnings
      https://git.kernel.org/powerpc/c/56b732edda96b1942fff974fd298ea2a2c543b94
[6/8] macintosh/adb-iop: Implement idle -> sending state transition
      https://git.kernel.org/powerpc/c/32226e81704398317e1cc5a82d24c0ef3cc25e5e
[7/8] macintosh/adb-iop: Implement sending -> idle state transition
      https://git.kernel.org/powerpc/c/e2954e5f727fad126258e83259b513988973c166
[8/8] macintosh/adb-iop: Implement SRQ autopolling
      https://git.kernel.org/powerpc/c/c66da95a39ec2bb95544c3def974d96e8c178f57

cheers
