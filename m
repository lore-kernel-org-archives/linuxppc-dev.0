Return-Path: <SRS0=geFq=M2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DFAC4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Aug 2021 10:21:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41BBA60ED6
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Aug 2021 10:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 41BBA60ED6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gf9rR5KnVz3cQf
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Aug 2021 20:21:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gf9r25nq8z302G
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Aug 2021 20:20:49 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 4Gf9r11l0Mz9sRK; Tue,  3 Aug 2021 20:20:49 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Gf9r119csz9sSs; Tue,  3 Aug 2021 20:20:48 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <162626687834.155313.4692863392927831843.stgit@hbathini-workstation.ibm.com>
References: <162626687834.155313.4692863392927831843.stgit@hbathini-workstation.ibm.com>
Subject: Re: [PATCH] powerpc/kexec: blacklist functions called in real mode
 for kprobe
Message-Id: <162798602769.163057.769381931145316395.b4-ty@ellerman.id.au>
Date: Tue, 03 Aug 2021 20:20:27 +1000
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
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 14 Jul 2021 18:17:58 +0530, Hari Bathini wrote:
> As kprobe does not handle events happening in real mode, blacklist the
> functions that only get called in real mode or in kexec sequence with
> MMU turned off.

Applied to powerpc/next.

[1/1] powerpc/kexec: blacklist functions called in real mode for kprobe
      https://git.kernel.org/powerpc/c/8119cefd9a29b71997e62b762932d23499ba4896

cheers
