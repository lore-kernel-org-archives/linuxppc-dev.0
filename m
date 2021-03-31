Return-Path: <SRS0=B9f/=I5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9FCC433C1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 01:22:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EADC0619CB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 01:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADC0619CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F97pK58HSz3hWw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Mar 2021 12:22:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F97Xw0C5Yz3cHl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Mar 2021 12:10:39 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4F97Xv1V4Fz9t14; Wed, 31 Mar 2021 12:10:35 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Bhaskar Chowdhury <unixbhaskar@gmail.com>, mikey@neuling.org,
 mpe@ellerman.id.au, jniethe5@gmail.com, christophe.leroy@csgroup.eu,
 benh@kernel.crashing.org, alistair@popple.id.au, linux-kernel@vger.kernel.org,
 paulus@samba.org
In-Reply-To: <20210224075547.763063-1-unixbhaskar@gmail.com>
References: <20210224075547.763063-1-unixbhaskar@gmail.com>
Subject: Re: [PATCH] arch: powerpc: kernel: Change droping to dropping in the
 file traps.c
Message-Id: <161715296517.226945.7681284090188409225.b4-ty@ellerman.id.au>
Date: Wed, 31 Mar 2021 12:09:25 +1100
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

On Wed, 24 Feb 2021 13:25:47 +0530, Bhaskar Chowdhury wrote:
> s/droping/dropping/

Applied to powerpc/next.

[1/1] arch: powerpc: kernel: Change droping to dropping in the file traps.c
      https://git.kernel.org/powerpc/c/5c4a4802b9ac8c1acdf2250fad3f8f2d6254f9c7

cheers
