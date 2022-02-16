Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C49C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Feb 2022 13:08:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JzJF22jCFz3ddb
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Feb 2022 00:08:54 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JzJDb1K3bz30gk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Feb 2022 00:08:31 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzJDb3K7fz4xbG;
 Thu, 17 Feb 2022 00:08:31 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20220124130544.408675-1-mpe@ellerman.id.au>
References: <20220124130544.408675-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/64: Move paca allocation later in boot
Message-Id: <164501689905.533336.2932909557674117265.b4-ty@ellerman.id.au>
Date: Thu, 17 Feb 2022 00:08:19 +1100
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
Cc: mahesh@linux.ibm.com, sourabhjain@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 25 Jan 2022 00:05:44 +1100, Michael Ellerman wrote:
> Mahesh & Sourabh identified two problems[1][2] with ppc64_bolted_size()
> and paca allocation.
> 
> The first is that on a Radix capable machine but with "disable_radix" on
> the command line, there is a window during early boot where
> early_radix_enabled() is true, even though it will later become false.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/64: Move paca allocation later in boot
      https://git.kernel.org/powerpc/c/2e7f1e2b30b5b8aa5de6547407c68670fd227ad8

cheers
