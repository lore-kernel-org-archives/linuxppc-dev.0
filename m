Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45AAC10F1A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 May 2024 14:42:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VYgwP3Qhcz3cW8
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 May 2024 00:42:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VYgvx1S9Yz3cCM
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 May 2024 00:41:49 +1000 (AEST)
Received: by gandalf.ozlabs.org (Postfix)
	id 4VYgvs5jNNz4x1Q; Wed,  8 May 2024 00:41:45 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VYgvs2zlrz4x1C;
	Wed,  8 May 2024 00:41:45 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20240502182040.774759-1-sourabhjain@linux.ibm.com>
References: <20240502182040.774759-1-sourabhjain@linux.ibm.com>
Subject: Re: [PATCH] powerpc/crash: remove unnecessary NULL check before kvfree()
Message-Id: <171509287315.62008.11001695873453777968.b4-ty@ellerman.id.au>
Date: Wed, 08 May 2024 00:41:13 +1000
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, kernel test robot <lkp@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 02 May 2024 23:50:40 +0530, Sourabh Jain wrote:
> Fix the following coccicheck build warning:
> 
> arch/powerpc/kexec/crash.c:488:2-8: WARNING: NULL check before some
> freeing functions is not needed.
> 
> 

Applied to powerpc/topic/kdump-hotplug.

[1/1] powerpc/crash: remove unnecessary NULL check before kvfree()
      https://git.kernel.org/powerpc/c/9803af291162dbca4b9773586a3f5c392f0dd974

cheers
