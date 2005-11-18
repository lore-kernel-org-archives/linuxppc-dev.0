Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17277.10875.334722.856865@cargo.ozlabs.ibm.com>
Date: Fri, 18 Nov 2005 12:12:27 +1100
From: Paul Mackerras <paulus@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1132136755.21643.40.camel@hades.cambridge.redhat.com>
References: <1131357857.27347.28.camel@baythorne.infradead.org>
	<20051107160939.GD3839@smtp.west.cox.net>
	<1131380422.27347.72.camel@baythorne.infradead.org>
	<20051107165453.GA29111@lst.de>
	<1131382971.27347.79.camel@baythorne.infradead.org>
	<1132131116.28963.75.camel@baythorne.infradead.org>
	<17274.63508.501761.748278@cargo.ozlabs.ibm.com>
	<1132136755.21643.40.camel@hades.cambridge.redhat.com>
Cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Fix 8250 probe on ppc32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse writes:

> I'll try it on Pegasos some time tonight or tomorrow. AFAICT I'm going
> to need the patch which started this thread, if I want any serial ports
> on my Pegasos. The newly-created asm-powerpc/serial.h file is devoid of
> serial port definitions.

This intersects with some more ambitious reworking Ben H is doing, so
I won't put this one in.

Paul.
