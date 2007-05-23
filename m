Return-Path: <dale@farnsworth.org>
Date: 23 May 2007 13:23:11 -0700
Message-ID: <20070523202311.29000.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: djiang@mvista.com, Linuxppc-dev@ozlabs.org, paulus@samba.org,
	bluesmoke-devel@lists.sourceforge.net
Subject: Re: [PATCH] powerpc: setup Marvell mv64x60 platform devices for EDAC
In-Reply-To: <20070522232432.GA26046@blade.az.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dave Jiang wrote:
> Creating platform devices (memory controller, sram error registers, cpu error
> registers, PCI error registers) for Error Detection and Correction (EDAC)
> driver on the Marvell mv64x60 based platforms.
> 
> The platform devices allow the mv64x60 EDAC driver to detect errors from the
> memory controller (ECC erorrs), SRAM controller, CPU data path error registers,
> and PCI error registers. The errors are reported to syslog. Software ECC
> scrubbing is provided. These replace the mv64x60 error handlers in the
> ppc branch
> They are being moved to EDAC subsystem in order to centralize error reporting. 
> 
> The error reporting can be triggered via interrupts from the mv64x60 bridge chip
> or via polling mechanism provided by the EDAC core code.
> 
> The mv64x60 EDAC driver can be found at:
> http://bluesmoke.sourceforge.net/
> 
> It's in development to be pushed into the kernel.
> 
> Signed-off-by: Dave Jiang <djiang@mvista.com>

Acked-by: Dale Farnsworth <dale@farnsworth.org>
