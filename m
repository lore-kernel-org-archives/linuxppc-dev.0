Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18121.11392.459659.535657@cargo.ozlabs.ibm.com>
Date: Mon, 20 Aug 2007 15:54:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3 v2][POWERPC] Stop include asm-ppc when building
	ARCH=powerpc for ppc32
In-Reply-To: <Pine.LNX.4.64.0708181210390.31362@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0708181203320.31362@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708181206070.31362@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708181207530.31362@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708181210390.31362@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> We no longer have any dependancies on include/asm-ppc so we can get ride
> of the makefile hacks to include it in the build process.

On 32-bit powermac, I get:

  CC [M]  drivers/macintosh/ans-lcd.o
/home/paulus/kernel/powerpc/drivers/macintosh/ans-lcd.c:17:25: error: asm/ans-lcd.h: No such file or directory

plus a whole pile of things undefined after that.

Paul.
