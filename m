Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7A5C433FE
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:49:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED0DC60295
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ED0DC60295
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hk7VD4mNvz3gJG
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 22:49:24 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hk7G103Rwz2ymF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Nov 2021 22:38:49 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7G06CDYz4xdb;
 Tue,  2 Nov 2021 22:38:48 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nathan Lynch <nathanl@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20211020194703.2613093-1-nathanl@linux.ibm.com>
References: <20211020194703.2613093-1-nathanl@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/pseries/mobility: ignore ibm,
 platform-facilities updates
Message-Id: <163584791481.1845480.2183906050275560636.b4-ty@ellerman.id.au>
Date: Tue, 02 Nov 2021 21:11:54 +1100
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
Cc: tyreld@linux.ibm.com, cheloha@linux.ibm.com, ldufour@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 20 Oct 2021 14:47:03 -0500, Nathan Lynch wrote:
> On VMs with NX encryption, compression, and/or RNG offload, these
> capabilities are described by nodes in the ibm,platform-facilities device
> tree hierarchy:
> 
>   $ tree -d /sys/firmware/devicetree/base/ibm,platform-facilities/
>   /sys/firmware/devicetree/base/ibm,platform-facilities/
>   ├── ibm,compression-v1
>   ├── ibm,random-v1
>   └── ibm,sym-encryption-v1
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries/mobility: ignore ibm, platform-facilities updates
      https://git.kernel.org/powerpc/c/319fa1a52e438a6e028329187783a25ad498c4e6

cheers
