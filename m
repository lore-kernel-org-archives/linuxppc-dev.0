Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 69F9BDE65C
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jun 2008 00:35:45 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PowerPC 44x: small warp-nand fix
Date: Thu, 5 Jun 2008 16:28:18 +0200
References: <20080605133638.GA18021@ru.mvista.com>
In-Reply-To: <20080605133638.GA18021@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806051628.18698.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, smaclennan@pikatech.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 05 June 2008, Valentine Barshak wrote:
> The "ndfc-chip" device doesn't need any resources. All resources
> are handled by the "ndfc-nand" device. Registering the same memory
> resource twice causes "cat /proc/iomem" to go into an infinite loop
> displaying NDFC memory addresses.
>
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

Acked-by: Stefan Roese <sr@denx.de>

Best regards,
Stefan
