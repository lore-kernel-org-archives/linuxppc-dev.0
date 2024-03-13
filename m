Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501ECC54E58
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2024 13:31:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tvrxp6vrHz3wBy
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 Mar 2024 00:31:10 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tvrt25sfrz2ykt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2024 00:27:54 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tvrt255Qnz4x1x;
	Thu, 14 Mar 2024 00:27:54 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20240305123410.3306253-1-mpe@ellerman.id.au>
References: <20240305123410.3306253-1-mpe@ellerman.id.au>
Subject: Re: [PATCH 1/3] powerpc/embedded6xx: Fix no previous prototype for avr_uart_send() etc.
Message-Id: <171033598346.517247.17061248485657605266.b4-ty@ellerman.id.au>
Date: Thu, 14 Mar 2024 00:19:43 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 05 Mar 2024 23:34:08 +1100, Michael Ellerman wrote:
> Move the prototypes into mpc10x.h which is included by all the relevant
> C files, fixes:
> 
>   arch/powerpc/platforms/embedded6xx/ls_uart.c:59:6: error: no previous prototype for 'avr_uart_configure'
>   arch/powerpc/platforms/embedded6xx/ls_uart.c:82:6: error: no previous prototype for 'avr_uart_send'
> 
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/embedded6xx: Fix no previous prototype for avr_uart_send() etc.
      https://git.kernel.org/powerpc/c/20933531be0577cdd782216858c26150dbc7936f
[2/3] powerpc/amigaone: Make several functions static
      https://git.kernel.org/powerpc/c/e8b1ce0e287fd1493334f3435d763aecd517afd9
[3/3] powerpc/4xx: Fix warp_gpio_leds build failure
      https://git.kernel.org/powerpc/c/5b9e00a6004cf837c43fdb8d5290df619de78024

cheers
