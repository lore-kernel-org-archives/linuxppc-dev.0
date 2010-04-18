Return-Path: <tglx@linutronix.de>
Date: Sun, 18 Apr 2010 21:14:12 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Guillaume Knispel <gknispel@proformatique.com>
Subject: Re: Pending interrupts not always replayed
In-Reply-To: <20100418164614.771d4f01@xilun.lan.proformatique.com>
Message-ID: <alpine.LFD.2.00.1004182112280.2972@localhost.localdomain>
References: <20100418053439.4d2ffe11@xilun.lan.proformatique.com>
	<20100418164614.771d4f01@xilun.lan.proformatique.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Michael Buesch <mb@bu3sch.de>, Ingo Molnar <mingo@elte.hu>,
	Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 18 Apr 2010, Guillaume Knispel wrote:
> Now everything seems to work fine: my device was not previously not
> interrupting anymore after typically 1 or 2 minutes (because the
> interrupt signal stays at level low until the device is served, so

So you are having a level interrupt device and the irq line is handled
by an edge type handler ? Why not configuring the irq line for level
and in the first place ?

Thanks,

	tglx
