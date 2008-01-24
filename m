Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6F195DDD0A
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 17:28:13 +1100 (EST)
Date: Wed, 23 Jan 2008 22:29:12 -0800
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Always build setup-bus.c on powerpc
Message-ID: <20080124062912.GA22509@kroah.com>
References: <Pine.LNX.4.64.0801240006380.21347@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0801240006380.21347@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 24, 2008 at 12:07:32AM -0600, Kumar Gala wrote:
> The common arch/powerpc code calls in to functions in setup-bus.c
> so some builds of ppc32 would fail.
> 
> Note, ppc32 usage of setup-irq.c is limited to arch/ppc and should be
> removed when arch/ppc goes away.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> 
> Greg, recent changes that BenH has made to the arch/powerpc pci code make
> this necessary. If you don't have an issue I'd like this patch to go via
> the paulus's powerpc.git tree.

No objection at all.  Feel free to add my:
	Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
to this patch and send it through Paul.

thanks,

greg k-h
