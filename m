Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 15 Oct 2007 17:28:16 +1000
Subject: [RFC/PATCH 0/2] powerpc: 64 bits irqtrace / lockdep support
Message-Id: <1192433296.924212.737979117370.qpush@grosgo>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is 2 patches, one from Christoph Hellwig that adds the backtrace support,
and one from Johannes Berg modified by me that adds the irq tracing support.

This successfully boots a POWER5 pSeries machine. I'm going to run some more
tests in the upcoming few days, so this is not an official submission (and it's
too late for .24 merge window anyway) but it's looking good so far.

Then, I -might- give a go at a 32 bits version but no promises there :-)
