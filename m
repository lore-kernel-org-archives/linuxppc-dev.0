Return-Path: <SRS0=9r0M=JQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C0FC433B4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 04:13:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDDC4610A1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 04:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDDC4610A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FNthj3jCpz3gWS
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 14:13:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FNtW742k3z3ckB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Apr 2021 14:04:51 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FNtVq4zx6z9vHr; Mon, 19 Apr 2021 14:04:35 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: npiggin@gmail.com, mahesh@linux.ibm.com, alistair@popple.id.au,
 ravi.bangoria@linux.ibm.com, rppt@kernel.org, aneesh.kumar@linux.ibm.com,
 benh@kernel.crashing.org, christophe.leroy@csgroup.eu, peterz@infradead.org,
 sourabhjain@linux.ibm.com, haren@linux.ibm.com, mpe@ellerman.id.au,
 aik@ozlabs.ru, mikey@neuling.org, hbathini@linux.ibm.com, jniethe5@gmail.com,
 atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com, maddy@linux.ibm.com,
 paulus@samba.org, Xiongwei Song <sxwjean@me.com>, kan.liang@linux.intel.com,
 leobras.c@gmail.com, akpm@linux-foundation.org, nathan@kernel.org,
 walken@google.com
In-Reply-To: <1618398033-13025-1-git-send-email-sxwjean@me.com>
References: <1618398033-13025-1-git-send-email-sxwjean@me.com>
Subject: Re: [PATCH v5] powerpc/traps: Enhance readability for trap types
Message-Id: <161880480749.1398509.13854338250258784964.b4-ty@ellerman.id.au>
Date: Mon, 19 Apr 2021 14:00:07 +1000
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

On Wed, 14 Apr 2021 19:00:33 +0800, Xiongwei Song wrote:
> Define macros to list ppc interrupt types in interttupt.h, replace the
> reference of the trap hex values with these macros.
> 
> Referred the hex numbers in arch/powerpc/kernel/exceptions-64e.S,
> arch/powerpc/kernel/exceptions-64s.S, arch/powerpc/kernel/head_*.S,
> arch/powerpc/kernel/head_booke.h and arch/powerpc/include/asm/kvm_asm.h.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/traps: Enhance readability for trap types
      https://git.kernel.org/powerpc/c/7153d4bf0b373428d0393c001019da4d0483fddb

cheers
