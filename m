Date: Tue, 24 Jul 2001 17:07:21 -0700
From: Matt Porter <mporter@mvista.com>
To: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
Cc: "'Matt Porter'" <mporter@mvista.com>,
	"PPC-Linux list (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 2.4.6 kernel on MCP750 board
Message-ID: <20010724170721.H3651@beef.az.mvista.com>
References: <619D608DD3F0D311882C009027732E1A353231@ntserver.act.domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <619D608DD3F0D311882C009027732E1A353231@ntserver.act.domain>; from rudolf.ladyzhenskii@act-aus.net on Wed, Jul 25, 2001 at 09:48:24AM +1000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jul 25, 2001 at 09:48:24AM +1000, Rudolf Ladyzhenskii wrote:
> > Are you running linuxppc_2_4_devel or a kernel.org 2.4.6?
> > What rev. of
> > mcp750?
> >
>
> We are running 2.4.6 kernel from kernel.org.
> The latest kernel opn Monta Vista side did not work at all on MCP750 and on
> our custom 8260 based board. Kernel woud start, but none of rhe external
> interfaces would work (console, Ethernet). Eventually (by flashing LEDs on
> our board) I traced it down to the transmit section of console code. It will
> sit in the endless loop waiting for Tx buffer go empty. Looks like
> interrupts were disabled by some reason.

The kernel.org releases generally don't work on any given PPC platform
outside of pmacs.  I can't comment on 8260 systems since I don't have
any, but the patch I gave you was tested on my Rev. J MCP750 versus
a linuxppc_2_4_devel tree pulled from bitmover a few days ago.  I've
got to run now but I'll try my board tomorrow with the latest batch
of changesets just as a sanity check that things still work.  You
shouldn't be seeing all those resource explosions.

> Anyway, we downloaded latest 2.4.6 from kernel.org This works fine on our
> 8260 board.
> We use MCP750 REV.A board

Are you sure you didn't look at the Revision marking of the memory
mezzanine PCB?  Check the sticker next to the serial number on the
back of the MCP750 PCB.  For example, mine is 01J indicating a Rev. J
board.  I hope yours is later than a Rev. A. :)

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
