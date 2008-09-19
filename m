Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C77D6DE0E9
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 04:35:01 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m8JIYuFk007449
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Sep 2008 11:34:56 -0700 (MST)
Message-Id: <C87AB112-43B6-4D0A-B03F-6AEDA4652AD0@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Becky Bruce <becky.bruce@freescale.com>
In-Reply-To: <1221234176-14937-1-git-send-email-becky.bruce@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH V2] Pass actual dev ptr to dma_* in ucc and cpm_uart serial
Date: Fri, 19 Sep 2008 13:34:53 -0500
References: <1221234176-14937-1-git-send-email-becky.bruce@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 12, 2008, at 10:42 AM, Becky Bruce wrote:

> We're currently passing NULL, and really shouldn't be.
>
> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
> ---
> drivers/serial/cpm_uart/cpm_uart_core.c |    3 +++
> drivers/serial/cpm_uart/cpm_uart_cpm1.c |    6 +++---
> drivers/serial/cpm_uart/cpm_uart_cpm2.c |    6 +++---
> drivers/serial/ucc_uart.c               |    4 ++--
> 4 files changed, 11 insertions(+), 8 deletions(-)

applied.

- k
