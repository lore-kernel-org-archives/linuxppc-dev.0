Date: Mon, 27 May 2002 16:46:26 -0700
From: Matt Porter <porter@cox.net>
To: Rajappa Iyer <rsi@panix.com>
Cc: Matt Porter <porter@cox.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: P2P bridge (DEC 21154) initialization on MCP750
Message-ID: <20020527164626.A1740@home.com>
References: <200205250114.g4P1ELi08721@panix1.panix.com> <20020524200953.A21781@home.com> <200205272214.g4RMEOP02787@panix3.panix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200205272214.g4RMEOP02787@panix3.panix.com>; from rsi@panix.com on Mon, May 27, 2002 at 06:14:24PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, May 27, 2002 at 06:14:24PM -0400, Rajappa Iyer wrote:
> Matt Porter <porter@cox.net> writes:
>
> > On Fri, May 24, 2002 at 09:14:21PM -0400, Rajappa Iyer wrote:
> > >
> > > I'm having problems with the PCI-PCI bridge (DEC 21154) on the MCP750
> > > and would appreciate any words of wisdom.  Basically, this bridge does
> > > not get initialized and therefore no devices are probed on the
> > > secondary bus.
>
> > Use _devel and start with the pplus port.  'make pplus_config'
>
> Thanks.  This did improve the situation somewhat in that the P2P
> bridge is now initialized properly, but the devices beyond it are
> still not probed.   Incidentally, I had to work with 2.5.x, since the
> 2.4 devel kernel was, for some reason, unbearably slow.
>
> Here's the dmesg.  Does it set off any alarm bells?

You're the first person to try one of these boards on 2.5 that I've
heard of.  Can you explain what you mean by "unbearably slow" on
_devel?  Please enable DEBUG in arch/ppc/kernel/pci.c and
drivers/pci/pci.c and repost those kernel messages.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
