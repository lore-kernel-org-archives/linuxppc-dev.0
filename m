Date: Wed, 28 Nov 2001 16:37:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Platform files question
Message-ID: <20011128163730.C29541@cpe-24-221-152-185.az.sprintbbd.net>
References: <0111281854.AA27629@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0111281854.AA27629@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 28, 2001 at 10:54:05AM -0800, Michael Sokolov wrote:
>
> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > There's no exact way right now.  But it breaks down like this, if you
> > have a port which does _not_ need to change include/asm-ppc/serial.h,
> > they can all go in arch/ppc/platforms.  If you change
> > include/asm-ppc/serial.h AND newBoard_serial.h needs to include
> > newBoard.h, they both go in include/asm-ppc/platforms/.
>
> And what if I have a port that has its newBoard_serial.h, but it doesn't need
> to include newBoard.h?

arch/ppc/platforms/newBoard.h,
include/asm-ppc/platforms/newBoard_serial.h.

All of the 6xx/7xx/74xx board.h files in platforms/ are there because of
board_serial.h requiring them.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
