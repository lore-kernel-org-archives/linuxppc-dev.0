Date: Thu, 1 Nov 2001 19:10:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linuxppc-dev@lists.linuxppc.org,
	linuxppc-commit@source.mvista.com
Subject: Re: Incoming to hostme.bitkeeper.com:/ua/repos/p/ppc/linuxppc_2_4_devel
Message-ID: <20011101191023.A26982@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011101115619.A25864@cpe-24-221-152-185.az.sprintbbd.net> <Pine.LNX.4.33.0111012309400.8554-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0111012309400.8554-100000@serv>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 01, 2001 at 11:22:14PM +0100, Roman Zippel wrote:
> Hi,
>
> On Thu, 1 Nov 2001, Tom Rini wrote:
>
> > Arg, not my day.  Can you split up the rest of the changes into seperate
> > patches (01, 02, 0n) and make it vs the _devel tree?  It'll help stop me
> > from doing things like that. :)
>
> Hmm, there isn't much left to split.
> BTW the second patch depends on the first and only the last patch doesn't
> apply to the stable tree.

Just wondering, but have you tried these changes on a 'fake'
CONFIG_HIGHMEM setup? (eg set MAX_LOW_MEM to half your real RAM or so..)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
