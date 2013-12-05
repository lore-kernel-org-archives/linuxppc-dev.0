Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 619AE2C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 13:52:49 +1100 (EST)
Date: Wed, 4 Dec 2013 16:55:53 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v6 09/17] serial: mpc512x: adjust for OF based clock lookup
Message-ID: <20131205005553.GC21377@kroah.com>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-10-git-send-email-gsi@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1385851897-23475-10-git-send-email-gsi@denx.de>
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org,
 Scott Wood <scottwood@freescale.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 30, 2013 at 11:51:29PM +0100, Gerhard Sittig wrote:
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

That's fine:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
