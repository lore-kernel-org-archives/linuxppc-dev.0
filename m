Return-Path: <SRS0=Oat7=T7=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id D2FF8DE29E
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 02:43:04 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH] ibm_newemac: emac_tx_csum typo fix.patch
Date: Thu, 13 Mar 2008 16:42:47 +0100
References: <20080222192139.GA26126@ru.mvista.com>
In-Reply-To: <20080222192139.GA26126@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803131642.47920.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 22 February 2008, Valentine Barshak wrote:
> Move the "&& skb->ip_summed == CHECKSUM_PARTIAL" part out of
> emac_has_feature parameters.
>
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

Acked-by: Stefan Roese <sr@denx.de>

I think this is 2.6.25 material. I just stumbled over this problem too while 
enabling TAH on 440GX and 460EX/GT.

Thanks.

Best regards,
Stefan
