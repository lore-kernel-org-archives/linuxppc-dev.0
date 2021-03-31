Return-Path: <SRS0=B9f/=I5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD47CC433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 01:13:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F209619CA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 01:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F209619CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F97c802gqz3dpJ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 12:13:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F97XQ224Pz3c2B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Mar 2021 12:10:14 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4F97XQ0j7hz9shx; Wed, 31 Mar 2021 12:10:14 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <955248c6423cb068c5965923121ba31d4dd2fdde.1615881400.git.christophe.leroy@csgroup.eu>
References: <955248c6423cb068c5965923121ba31d4dd2fdde.1615881400.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 1/4] powerpc: Activate HAVE_RELIABLE_STACKTRACE for all
Message-Id: <161715297988.226945.14373125287629011053.b4-ty@ellerman.id.au>
Date: Wed, 31 Mar 2021 12:09:39 +1100
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

On Tue, 16 Mar 2021 07:57:13 +0000 (UTC), Christophe Leroy wrote:
> CONFIG_HAVE_RELIABLE_STACKTRACE is applicable to all, no
> reason to limit it to book3s/64le

Applied to powerpc/next.

[1/4] powerpc: Activate HAVE_RELIABLE_STACKTRACE for all
      https://git.kernel.org/powerpc/c/accdd093f260bc8c8a8f580ee48e49ad5c5f91b2
[2/4] powerpc: Rename 'tsk' parameter into 'task'
      https://git.kernel.org/powerpc/c/826a307b0a11e605b4be0b2727550b510c4a88cd
[3/4] powerpc: Convert stacktrace to generic ARCH_STACKWALK
      https://git.kernel.org/powerpc/c/a1cdef04f22dd5ad9e1ccf5d05a549c697b7f52d
[4/4] powerpc: Fix arch_stack_walk() to have running function as first entry
      https://git.kernel.org/powerpc/c/a2308836880bf1501ff9373c611dc2970247d42b

cheers
