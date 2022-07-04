Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E7DCCA47C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Jul 2022 11:36:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lc3fF4Sgbz3c4k
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Jul 2022 21:36:05 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lc3dr3wnlz304x
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2022 21:35:44 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lc3dn5Jtbz4xRC;
	Mon,  4 Jul 2022 21:35:41 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220601040117.1467710-1-aik@ozlabs.ru>
References: <20220601040117.1467710-1-aik@ozlabs.ru>
Subject: Re: [PATCH kernel] powerpc/pseries/iommu: Print ibm,query-pe-dma-windows parameters
Message-Id: <165693444092.9954.3028144827396138064.b4-ty@ellerman.id.au>
Date: Mon, 04 Jul 2022 21:34:00 +1000
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
Cc: Frederic Barrat <fbarrat@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 1 Jun 2022 14:01:17 +1000, Alexey Kardashevskiy wrote:
> PowerVM has a stricter policy about allocating TCEs for LPARs and
> often there is not enough TCEs for 1:1 mapping, this adds the supported
> numbers into dev_info() to help analyzing bugreports.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/pseries/iommu: Print ibm,query-pe-dma-windows parameters
      https://git.kernel.org/powerpc/c/a28a2eff1e0ff684f51b3dc6371ff5b651a063d4

cheers
