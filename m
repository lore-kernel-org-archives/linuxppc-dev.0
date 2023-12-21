Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA43C46CCD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Dec 2023 10:41:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Swn606JbXz3d8T
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Dec 2023 21:41:12 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Swn5V67FFz2xct
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2023 21:40:46 +1100 (AEDT)
Received: by gandalf.ozlabs.org (Postfix)
	id 4Swn5V5mK7z4xKZ; Thu, 21 Dec 2023 21:40:46 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Swn5V50Kqz4wcH;
	Thu, 21 Dec 2023 21:40:46 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20230920105706.853626-1-adityag@linux.ibm.com>
References: <20230920105706.853626-1-adityag@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] powerpc: add `cur_cpu_spec` symbol to vmcoreinfo
Message-Id: <170315510020.2192823.15295866344121712980.b4-ty@ellerman.id.au>
Date: Thu, 21 Dec 2023 21:38:20 +1100
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
Cc: Hari Bathini <hbathini@linux.ibm.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Sourabh Jain <sourabhjain@linux.ibm.com>, Sachin Sant <sachinp@linux.ibm.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 20 Sep 2023 16:27:05 +0530, Aditya Gupta wrote:
> Since below commit, address mapping for vmemmap has changed for Radix
> MMU, where address mapping is stored in kernel page table itself,
> instead of earlier used 'vmemmap_list'.
> 
>     commit 368a0590d954 ("powerpc/book3s64/vmemmap: switch radix to use
>     a different vmemmap handling function")
> 
> [...]

Patch 2 applied to powerpc/next.

[2/2] powerpc: add cpu_spec.cpu_features to vmcoreinfo
      https://git.kernel.org/powerpc/c/a143892cb77c5397fd4356bbef9982abe4f3c5a5

cheers
