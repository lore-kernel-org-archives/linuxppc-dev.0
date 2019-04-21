Return-Path: <SRS0=M5iZ=SX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECE5C10F14
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:43:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C172087B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Apr 2019 14:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C172087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44nCBF2GWmzDqHr
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2019 00:43:17 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44nBf81ly1zDqMw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2019 00:18:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44nBf73PQyz9s8m; Mon, 22 Apr 2019 00:18:55 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6917735e8f905da1f62ccdf62830b185524835c7
X-Patchwork-Hint: ignore
In-Reply-To: <1553345455-32085-1-git-send-email-jagdsh.linux@gmail.com>
To: jagdsh.linux@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 npiggin@gmail.com, hristophe.leroy@c-s.fr, arnd@arndb.de, anton@ozlabs.org,
 paul.burton@mips.com, mikey@neuling.org, akpm@linux-foundation.org,
 mwb@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: arch/powerpc: Remove duplicate headers
Message-Id: <44nBf73PQyz9s8m@ozlabs.org>
Date: Mon, 22 Apr 2019 00:18:55 +1000 (AEST)
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
Cc: Jagadeesh Pagadala <jagdsh.linux@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 2019-03-23 at 12:50:55 UTC, jagdsh.linux@gmail.com wrote:
> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
> 
> Remove duplicate headers which are included twice.
> 
> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6917735e8f905da1f62ccdf62830b185

cheers
