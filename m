Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B32AC433FE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Oct 2022 13:47:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MhfCX4FKpz3fvL
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Oct 2022 00:47:36 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mhf1W2y6Dz3dpx
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2022 00:38:55 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhf1W1lkXz4xHD;
	Wed,  5 Oct 2022 00:38:55 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Hari Bathini <hbathini@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20220912065031.57416-1-hbathini@linux.ibm.com>
References: <20220912065031.57416-1-hbathini@linux.ibm.com>
Subject: Re: [PATCH v2] ppc64/kdump: Limit kdump base to 512MB
Message-Id: <166488992311.779920.7739471655722413795.b4-ty@ellerman.id.au>
Date: Wed, 05 Oct 2022 00:25:23 +1100
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 12 Sep 2022 12:20:31 +0530, Hari Bathini wrote:
> Since commit e641eb03ab2b0 ("powerpc: Fix up the kdump base cap to
> 128M") memory for kdump kernel has been reserved at an offset of
> 128MB. This held up well for a long time before running into boot
> failure on LPARs having a lot of cores. Commit 7c5ed82b800d8
> ("powerpc: Set crashkernel offset to mid of RMA region") fixed this
> boot failure by moving the offset to mid of RMA region. This change
> meant the offset is either 256MB or 512MB on LPARs as ppc64_rma_size
> was 512MB or 1024MB owing to commit 103a8542cb35b ("powerpc/book3s64/
> radix: Fix boot failure with large amount of guest memory")
> 
> [...]

Applied to powerpc/next.

[1/1] ppc64/kdump: Limit kdump base to 512MB
      https://git.kernel.org/powerpc/c/bd7dc90e52e8db7ee0f38c51bc9047bafb54fe43

cheers
