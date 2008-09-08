Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 31299DDED1
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 05:57:26 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m88JvMbb015992
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Sep 2008 12:57:22 -0700 (MST)
Message-ID: <48C58359.5060208@freescale.com>
Date: Mon, 08 Sep 2008 14:56:09 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH] Pass actual dev ptr to dma_* in ucc and cpm_uart serial
References: <1220901653-12812-1-git-send-email-becky.bruce@freescale.com>
In-Reply-To: <1220901653-12812-1-git-send-email-becky.bruce@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Becky Bruce wrote:
> We're currently passing NULL, and really shouldn't be.

This patch doesn't change that for cpm2, since port.dev is never 
initialized. :-P

> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
> ---
>  drivers/serial/cpm_uart/cpm_uart_cpm2.c |    6 +++---
>  drivers/serial/ucc_uart.c               |    4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)

cpm_uart_cpm1.c has the same problem.

-Scott
