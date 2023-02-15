Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40211C636D4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Feb 2023 12:46:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PGyWB6bs0z3bhZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Feb 2023 23:46:30 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PGyRJ4mbLz3cd6
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2023 23:43:08 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4PGyRJ3Wt4z4x83;
	Wed, 15 Feb 2023 23:43:08 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <cover.1672767868.git.geoff@infradead.org>
References: <cover.1672767868.git.geoff@infradead.org>
Subject: Re: [PATCH v2 0/2] PS3 patches
Message-Id: <167646486205.1421441.10971268572692617486.b4-ty@ellerman.id.au>
Date: Wed, 15 Feb 2023 23:41:02 +1100
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

On Tue, 03 Jan 2023 17:51:03 +0000, Geoff Levand wrote:
> This v2 series is just the two PS3 specific patches of the v1 series.
> 
> -Geoff
> 
> The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:
> 
>   Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/ps3: Change updateboltedpp panic to info
      https://git.kernel.org/powerpc/c/5705c6d97efc4aa9478fe2887fd911f60ddf17e5
[2/2] powerpc/ps3: Refresh ps3_defconfig
      https://git.kernel.org/powerpc/c/544f823ec7a34332550f22735959d3e1ffcf4684

cheers
