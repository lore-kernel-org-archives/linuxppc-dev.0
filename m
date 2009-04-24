Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.182])
	by ozlabs.org (Postfix) with ESMTP id 989B4DDE0E
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 14:23:30 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] PowerPC 44x: ibm4xx_denali_fixup_memsize fix
Date: Fri, 24 Apr 2009 06:23:16 +0200
References: <20090423205506.GA2962@ru.mvista.com>
In-Reply-To: <20090423205506.GA2962@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200904240623.16639.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 23 April 2009, Valentine Barshak wrote:
> Some U-Boot versions incorrectly set the number of chipselects to two
> for Sequoia/Rainier boards while they only have one chipselect hardwired.
> This patch adds a workaround for this, hardcoding the number of chipselects
> to one for sequioa/rainer board models and reading the actual value from
> the memory controller register DDR0_10 otherwise.
> It also fixes another error in the way ibm4xx_denali_fixup_memsize
> calculates memory size. When testing the DDR_REDUC bit, the polarity is
> backwards.  A "1" implies 32-bit wide memory while a "0" implies 64-bit
> wide memory.
>
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> Signed-off-by: Steven A. Falco <sfalco@harris.com>

Acked-by: Stefan Roese <sr@denx.de>

Thanks.

Best regards,
Stefan
