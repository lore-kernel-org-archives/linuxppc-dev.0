Return-Path: <SRS0=IADO=FO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1759C4361B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 14:45:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEDA622D74
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Dec 2020 14:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDA622D74
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CsGtg1V45zDr0r
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Dec 2020 01:45:47 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CsBYC6wkyzDqlD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Dec 2020 22:30:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CsBYC1lgrz9shk; Thu, 10 Dec 2020 22:30:22 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200409061337.9187-1-oohall@gmail.com>
References: <20200409061337.9187-1-oohall@gmail.com>
Subject: Re: [PATCH] powernv/pci: Print an error when device enable is blocked
Message-Id: <160756607213.1313423.1925824612988125837.b4-ty@ellerman.id.au>
Date: Thu, 10 Dec 2020 22:30:22 +1100 (AEDT)
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

On Thu, 9 Apr 2020 16:13:37 +1000, Oliver O'Halloran wrote:
> If the platform decides to block enabling the device nothing is printed
> currently. This can lead to some confusion since the dmesg output will
> usually print an error with no context e.g.
> 
> 	e1000e: probe of 0022:01:00.0 failed with error -22
> 
> This shouldn't be spammy since pci_enable_device() already prints a
> messages when it succeeds.

Applied to powerpc/next.

[1/1] powernv/pci: Print an error when device enable is blocked
      https://git.kernel.org/powerpc/c/6c58b1b41b19c00099e4771ee55e21eb9aa245c1

cheers
