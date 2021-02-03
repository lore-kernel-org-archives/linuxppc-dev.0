Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7FAC433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 13:01:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 774A964D9D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 13:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 774A964D9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DW1yT03LqzF3fW
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Feb 2021 00:01:05 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DW09q0rbKzDwtW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2021 22:40:46 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DW09n1w10z9t0k; Wed,  3 Feb 2021 22:40:44 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Oliver O'Halloran <oohall@gmail.com>
In-Reply-To: <20201103051512.919333-1-oohall@gmail.com>
References: <20201103051512.919333-1-oohall@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/eeh: Rework pci_dev lookup in debugfs
 attributes
Message-Id: <161235200723.1516112.9739316809126948645.b4-ty@ellerman.id.au>
Date: Wed,  3 Feb 2021 22:40:44 +1100 (AEDT)
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

On Tue, 3 Nov 2020 16:15:11 +1100, Oliver O'Halloran wrote:
> Pull the string -> pci_dev lookup stuff into a helper function. No functional change.

Applied to powerpc/next.

[1/2] powerpc/eeh: Rework pci_dev lookup in debugfs attributes
      https://git.kernel.org/powerpc/c/b5e904b83067bbbd7dc83ea3734c119f8796d79f
[2/2] powerpc/eeh: Add a debugfs interface to check if a driver supports recovery
      https://git.kernel.org/powerpc/c/9e857416833d9701a406ecd6f03a695405ada5e6

cheers
