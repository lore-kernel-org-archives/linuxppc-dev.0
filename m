Return-Path: <SRS0=+jbz=L6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B935C07E96
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Jul 2021 10:53:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEFB8619BE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Jul 2021 10:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFB8619BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GJzts48FLz309Z
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Jul 2021 20:53:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GJzsy2VNgz300x
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jul 2021 20:52:54 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4GJzsy1QGmz9sXV; Tue,  6 Jul 2021 20:52:54 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cover.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] powerpc/bpf: Fix issue with atomic ops
Message-Id: <162556873716.460578.10069325708926626758.b4-ty@ellerman.id.au>
Date: Tue, 06 Jul 2021 20:52:17 +1000
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
Cc: Brendan Jackman <jackmanb@google.com>, Jiri Olsa <jolsa@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 1 Jul 2021 20:38:57 +0530, Naveen N. Rao wrote:
> The first patch fixes an issue that causes a soft lockup on ppc64 with
> the BPF_ATOMIC bounds propagation verifier test. The second one updates
> ppc32 JIT to reject atomic operations properly.
> 
> - Naveen
> 
> Naveen N. Rao (2):
>   powerpc/bpf: Fix detecting BPF atomic instructions
>   powerpc/bpf: Reject atomic ops in ppc32 JIT
> 
> [...]

Applied to powerpc/fixes.

[1/2] powerpc/bpf: Fix detecting BPF atomic instructions
      https://git.kernel.org/powerpc/c/419ac821766cbdb9fd85872bb3f1a589df05c94c
[2/2] powerpc/bpf: Reject atomic ops in ppc32 JIT
      https://git.kernel.org/powerpc/c/307e5042c7bdae15308ef2e9b848833b84122eb0

cheers
