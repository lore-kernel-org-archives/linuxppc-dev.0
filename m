Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 88BF2DE481
	for <linuxppc-dev@ozlabs.org>; Fri, 16 May 2008 01:16:57 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] 4xx: Workaround for CHIP_11 Errata
Date: Thu, 15 May 2008 17:16:43 +0200
References: <20080515094346.3338e1f3@zod.rchland.ibm.com>
In-Reply-To: <20080515094346.3338e1f3@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200805151716.43397.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 15 May 2008, Josh Boyer wrote:
> The PowerPC 440EP, 440GR, 440EPx, and 440GRx chips have an issue that
> causes the PLB3-to-PLB4 bridge to wait indefinitely for transaction
> requests that cross the end-of-memory-range boundary.  Since the DDR
> controller only returns the valid portion of a read request, the bridge
> will prevent other PLB masters from completing their transactions.
>
> This implements the recommended workaround for this errata for chips that
> use older versions of firmware that do not already handle it.  The last
> 4KiB of memory are hidden from the kernel to prevent the problem
> transactions from occurring.
>
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Acked-by: Stefan Roese <sr@denx.de>

Thanks.

Best regards,
Stefan
