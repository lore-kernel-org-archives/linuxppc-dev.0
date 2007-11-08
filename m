Return-Path: <SRS0=zNDV=QB=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 9D0F5DDE03
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2007 19:49:36 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/6] ibm_newemac: Workaround reset timeout when no link
Date: Thu, 8 Nov 2007 09:44:47 +0100
References: <20071108080731.2E40DDDDFC@ozlabs.org>
In-Reply-To: <20071108080731.2E40DDDDFC@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200711080944.47567.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 08 November 2007, Benjamin Herrenschmidt wrote:
> With some PHYs, when the link goes away, the EMAC reset fails due
> to the loss of the RX clock I believe.
>
> The old EMAC driver worked around that using some internal chip-specific
> clock force bits that are different on various 44x implementations.
>
> This is an attempt at doing it differently, by avoiding the reset when
> there is no link, but forcing loopback mode instead. It seems to work
> on my Taishan 440GX based board so far.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Stefan Roese <sr@denx.de>

Best regards,
Stefan
