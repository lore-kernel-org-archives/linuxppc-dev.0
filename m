Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id 2FBA4DDED1
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 23:51:09 +1000 (EST)
Message-ID: <49EDCB04.9030800@scram.de>
Date: Tue, 21 Apr 2009 15:32:52 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Mark Ware <mware@elphinstone.net>
Subject: Re: [PATCH] i2c-cpm: Pass dev ptr to dma_*_coherent rather than NULL
References: <49EDC0BE.7040505@elphinstone.net>
In-Reply-To: <49EDC0BE.7040505@elphinstone.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark Ware schrieb:
> Recent DMA changes result in a BUG() when NULL is passed to
> dma_alloc_coherent in place of a device.

This seems to have happened in 4ae0ff606e848fa4957ebf8f97e5db5fdeec27be.

> Signed-off-by: Mark Ware <mware@elphinstone.net>
Acked-by: Jochen Friedrich <jochen@scram.de>

Thanks,
Jochen
