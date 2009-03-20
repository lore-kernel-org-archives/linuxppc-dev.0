Return-Path: <ben@codiert.org>
Received: from cursor.subgra.de (cursor.subgra.de [78.46.252.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "cursor.subgra.de", Issuer "cursor.subgra.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2C912DE067
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 18:37:54 +1100 (EST)
Date: Fri, 20 Mar 2009 08:37:42 +0100
From: Benjamin Krill <ben@codiert.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 2/3] powerpc: setup default archdata for {of_}platform
	via bus_register_notifier
Message-ID: <20090320073742.GA11318@codiert.org>
References: <1237470052-4071-1-git-send-email-galak@kernel.crashing.org>
	<1237470052-4071-2-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1237470052-4071-2-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Becky Bruce <becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Kumar Gala | 2009-03-19 08:40:51 [-0500]:

>Since a number of powerpc chips are SoCs we end up having dma-able
>devices that are registered as platform or of_platform devices.  We need
>to hook the archdata to setup proper dma_ops for these devices.
>
>Rather than having to add a bus_notify to each platform we add a default
>one at the highest priority (called first) to set the default dma_ops for
>of_platform and platform devices to dma_direct_ops.  This allows platform
>code to override the ops by providing their own notifier call back.
>
>In the future to enable >4G DMA support on ppc32 we can hook swiotlb ops.
>
>Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: Benjamin Krill <ben@codiert.org>

Tested on QPACE node card.
