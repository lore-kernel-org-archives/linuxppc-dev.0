Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E1FC433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Feb 2022 12:31:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JzHQ53DMtz3dpW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Feb 2022 23:31:41 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JzHNM4L4kz2xYG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Feb 2022 23:30:11 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzHNM68mqz4xmt;
 Wed, 16 Feb 2022 23:30:11 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <1e6162f334167e75f1140082932e3a354b16daba.1642413973.git.christophe.leroy@csgroup.eu>
References: <1e6162f334167e75f1140082932e3a354b16daba.1642413973.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Enable STRICT_MODULE_RWX for the 603 core
Message-Id: <164501434892.521186.15893809567759741150.b4-ty@ellerman.id.au>
Date: Wed, 16 Feb 2022 23:25:48 +1100
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
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 17 Jan 2022 10:06:39 +0000, Christophe Leroy wrote:
> The book3s/32 MMU doesn't support per page execution protection and
> doesn't support RO protection for kernel pages.
> 
> However, on the 603 which implements software loaded TLBs, execution
> protection is honored by the TLB Miss handler which doesn't load
> Instruction TLB for non executable pages. And RO protection is
> honored by clearing the C bit for RO pages, leading to DSI.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32s: Enable STRICT_MODULE_RWX for the 603 core
      https://git.kernel.org/powerpc/c/0670010f3b10aeaad0dfdf0dad0bcd020fc70eb5

cheers
