Return-Path: <SRS0=IsZE=EK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B556BC2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2020 13:45:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E525620870
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2020 13:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E525620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CR7Fz4zFzzDqLF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2020 00:45:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=lunn.ch
 (client-ip=185.16.172.187; helo=vps0.lunn.ch; envelope-from=andrew@lunn.ch;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lunn.ch
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CR79c3M98zDqN1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2020 00:41:56 +1100 (AEDT)
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
 (envelope-from <andrew@lunn.ch>)
 id 1kaJ2q-005DGp-9D; Wed, 04 Nov 2020 14:41:48 +0100
Date: Wed, 4 Nov 2020 14:41:48 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 10/12] net: ethernet: toshiba: ps3_gelic_net: Fix some
 kernel-doc misdemeanours
Message-ID: <20201104134148.GD933237@lunn.ch>
References: <20201104090610.1446616-1-lee.jones@linaro.org>
 <20201104090610.1446616-11-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104090610.1446616-11-lee.jones@linaro.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Geoff Levand <geoff@infradead.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Utz Bacher <utz.bacher@de.ibm.com>, Jens Osterkamp <Jens.Osterkamp@de.ibm.com>,
 kuba@kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Nov 04, 2020 at 09:06:08AM +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/net/ethernet/toshiba/ps3_gelic_net.c:1107: warning: Function parameter or member 'irq' not described in 'gelic_card_interrupt'
>  drivers/net/ethernet/toshiba/ps3_gelic_net.c:1107: warning: Function parameter or member 'ptr' not described in 'gelic_card_interrupt'
>  drivers/net/ethernet/toshiba/ps3_gelic_net.c:1407: warning: Function parameter or member 'txqueue' not described in 'gelic_net_tx_timeout'
>  drivers/net/ethernet/toshiba/ps3_gelic_net.c:1439: warning: Function parameter or member 'napi' not described in 'gelic_ether_setup_netdev_ops'
>  drivers/net/ethernet/toshiba/ps3_gelic_net.c:1639: warning: Function parameter or member 'dev' not described in 'ps3_gelic_driver_probe'
>  drivers/net/ethernet/toshiba/ps3_gelic_net.c:1795: warning: Function parameter or member 'dev' not described in 'ps3_gelic_driver_remove'
> 
> Cc: Geoff Levand <geoff@infradead.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Utz Bacher <utz.bacher@de.ibm.com>
> Cc: Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
> Cc: netdev@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
