Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADC9C4345F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2024 08:19:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VNJ7v2s7Cz3dlY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Apr 2024 18:19:39 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VNJ6g2v21z2xSN
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Apr 2024 18:18:35 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNJ6d34MFz4x0K;
	Mon, 22 Apr 2024 18:18:33 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Rob Herring <robh@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240313135645.2066362-1-andriy.shevchenko@linux.intel.com>
References: <20240313135645.2066362-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] powerpc/52xx: Replace of_gpio.h by proper one
Message-Id: <171377378380.1025456.7660942361911740845.b4-ty@ellerman.id.au>
Date: Mon, 22 Apr 2024 18:16:23 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nicholas Piggin <npiggin@gmail.com>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anatolij Gustschin <agust@denx.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 13 Mar 2024 15:56:45 +0200, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it directly, replace it
> with what is really being used.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/52xx: Replace of_gpio.h by proper one
      https://git.kernel.org/powerpc/c/676abf7c39267080ab81597c6d4f372a10c0fc21

cheers
