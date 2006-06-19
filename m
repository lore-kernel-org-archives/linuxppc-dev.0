Return-Path: <mgreer@mvista.com>
Date: Mon, 19 Jun 2006 13:19:59 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] mpic: add support for serial mode interrupts
Message-ID: <20060619201959.GA16358@mag.az.mvista.com>
References: <20060619200811.GA15524@mag.az.mvista.com>
	<20060619201121.GC4845@pb15.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060619201121.GC4845@pb15.lixom.net>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 19, 2006 at 03:11:21PM -0500, Olof Johansson wrote:
> Hi,
> 
> On Mon, Jun 19, 2006 at 01:08:11PM -0700, Mark A. Greer wrote:
> > MPC10x-style interrupt controllers have a serial mode that allows
> > several interrupts to be clocked in through one INT signal.
> [...]
> > +	/* For serial interrupts & set clock ratio */
> > +	if (flags & MPIC_SERIAL_MODE)
> > +		mpic_write(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1,
> > +			mpic_read(mpic->gregs, MPIC_GREG_GLOBAL_CONF_1)
> > +				| (1<<27) | (0x7<<28));
> 
> Can you define some constants so others can see just what the bits mean
> without digging up documentation, instead of just doing magic numbers?

Yeah, I can probably do that...  :)

Mark
