Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6817DC433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:42:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C03B60EBB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0C03B60EBB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hk7Kk5DtSz3f2j
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 22:42:02 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hk7Ff6Cmbz2yQw
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Nov 2021 22:38:30 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7Ff57Nhz4xct;
 Tue,  2 Nov 2021 22:38:30 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <c3f9ec9950394ef939014f7934268e6ee30ca04f.1630398566.git.christophe.leroy@csgroup.eu>
References: <c3f9ec9950394ef939014f7934268e6ee30ca04f.1630398566.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/time: Remove generic_suspend_{dis/en}able_irqs()
Message-Id: <163584790697.1845480.13077572464095477965.b4-ty@ellerman.id.au>
Date: Tue, 02 Nov 2021 21:11:46 +1100
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

On Tue, 31 Aug 2021 08:29:35 +0000 (UTC), Christophe Leroy wrote:
> Commit d75d68cfef49 ("powerpc: Clean up obsolete code relating to
> decrementer and timebase") made generic_suspend_enable_irqs() and
> generic_suspend_disable_irqs() static.
> 
> Fold them into their only caller.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/time: Remove generic_suspend_{dis/en}able_irqs()
      https://git.kernel.org/powerpc/c/e606a2f46c72ec399bb9be194f6df95ea8ec3b1b

cheers
