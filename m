Return-Path: <SRS0=9r0M=JQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF43C433B4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 04:05:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78AE60E09
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 04:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78AE60E09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FNtXB1kS2z3dLQ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 14:05:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4FNtVN47Xqz3byg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Apr 2021 14:04:12 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FNtVM53xCz9vGg; Mon, 19 Apr 2021 14:04:11 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Cédric Le Goater <clg@kaod.org>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210413130352.1183267-1-clg@kaod.org>
References: <20210413130352.1183267-1-clg@kaod.org>
Subject: Re: [PATCH] powerpc/xive: Use the "ibm,
 chip-id" property only under PowerNV
Message-Id: <161880480614.1398509.4452480510086790030.b4-ty@ellerman.id.au>
Date: Mon, 19 Apr 2021 14:00:06 +1000
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

On Tue, 13 Apr 2021 15:03:52 +0200, Cédric Le Goater wrote:
> The 'chip_id' field of the XIVE CPU structure is used to choose a
> target for a source located on the same chip. For that, the XIVE
> driver queries the chip identifier from the "ibm,chip-id" property
> and compares it to a 'src_chip' field identifying the chip of a
> source. This information is only available on the PowerNV platform,
> 'src_chip' being assigned to XIVE_INVALID_CHIP_ID under pSeries.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/xive: Use the "ibm, chip-id" property only under PowerNV
      https://git.kernel.org/powerpc/c/e9e16917bc388846163b8566a298a291d71e44c9

cheers
