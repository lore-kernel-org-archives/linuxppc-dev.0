Return-Path: <mgreer@mvista.com>
Date: Tue, 20 Jun 2006 09:37:24 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] mpic: add support for serial mode interrupts
Message-ID: <20060620163724.GB14711@mag.az.mvista.com>
References: <20060619200811.GA15524@mag.az.mvista.com>
	<1150776086.23600.329.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1150776086.23600.329.camel@localhost.localdomain>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 20, 2006 at 02:01:26PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2006-06-19 at 13:08 -0700, Mark A. Greer wrote:
> > MPC10x-style interrupt controllers have a serial mode that allows
> > several interrupts to be clocked in through one INT signal.
> > 
> > This patch adds the software support for that mode.
> 
> You hard code the clock ratio...

Basically, I just brought what was already in ppc over to powerpc.
I didn't really think about it much.

> why not add a separate call to be called after mpic_init,
> something like mpic_set_serial_int(int mpic, int enable, int
> clock_ratio) ?

Yeah, that's a better way to do it.

I'll make a new patch.

Mark
