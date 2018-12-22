Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8672C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 11:16:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A248219FE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 11:16:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A248219FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43MNGb1Gh2zDqfk
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Dec 2018 22:16:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43MLlF6yGxzDqgB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Dec 2018 21:07:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43MLlF4jqhz9sPd;
 Sat, 22 Dec 2018 21:07:21 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Diana Craciun <diana.craciun@nxp.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/11 v2] powerpc/fsl: NXP PowerPC Spectre variant 2
 workarounds
In-Reply-To: <1545413437-5538-1-git-send-email-diana.craciun@nxp.com>
References: <1545413437-5538-1-git-send-email-diana.craciun@nxp.com>
Date: Sat, 22 Dec 2018 21:07:21 +1100
Message-ID: <87a7kxj2na.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Diana Craciun <diana.craciun@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Diana Craciun <diana.craciun@nxp.com> writes:
> Implement Spectre variant 2 workarounds for NXP PowerPC Book3E
> processors.
>
> Diana Craciun (11):
>   Add infrastructure to fixup branch predictor flush
>   Add macro to flush the branch predictor
>   Fix spectre_v2 mitigations reporting
>   Emulate SPRN_BUCSR register
>   Add nospectre_v2 command line argument
>   Flush the branch predictor at each kernel entry (64bit)
>   Flush the branch predictor at each kernel entry (32 bit)
>   Flush branch predictor when entering KVM
>   Enable runtime patching if nospectre_v2 boot arg is used
>   Update Spectre v2 reporting
>   Add FSL_PPC_BOOK3E as supported arch for nospectre_v2 boot arg

Hi Diana,

Sorry I already applied v1 a few days ago.

I realise I didn't send out the "applied to next" emails, so my fault
for that.

Can you send me an incremental patch for the changes in v2? Thanks.

cheers
