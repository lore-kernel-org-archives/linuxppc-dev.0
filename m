Return-Path: <ben@codiert.org>
Received: from cursor.subgra.de (cursor.subgra.de [78.46.252.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "cursor.subgra.de", Issuer "cursor.subgra.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8E9CEDDEE2
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 09:06:42 +1100 (EST)
Date: Thu, 19 Feb 2009 23:08:20 +0100
From: Benjamin Krill <ben@codiert.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powerpc: setup archdata for {of_}platform via a
	single platform_notify
Message-ID: <20090219220820.GH12204@codiert.org>
References: <1235076557-24464-1-git-send-email-galak@kernel.crashing.org>
	<1235076557-24464-2-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1235076557-24464-2-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Kumar Gala | 2009-02-19 14:49:16 [-0600]:

>Since a number of powerpc chips are SoCs we end up having dma-able
>devices that are registered as platform or of_platform devices.  We need
>to hook the archdata to setup proper dma_ops for these devices.
>
>In the short term the majority of these devices only need the
>direct_dma_ops as the platforms don't have any IOMMUs.
>
>In the future to enable >4G DMA support on ppc32 we can hook swiotlb ops.
>
>Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: Benjamin Krill <ben@codiert.org>
