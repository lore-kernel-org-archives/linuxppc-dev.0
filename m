Return-Path: <SRS0=B9f/=I5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457A1C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 01:22:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBDBA619CB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 01:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDBA619CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F97pg4BRGz3hbK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 12:22:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F97Xw107Zz3cHw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Mar 2021 12:10:40 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4F97Xv5695z9sj0; Wed, 31 Mar 2021 12:10:36 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>,
 rppt@kernel.org, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
 benh@kernel.crashing.org, linux-kernel@vger.kernel.org, oss@buserror.net,
 paulus@samba.org, akpm@linux-foundation.org
In-Reply-To: <20210314220436.3417083-1-unixbhaskar@gmail.com>
References: <20210314220436.3417083-1-unixbhaskar@gmail.com>
Subject: Re: [PATCH] powerpc: kernel: Trivial spelling fixes throughout the
 file head_fsl_booke.S
Message-Id: <161715297716.226945.9682163470122144049.b4-ty@ellerman.id.au>
Date: Wed, 31 Mar 2021 12:09:37 +1100
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
Cc: rdunlap@infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 15 Mar 2021 03:34:36 +0530, Bhaskar Chowdhury wrote:
> Trivial spelling fixes throughout the file.

Applied to powerpc/next.

[1/1] powerpc: kernel: Trivial spelling fixes throughout the file head_fsl_booke.S
      https://git.kernel.org/powerpc/c/f239873fcd953557ba9a9781d10ca95c0594e2b3

cheers
