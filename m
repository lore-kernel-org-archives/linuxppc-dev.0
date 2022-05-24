Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211EFC433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 10:57:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L6rkZ5qwbz3dpD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 20:57:26 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L6rff6Jt3z3bw4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2022 20:54:02 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6rff5ZpYz4ySq;
 Tue, 24 May 2022 20:54:02 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220122105639.3477407-1-npiggin@gmail.com>
References: <20220122105639.3477407-1-npiggin@gmail.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: HFSCR[PREFIX] does not exist
Message-Id: <165338949317.1711920.6996336061138999333.b4-ty@ellerman.id.au>
Date: Tue, 24 May 2022 20:51:33 +1000
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
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 22 Jan 2022 20:56:39 +1000, Nicholas Piggin wrote:
> This facility is controlled by FSCR only. Reserved bits should not be
> set in the HFSCR register (although it's likely harmless as this
> position would not be re-used, and the L0 is forgiving here too).
> 
> 

Applied to powerpc/topic/ppc-kvm.

[1/1] KVM: PPC: Book3S HV: HFSCR[PREFIX] does not exist
      https://git.kernel.org/powerpc/c/861604614a94a7aabc111e4a18aaf5d56d270e8a

cheers
