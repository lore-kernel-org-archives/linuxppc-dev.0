Return-Path: <ben@codiert.org>
Received: from cursor.subgra.de (cursor.subgra.de [78.46.252.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "cursor.subgra.de", Issuer "cursor.subgra.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0FC0BDE292
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 18:38:13 +1100 (EST)
Date: Fri, 20 Mar 2009 08:38:02 +0100
From: Benjamin Krill <ben@codiert.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2 3/3] powerpc: expect all devices calling dma ops to
	have archdata set
Message-ID: <20090320073802.GB11318@codiert.org>
References: <1237470052-4071-1-git-send-email-galak@kernel.crashing.org>
	<1237470052-4071-2-git-send-email-galak@kernel.crashing.org>
	<1237470052-4071-3-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1237470052-4071-3-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Becky Bruce <becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Kumar Gala | 2009-03-19 08:40:52 [-0500]:

>Now that we set archdata for of_platform and platform devices via
>platform_notify() we no longer need to special case having a NULL device
>pointer or NULL archdata.  It should be a driver error if this condition
>shows up and the driver should be fixed.
>
>Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: Benjamin Krill <ben@codiert.org>

Tested on QPACE node card.
