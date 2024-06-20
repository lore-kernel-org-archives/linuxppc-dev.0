Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D94C27C79
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2024 14:28:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W4jXm6RPNz3cl9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jun 2024 00:28:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W4jXJ5HZXz3bhD
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2024 00:28:32 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W4jX82DTxz4wb7;
	Fri, 21 Jun 2024 00:28:24 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20240510102235.2269496-1-sourabhjain@linux.ibm.com>
References: <20240510102235.2269496-1-sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] powerpc: kexec fixes
Message-Id: <171888775128.806750.5842115931116050967.b4-ty@ellerman.id.au>
Date: Thu, 20 Jun 2024 22:49:11 +1000
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
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>, Mahesh Salgaonkar <mahesh@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 10 May 2024 15:52:33 +0530, Sourabh Jain wrote:
> Patch series fixes two kexec issues.
> 
> 01/02: Update extra size calculation for kexec FDT to avoid kexec load
> failure due to FDT_ERR_NOSPACE while including CPU nodes added post
> boot and reserved memory ranges.
> 
> 02/02: Fix update_cpus_node/core_64.c function to include missing device
> nodes under /cpus node with device_type != "cpu".
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/kexec_file: fix extra size calculation for kexec FDT
      https://git.kernel.org/powerpc/c/0d3ff067331ef84e7e7f49537d768881042ed5ba
[2/2] powerpc/kexec_file: fix cpus node update to FDT
      https://git.kernel.org/powerpc/c/932bed41217059638c78a75411b7893b121d2162

cheers
