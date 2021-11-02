Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A85EC433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:41:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E157603E5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E157603E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hk7Jt5mmsz3dqv
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 22:41:18 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hk7Fd62mhz2yNT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Nov 2021 22:38:29 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7Fd596nz4xcb;
 Tue,  2 Nov 2021 22:38:29 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <24d4ca0ada683c9436a5f812a7aeb0a1362afa2b.1630398606.git.christophe.leroy@csgroup.eu>
References: <24d4ca0ada683c9436a5f812a7aeb0a1362afa2b.1630398606.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/machdep: Remove stale functions from ppc_md
 structure
Message-Id: <163584790792.1845480.7374008304551839348.b4-ty@ellerman.id.au>
Date: Tue, 02 Nov 2021 21:11:47 +1100
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

On Tue, 31 Aug 2021 08:30:24 +0000 (UTC), Christophe Leroy wrote:
> ppc_md.iommu_save() is not set anymore by any platform after
> commit c40785ad305b ("powerpc/dart: Use a cachable DART").
> So iommu_save() has become a nop and can be removed.
> 
> ppc_md.show_percpuinfo() is not set anymore by any platform after
> commit 4350147a816b ("[PATCH] ppc64: SMU based macs cpufreq support").
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/machdep: Remove stale functions from ppc_md structure
      https://git.kernel.org/powerpc/c/8f7fadb4ba87f6639d817a9b2d99112e9507dc63

cheers
