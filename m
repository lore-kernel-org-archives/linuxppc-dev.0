Return-Path: <SRS0=8zLz=UO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381F5C31E50
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jun 2019 13:44:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0F121773
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jun 2019 13:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0F121773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45QzHD4KFpzDqxs
	for <linuxppc-dev@archiver.kernel.org>; Sat, 15 Jun 2019 23:44:40 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45Qz5G3MdDzDrg0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jun 2019 23:36:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45Qz5G0cJmz9sNC; Sat, 15 Jun 2019 23:36:01 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 2305ff225c0b1691ec2e93f3d6990e13a2e63c95
X-Patchwork-Hint: ignore
In-Reply-To: <20190604111632.22479-1-yamada.masahiro@socionext.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] ocxl: do not use C++ style comments in uapi header
Message-Id: <45Qz5G0cJmz9sNC@ozlabs.org>
Date: Sat, 15 Jun 2019 23:36:01 +1000 (AEST)
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
Cc: Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>, Joe Perches <joe@perches.com>,
 Thomas Gleixner <tglx@linutronix.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-06-04 at 11:16:32 UTC, Masahiro Yamada wrote:
> Linux kernel tolerates C++ style comments these days. Actually, the
> SPDX License tags for .c files start with //.
> 
> On the other hand, uapi headers are written in more strict C, where
> the C++ comment style is forbidden.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Acked-by: Andrew Donnellan <ajd@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2305ff225c0b1691ec2e93f3d6990e13

cheers
