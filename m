Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C266DC433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 10:54:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L6rgj1F9Xz3dq8
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 20:54:57 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L6rfY31x9z3bXn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2022 20:53:57 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6rfT4cBTz4xYY;
 Tue, 24 May 2022 20:53:53 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220506073737.3823347-1-aik@ozlabs.ru>
References: <20220506073737.3823347-1-aik@ozlabs.ru>
Subject: Re: [PATCH kernel] KVM: PPC: Book3s: PR: Enable default TCE hypercalls
Message-Id: <165338951230.1711920.13309403360351768244.b4-ty@ellerman.id.au>
Date: Tue, 24 May 2022 20:51:52 +1000
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
Cc: kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 6 May 2022 17:37:37 +1000, Alexey Kardashevskiy wrote:
> When KVM_CAP_PPC_ENABLE_HCALL was introduced, H_GET_TCE and H_PUT_TCE
> were already implemented and enabled by default; however H_GET_TCE
> was missed out on PR KVM (probably because the handler was in
> the real mode code at the time).
> 
> This enables H_GET_TCE by default. While at this, this wraps
> the checks in ifdef CONFIG_SPAPR_TCE_IOMMU just like HV KVM.
> 
> [...]

Applied to powerpc/topic/ppc-kvm.

[1/1] KVM: PPC: Book3s: PR: Enable default TCE hypercalls
      https://git.kernel.org/powerpc/c/29592181c5496d93697a23e6dbb9d7cc317ff5ee

cheers
