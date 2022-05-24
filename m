Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B348BC433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 11:19:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L6sDY1fXMz3fYR
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 21:19:57 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L6s7f17hVz3c9m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2022 21:15:42 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s7f0P1kz4ySq;
 Tue, 24 May 2022 21:15:42 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Kevin Hao <haokexin@gmail.com>
In-Reply-To: <20220329085709.4132729-1-haokexin@gmail.com>
References: <20220329085709.4132729-1-haokexin@gmail.com>
Subject: Re: [PATCH] powerpc: Export mmu_feature_keys[] as non-GPL
Message-Id: <165339051583.1718562.2766738766777540660.b4-ty@ellerman.id.au>
Date: Tue, 24 May 2022 21:08:35 +1000
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
Cc: Nathaniel Filardo <nwfilardo@gmail.com>, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 29 Mar 2022 16:57:09 +0800, Kevin Hao wrote:
> When the mmu_feature_keys[] was introduced in the commit c12e6f24d413
> ("powerpc: Add option to use jump label for mmu_has_feature()"),
> it is unlikely that it would be used either directly or indirectly in
> the out of tree modules. So we export it as GPL only. But with the
> evolution of the codes, especially the PPC_KUAP support, it may be
> indirectly referenced by some primitive macro or inline functions such
> as get_user() or __copy_from_user_inatomic(), this will make it
> impossible to build many non GPL modules (such as ZFS) on ppc
> architecture. Fix this by exposing the mmu_feature_keys[] to the
> non-GPL modules too.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Export mmu_feature_keys[] as non-GPL
      https://git.kernel.org/powerpc/c/d9e5c3e9e75162f845880535957b7fd0b4637d23

cheers
