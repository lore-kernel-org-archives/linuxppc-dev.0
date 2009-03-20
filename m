Return-Path: <ben@codiert.org>
Received: from cursor.subgra.de (cursor.subgra.de [78.46.252.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "cursor.subgra.de", Issuer "cursor.subgra.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5C293DDDFA
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 18:37:45 +1100 (EST)
Date: Fri, 20 Mar 2009 08:37:26 +0100
From: Benjamin Krill <ben@codiert.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 1/3] powerpc/pci: Default to dma_direct_ops for pci
	dma_ops
Message-ID: <20090320073726.GZ11318@codiert.org>
References: <1237470052-4071-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1237470052-4071-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Becky Bruce <becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Kumar Gala | 2009-03-19 08:40:50 [-0500]:

>This will allow us to remove the ppc32 specific checks in get_dma_ops()
>that defaults to dma_direct_ops if the archdata is NULL.  We really
>should always have archdata set to something going forward.
>
>Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: Benjamin Krill <ben@codiert.org>

Tested on QPACE node card.
