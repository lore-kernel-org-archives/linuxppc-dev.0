Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B73C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:39:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF11F603E5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF11F603E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hk7HB3D4Xz2xg3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 22:39:50 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hk7FZ2KQJz2xBq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Nov 2021 22:38:26 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7FZ14QSz4xcF;
 Tue,  2 Nov 2021 22:38:26 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <057c40164084bfc7d77c0b2ff78d95dbf6a2a21b.1632503622.git.christophe.leroy@csgroup.eu>
References: <057c40164084bfc7d77c0b2ff78d95dbf6a2a21b.1632503622.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Activate CONFIG_STRICT_KERNEL_RWX by default
Message-Id: <163584791243.1845480.10223684012984375431.b4-ty@ellerman.id.au>
Date: Tue, 02 Nov 2021 21:11:52 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 24 Sep 2021 19:13:53 +0200, Christophe Leroy wrote:
> CONFIG_STRICT_KERNEL_RWX should be set by default on every
> architectures (See https://github.com/KSPP/linux/issues/4)
> 
> On PPC32 we have to find a compromise between performance and/or
> memory wasting and selection of strict_kernel_rwx, because it implies
> either smaller memory chunks or larger alignment between RO memory
> and RW memory.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Activate CONFIG_STRICT_KERNEL_RWX by default
      https://git.kernel.org/powerpc/c/fdacae8a84024474afff234bdd1dbe19ad597a10

cheers
