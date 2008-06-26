Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id ECA29DE055
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 01:51:28 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: add of_find_next_property and
	of_get_aliased_index
Date: Thu, 26 Jun 2008 17:51:05 +0200
References: <1214424332-18496-1-git-send-email-timur@freescale.com>
	<c293d4d144094e5b0311b703e64893dc@kernel.crashing.org>
	<4863B1C1.1060300@freescale.com>
In-Reply-To: <4863B1C1.1060300@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806261751.05379.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 June 2008, Timur Tabi wrote:
> > The only thing a platform should ever use aliases for is if it needs
> > to (for whatever purpose) find a specific device, that it cannot
> > identify otherwise (via "reg", ...).  And then that platform code
> > should look up the device by the alias, not look up the alias by the
> > device -- there is no 1-1 mapping from device to alias!
>
> Hmmm, I hadn't through about that.  I guess this patch isn't such a great
> idea after all.  I rescind it.

Too bad. So now we're back to where we started with the discussion 
about "cell-index" vs. "index" vs. no index on I2C device nodes. :-(

Best regards,
Stefan
