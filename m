Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A5E0A2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Apr 2013 07:24:36 +1000 (EST)
Date: Wed, 17 Apr 2013 23:24:33 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
Subject: Re: [PATCH 2/3] serial/mpc52xx_uart: add PSC UART support for
 MPC5125 platforms.
Message-ID: <20130417232433.14671abc@crub>
In-Reply-To: <1363801314-16967-3-git-send-email-matteo.facchinetti@sirius-es.it>
References: <1363801314-16967-1-git-send-email-matteo.facchinetti@sirius-es.it>
 <1363801314-16967-3-git-send-email-matteo.facchinetti@sirius-es.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: gregkh@linuxfoundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 20 Mar 2013 18:41:53 +0100
Matteo Facchinetti <matteo.facchinetti@sirius-es.it> wrote:

> MPC5125 PSC controller has different registers than MPC5121.
> 
> This patch was originally created by Vladimir Ermakov
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2011-March/088954.html
> 
> Signed-off-by: Vladimir Ermakov <vooon341@gmail.com>
> 
> Signed-off-by: Matteo Facchinetti <matteo.facchinetti@sirius-es.it>
> ---
>  arch/powerpc/include/asm/mpc52xx_psc.h |   49 ++++
>  drivers/tty/serial/mpc52xx_uart.c      |  407 ++++++++++++++++++++++++++++----
>  2 files changed, 414 insertions(+), 42 deletions(-)

This patch should be better split to add SoC specific register accessors
first, then we can add mpc5125 changes by separate patch. I've just done
this splitting and added more descriptive commit log.

Thanks,

Anatolij
