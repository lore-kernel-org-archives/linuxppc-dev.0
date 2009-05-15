Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D1EC5DE076
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 14:49:37 +1000 (EST)
Message-Id: <1A2B6460-47EA-4C87-9AFB-1330C13721B6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Becky Bruce <beckyb@kernel.crashing.org>
In-Reply-To: <1242340949-16369-2-git-send-email-beckyb@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH V2 2/3] powerpc: Add support for swiotlb on 32-bit
Date: Thu, 14 May 2009 23:49:27 -0500
References: <1242340949-16369-1-git-send-email-beckyb@kernel.crashing.org>
	<1242340949-16369-2-git-send-email-beckyb@kernel.crashing.org>
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 14, 2009, at 5:42 PM, Becky Bruce wrote:

> This patch includes the basic infrastructure to use swiotlb
> bounce buffering on 32-bit powerpc.  It is not yet enabled on
> any platforms.  Probably the most interesting bit is the
> addition of addr_needs_map to dma_ops - we need this as
> a dma_op because the decision of whether or not an addr
> can be mapped by a device is device-specific.
>
> Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
> ---
> arch/powerpc/Kconfig                   |   12 ++-
> arch/powerpc/include/asm/dma-mapping.h |   11 ++
> arch/powerpc/include/asm/swiotlb.h     |   27 +++++
> arch/powerpc/kernel/Makefile           |    1 +
> arch/powerpc/kernel/dma-swiotlb.c      |  163 +++++++++++++++++++++++ 
> +++++++++
> arch/powerpc/kernel/dma.c              |    2 +-
> arch/powerpc/kernel/setup_32.c         |    6 +
> arch/powerpc/kernel/setup_64.c         |    6 +
> 8 files changed, 226 insertions(+), 2 deletions(-)
> create mode 100644 arch/powerpc/include/asm/swiotlb.h
> create mode 100644 arch/powerpc/kernel/dma-swiotlb.c

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
