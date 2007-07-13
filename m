Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18071.7389.640461.229828@cargo.ozlabs.ibm.com>
Date: Fri, 13 Jul 2007 16:34:05 +1000
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4] pm: Handle HID0_SLEEP in the TLF_NAPPING hack.
In-Reply-To: <20070712191301.GB31381@ld0162-tx32.am.freescale.net>
References: <20070712191205.GA31358@ld0162-tx32.am.freescale.net>
	<20070712191301.GB31381@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood writes:

> The e300 core (and probably most other 6xx chips) can only come out of
> sleep mode with an interrupt.  However, interrupts are logically disabled
> by the power management layer.

On powerbooks it's typically a hard reset rather than an interrupt.
Is it possible to use a hard reset on e300-based systems?

Also, if you use an interrupt, presumably the cpu has to do something
to clear the interrupt condition.  What would that be?

Paul.
