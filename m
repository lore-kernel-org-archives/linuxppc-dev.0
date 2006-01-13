Return-Path: <galak@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DDA50689D6
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jan 2006 09:59:12 +1100 (EST)
Date: Fri, 13 Jan 2006 16:50:35 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] powerpc: Add support for the MPC83xx watchdog
In-Reply-To: <20060113145259.6d38e296.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0601131649340.26648-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Fri, 13 Jan 2006, Andrew Morton wrote:

> Kumar Gala <galak@gate.crashing.org> wrote:
> >
> > Added support for the PowerPC MPC83xx watchdog.  The MPC83xx has a simple
> > watchdog that once enabled it can not be stopped, has some simple timeout
> > range selection, and the ability to either reset the processor or take
> > a machine check.
> > 
> >
> > +static ushort timeout = 0xffff;
> 
> There's no such thing ;)  I'll change this to u16, OK?

There is one in include/linux/types.h, but u16 is fine.

> > +static int mpc83xx_wdt_ioctl(struct inode *inode, struct file *file,
> > +			     unsigned int cmd,
> > +	unsigned long arg)
> 
> Whitespace went nutty in various places.  I'll fix that up.  Please see the
> followup patch.

Odd, no one else has had any issues with patches from me recently.

- kumar
