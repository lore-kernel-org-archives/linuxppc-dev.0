Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FA5C4320A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 13:46:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEE686108F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 13:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EEE686108F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqTh44fWfz3d8J
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 23:46:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GqTgj57NPz306D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Aug 2021 23:45:53 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4GqTgg5Cszz9sW8; Wed, 18 Aug 2021 23:45:51 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20210812132831.233794-1-aneesh.kumar@linux.ibm.com>
References: <20210812132831.233794-1-aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] powerpc/book3s64/radix: make
 tlb_single_page_flush_ceiling a debugfs entry
Message-Id: <162929393531.3619265.6406890155529830178.b4-ty@ellerman.id.au>
Date: Wed, 18 Aug 2021 23:38:55 +1000
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

On Thu, 12 Aug 2021 18:58:30 +0530, Aneesh Kumar K.V wrote:
> Similar to x86/s390 add a debugfs file to tune tlb_single_page_flush_ceiling.
> Also add a debugfs entry for tlb_local_single_page_flush_ceiling.

Applied to powerpc/next.

[1/2] powerpc/book3s64/radix: make tlb_single_page_flush_ceiling a debugfs entry
      https://git.kernel.org/powerpc/c/3e188b1ae8807f26cc5a530a9d55f3f643fe050a
[2/2] powerpc: rename powerpc_debugfs_root to arch_debugfs_dir
      https://git.kernel.org/powerpc/c/dbf77fed8b302e87561c7c2fc06050c88f4d3120

cheers
