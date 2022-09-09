Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2531ECAAD3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Sep 2022 12:15:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MPFLK3ktlz3fpx
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Sep 2022 22:15:05 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MPFDj305Yz3bZC
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2022 22:10:13 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4MPFDj29Ssz4xc4;
	Fri,  9 Sep 2022 22:10:13 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, agust@denx.de, paulus@samba.org, Liang He <windhl@126.com>, benh@kernel.crashing.org, mpe@ellerman.id.au
In-Reply-To: <20220621080349.4081689-1-windhl@126.com>
References: <20220621080349.4081689-1-windhl@126.com>
Subject: Re: [PATCH] powerpc/512x: Hold the reference returned by of_find_compatible_node
Message-Id: <166272523902.2076816.2246386814291423303.b4-ty@ellerman.id.au>
Date: Fri, 09 Sep 2022 22:07:19 +1000
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

On Tue, 21 Jun 2022 16:03:49 +0800, Liang He wrote:
> In mpc5121_clk_provide_migration_support(), we need to hold the
> reference returned by of_find_compatible_node() and use it to call
> of_node_put for refcount balance.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/512x: Hold the reference returned by of_find_compatible_node
      https://git.kernel.org/powerpc/c/cc0dd82c18559184e009bef8d0353d008013a813

cheers
