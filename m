Date: Tue, 9 Apr 2002 10:12:11 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, <msokolov@ivan.Harhan.ORG>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_GENERIC_PPC32
In-Reply-To: <Pine.GSO.4.21.0204071026160.2567-100000@lisianthus.sonytel.be>
Message-ID: <Pine.LNX.4.33.0204091011250.27299-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 7 Apr 2002, Geert Uytterhoeven wrote:
> >  - Completely rip off CONFIG_ALL_PPC in favor of CONFIG_GENERIC_PPC32
> >  - Each board model has it's own CONFIG_xxx entry (like Michael patch),
> >    which means adding "back" CONFIG_PMAC, CONFIG_CHRP, CONFIG_PREP, but
> >    those will only control which set of .c file will get in the makefile
> >    and the toplevel switch/case on platform_init. That is you will be able
> >    to select an arbitrary set of boards.
>
> Good, starts to look like m68k again, where you always were able to compile a
> generic kernel (except for Sun-3 (not 3x) due to the different MMU)!
> Now start moving platform specific files to arch/ppc/$platform/ again. Dan is
> right, we're running in circles :-)

Good spotting, Waldorf! :-)

ROTFL,

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
