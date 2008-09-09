Return-Path: <becky.bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EAAA0DE182
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 00:22:44 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m89EMce2018616
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Sep 2008 07:22:39 -0700 (MST)
Message-Id: <52FBF0AE-7668-4684-9994-7B4818687DFF@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <48C58359.5060208@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] Pass actual dev ptr to dma_* in ucc and cpm_uart serial
Date: Tue, 9 Sep 2008 09:22:37 -0500
References: <1220901653-12812-1-git-send-email-becky.bruce@freescale.com>
	<48C58359.5060208@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 8, 2008, at 2:56 PM, Scott Wood wrote:

> Becky Bruce wrote:
>> We're currently passing NULL, and really shouldn't be.
>
> This patch doesn't change that for cpm2, since port.dev is never  
> initialized. :-P
>
>> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
>> ---
>> drivers/serial/cpm_uart/cpm_uart_cpm2.c |    6 +++---
>> drivers/serial/ucc_uart.c               |    4 ++--
>> 2 files changed, 5 insertions(+), 5 deletions(-)
>
> cpm_uart_cpm1.c has the same problem.
>
> -Scott

Good catch, thanks!  Will respin.

Cheers,
B
