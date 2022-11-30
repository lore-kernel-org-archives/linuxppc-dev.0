Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 631F1C433FE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Nov 2022 09:37:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NMYz06cW1z3fRc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Nov 2022 20:37:48 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NMYqn09zyz3bfM
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2022 20:31:33 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYqm24lXz4xRB;
	Wed, 30 Nov 2022 20:31:32 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Shaomin Deng <dengshaomin@cdjrlc.com>, linuxppc-dev@lists.ozlabs.org, geoff@infradead.org
In-Reply-To: <20220904155102.26957-1-dengshaomin@cdjrlc.com>
References: <20220904155102.26957-1-dengshaomin@cdjrlc.com>
Subject: Re: [PATCH] drivers/ps3: Fix double word in comments
Message-Id: <166980023191.3017288.980761940134729759.b4-ty@ellerman.id.au>
Date: Wed, 30 Nov 2022 20:23:51 +1100
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 4 Sep 2022 11:51:02 -0400, Shaomin Deng wrote:
> Drop the repeated word "when" in comments.
> 
> 

Applied to powerpc/next.

[1/1] drivers/ps3: Fix double word in comments
      https://git.kernel.org/powerpc/c/ff8fae94e26f5cd2779ceda0ee6d714a10501abd

cheers
