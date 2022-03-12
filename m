Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2558EC433F5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Mar 2022 10:34:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KFzgj5vQ5z3f0R
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Mar 2022 21:34:25 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KFzbf64qDz30L1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Mar 2022 21:30:54 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4KFzbf0s1pz4xsg;
 Sat, 12 Mar 2022 21:30:54 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: paulus@samba.org, benh@kernel.crashing.org, arnd@arndb.de,
 christophe.leroy@csgroup.eu, jk@ozlabs.org, YueHaibing <yuehaibing@huawei.com>,
 mpe@ellerman.id.au
In-Reply-To: <20220308100928.23540-1-yuehaibing@huawei.com>
References: <20220308100928.23540-1-yuehaibing@huawei.com>
Subject: Re: [PATCH v2 -next] powerpc/spufs: Fix build warning when
 CONFIG_PROC_FS=n
Message-Id: <164708098605.827774.15948027933865085338.b4-ty@ellerman.id.au>
Date: Sat, 12 Mar 2022 21:29:46 +1100
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

On Tue, 8 Mar 2022 18:09:28 +0800, YueHaibing wrote:
> arch/powerpc/platforms/cell/spufs/sched.c:1055:12: warning: ‘show_spu_loadavg’ defined but not used [-Wunused-function]
>  static int show_spu_loadavg(struct seq_file *s, void *private)
>             ^~~~~~~~~~~~~~~~
> 
> Move it into #ifdef block to fix this, also remove unneeded semicolon.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/spufs: Fix build warning when CONFIG_PROC_FS=n
      https://git.kernel.org/powerpc/c/5986f6b6575ac830ede9648cfb64353c58067a9f

cheers
