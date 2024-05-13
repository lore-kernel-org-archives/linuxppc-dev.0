Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA559C25B75
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 May 2024 13:23:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VdKtz2Xqdz3fmw
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 May 2024 23:23:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VdKsm5QHPz3cPh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2024 23:22:36 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VdKsd0G8Nz4x11;
	Mon, 13 May 2024 23:22:29 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20240509115755.519982-1-hbathini@linux.ibm.com>
References: <20240509115755.519982-1-hbathini@linux.ibm.com>
Subject: Re: [PATCH v2 0/3] powerpc/fadump: pass additional args to dump capture kernel
Message-Id: <171560652133.57553.7198982906701948814.b4-ty@ellerman.id.au>
Date: Mon, 13 May 2024 23:22:01 +1000
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 09 May 2024 17:27:52 +0530, Hari Bathini wrote:
> While fadump is a more reliable alternative to kdump dump capturing
> method, it doesn't support passing additional parameters. Having
> such support is desirable for two major reasons:
> 
>   1. It helps minimize the memory consumption of fadump dump capture
>      kernel by disabling features that consume considerable amount of
>      memory but have little significance for dump capture environment
>      (eg. numa, cma, cgroup, etc.)
>    2. It helps disable such features/components in dump capture kernel
>       that are unstable and/or are being debugged.
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/pseries/fadump: add support for multiple boot memory regions
      https://git.kernel.org/powerpc/c/78d5cc15fb7d1b2683f0baf418a9a870c02319fb
[2/3] powerpc/fadump: setup additional parameters for dump capture kernel
      https://git.kernel.org/powerpc/c/683eab94da75bcf55a9c65e0c31d0529edebe86d
[3/3] powerpc/fadump: pass additional parameters when fadump is active
      https://git.kernel.org/powerpc/c/3416c9daa6b13c0e2a656d4e2dee8de95f9a38cf

cheers
