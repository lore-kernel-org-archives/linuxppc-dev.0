Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 8412ADDF1D
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 05:08:31 +1000 (EST)
Date: Tue, 15 May 2007 11:55:35 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Dale Farnsworth <dale@farnsworth.org>
Subject: Re: [PATCH] powerpc: Add Marvell mv64x60 udbg putc/getc functions
Message-ID: <20070515185535.GF17643@mag.az.mvista.com>
References: <20070514195222.GA27602@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070514195222.GA27602@xyzzy.farnsworth.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 14, 2007 at 12:52:22PM -0700, Dale Farnsworth wrote:
> [PATCH] powerpc: Add Marvell mv64x60 udbg putc/getc functions
> 
> Commit 69331af, "Fixes and cleanups for earlyprintk aka boot console",
> resulted in printk output prior to the initialization of the mpsc
> console driver not being printed.  That commit causes the mpsc's
> CON_PRINTBUFFER flag to be cleared since udbg should have printed
> the previous output.
> 
> I guess we can no longer ignore udbg. :)
> 
> This patch provides udbg_putc() and udbg_getc() functions for the
> Marvell mv64x60 chips. These functions are enabled if an mv64x60
> port is to be used as the console as determined from the device tree.
> 
> Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

Acked-by: Mark A. Greer <mgreer@mvista.com>
