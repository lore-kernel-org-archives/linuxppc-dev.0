Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34211C63703
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Dec 2022 12:53:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NSYxM4sZJz3fX7
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Dec 2022 23:53:43 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NSYrt0zTPz3bgk
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2022 23:49:50 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4NSYrs2G5Jz4xvL;
	Thu,  8 Dec 2022 23:49:49 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Christoph Hellwig <hch@lst.de>, npiggin@gmail.com, geoff@infradead.org, mpe@ellerman.id.au
In-Reply-To: <20221122072225.423432-1-hch@lst.de>
References: <20221122072225.423432-1-hch@lst.de>
Subject: Re: [PATCH] powerpc/ps3: mark ps3_system_bus_type static
Message-Id: <167050315778.1457988.3481430850235317266.b4-ty@ellerman.id.au>
Date: Thu, 08 Dec 2022 23:39:17 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 22 Nov 2022 08:22:25 +0100, Christoph Hellwig wrote:
> ps3_system_bus_type is only used inside of system-bus.c, so remove
> the external declaration and the very outdated comment next to it.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/ps3: mark ps3_system_bus_type static
      https://git.kernel.org/powerpc/c/dea681c91d3cd5326f87d0a3c93079573e22ce9a

cheers
