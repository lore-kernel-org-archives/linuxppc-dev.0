Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDCEC7619A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Apr 2023 00:37:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PsMz51MWYz3fkp
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Apr 2023 10:37:37 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PsMxc2mtSz3bP1
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2023 10:36:20 +1000 (AEST)
Received: by gandalf.ozlabs.org (Postfix)
	id 4PsMxc2Jhqz4xFL; Thu,  6 Apr 2023 10:36:20 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4PsMxc1WWbz4xDt;
	Thu,  6 Apr 2023 10:36:20 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
In-Reply-To: <20230330103224.3589928-1-npiggin@gmail.com>
References: <20230330103224.3589928-1-npiggin@gmail.com>
Subject: Re: [PATCH v2 0/2] KVM: PPC: Book3S HV: Injected interrupt SRR1
Message-Id: <168074126988.3672916.619022230380161209.b4-ty@ellerman.id.au>
Date: Thu, 06 Apr 2023 10:34:29 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Cc: Michael Neuling <mikey@neuling.org>, kvm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 30 Mar 2023 20:32:22 +1000, Nicholas Piggin wrote:
> I missed this in my earlier review and testing, but I think we need
> these in the prefix instruction enablement series before the final patch
> that enables HFSCR[PREFIX] for guests.
> 
> Thanks,
> Nick
> 
> [...]

Applied to powerpc/topic/ppc-kvm.

[1/2] KVM: PPC: Permit SRR1 flags in more injected interrupt types
      https://git.kernel.org/powerpc/c/460ba21d83fef766a5d34260e464c9ab8f10aa05
[2/2] KVM: PPC: Book3S HV: Set SRR1[PREFIX] bit on injected interrupts
      https://git.kernel.org/powerpc/c/6cd5c1db9983600f1848822e86e4906377b4a899

cheers
