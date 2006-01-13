Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 736E3689AC
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jan 2006 09:54:17 +1100 (EST)
Date: Fri, 13 Jan 2006 14:52:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kumar Gala <galak@gate.crashing.org>
Subject: Re: [PATCH] powerpc: Add support for the MPC83xx watchdog
Message-Id: <20060113145259.6d38e296.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0601131618020.26648-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0601131618020.26648-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: dave@cray.org, linux-kernel@vger.kernel.org,
	iinuxppc-embedded@gate.crashing.org, linuxppc-dev@ozlabs.org, wim@iguana.be
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala <galak@gate.crashing.org> wrote:
>
> Added support for the PowerPC MPC83xx watchdog.  The MPC83xx has a simple
> watchdog that once enabled it can not be stopped, has some simple timeout
> range selection, and the ability to either reset the processor or take
> a machine check.
> 
>
> +static ushort timeout = 0xffff;

There's no such thing ;)  I'll change this to u16, OK?


> +static int mpc83xx_wdt_ioctl(struct inode *inode, struct file *file,
> +			     unsigned int cmd,
> +	unsigned long arg)

Whitespace went nutty in various places.  I'll fix that up.  Please see the
followup patch.
