Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C756B2C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 20:49:21 +1100 (EST)
Date: Sat, 7 Dec 2013 10:49:17 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v6 09/17] serial: mpc512x: adjust for OF based clock lookup
Message-ID: <20131207104917.50f2e4e5@crub>
In-Reply-To: <1385851897-23475-10-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-10-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 30 Nov 2013 23:51:29 +0100
Gerhard Sittig <gsi@denx.de> wrote:

> after device tree based clock lookup became available, the peripheral
> driver need no longer construct clock names which include the PSC index,
> remove the "psc%d_mclk" template and unconditionally use 'mclk'
> 
> acquire and release the "ipg" clock item for register access as well
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: linux-serial@vger.kernel.org
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org> # for v4
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
> Greg, the difference since v4 of this patch is that v4 took the 'mclk'
> and 'ipg' clock items in reverse order, and thus potentially obfuscated
> the adjusted name for 'mclk' -- the updated version of the patch is
> identical in content but cleaner diff-wise
> 
> ---
>  drivers/tty/serial/mpc52xx_uart.c |   40 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 5 deletions(-)

applied to next. Thanks!

Anatolij
