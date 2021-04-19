Return-Path: <SRS0=9r0M=JQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F027BC433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 04:12:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A4C261106
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 04:12:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4C261106
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FNth02Pg7z3gKY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 14:12:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FNtW72SWDz3clG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Apr 2021 14:04:51 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FNtVn0vzJz9vGd; Mon, 19 Apr 2021 14:04:32 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, ellerman@au1.ibm.com,
 linux-nvdimm@lists.01.org, sbhat@linux.vnet.ibm.com,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>, kvm-ppc@vger.kernel.org,
 aneesh.kumar@linux.ibm.com
In-Reply-To: <161703936121.36.7260632399582101498.stgit@e1fbed493c87>
References: <161703936121.36.7260632399582101498.stgit@e1fbed493c87>
Subject: Re: [PATCH v3] powerpc/papr_scm: Implement support for H_SCM_FLUSH
 hcall
Message-Id: <161880478871.1398509.15555293343691434743.b4-ty@ellerman.id.au>
Date: Mon, 19 Apr 2021 13:59:48 +1000
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
Cc: vaibhav@linux.ibm.com, linux-doc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 29 Mar 2021 13:36:43 -0400, Shivaprasad G Bhat wrote:
> Add support for ND_REGION_ASYNC capability if the device tree
> indicates 'ibm,hcall-flush-required' property in the NVDIMM node.
> Flush is done by issuing H_SCM_FLUSH hcall to the hypervisor.
> 
> If the flush request failed, the hypervisor is expected to
> to reflect the problem in the subsequent nvdimm H_SCM_HEALTH call.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/papr_scm: Implement support for H_SCM_FLUSH hcall
      https://git.kernel.org/powerpc/c/75b7c05ebf902632f7f540c3eb0a8945c2d74aab

cheers
