Date: Thu, 1 Nov 2001 11:56:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	linuxppc-commit@source.mvista.com
Subject: Re: Incoming to hostme.bitkeeper.com:/ua/repos/p/ppc/linuxppc_2_4_devel
Message-ID: <20011101115619.A25864@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011101001030.EFA5510094@hostme.bitkeeper.com> <3BE1932E.DB7956CA@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BE1932E.DB7956CA@linux-m68k.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 01, 2001 at 07:23:42PM +0100, Roman Zippel wrote:
> Hi,
>
> > ChangeSet@1.559, 2001-10-31 17:09:57-07:00, trini@opus.bloom.county
> >   Minor cleanups wrt isa_{io,mem}_base and pci_dram_offset, from
> >   Roman Zippel <zippel@linux-m68k.org>
>
> You missed the declaritions in mpc8xx.h, that change is in the other
> patch. Sorry, I didn't mention it, I didn't resent the parts that
> applied cleanly.

Arg, not my day.  Can you split up the rest of the changes into seperate
patches (01, 02, 0n) and make it vs the _devel tree?  It'll help stop me
from doing things like that. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
