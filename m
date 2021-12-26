Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24426C433F5
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Dec 2021 21:54:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JMZMb67nyz3cTq
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Dec 2021 08:54:35 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JMZLt4tBKz2yn3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Dec 2021 08:53:58 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4JMZLs3B5Nz4xhj;
 Mon, 27 Dec 2021 08:53:57 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, maz@kernel.org, benh@kernel.crashing.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, paulus@samba.org
In-Reply-To: <aa145f674e08044c98f13f1a985faa9cc29c3708.1639777976.git.christophe.jaillet@wanadoo.fr>
References: <aa145f674e08044c98f13f1a985faa9cc29c3708.1639777976.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] powerpc/mpic: Use bitmap_zalloc() when applicable
Message-Id: <164055552979.3187272.5056547935512472848.b4-ty@ellerman.id.au>
Date: Mon, 27 Dec 2021 08:52:09 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 17 Dec 2021 22:54:12 +0100, Christophe JAILLET wrote:
> 'mpic->protected' is a bitmap. So use 'bitmap_zalloc()' to simplify
> code and improve the semantic, instead of hand writing it.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/mpic: Use bitmap_zalloc() when applicable
      https://git.kernel.org/powerpc/c/2fe4ca6ad7f6a0b98f97c498320051e5066e4b95

cheers
