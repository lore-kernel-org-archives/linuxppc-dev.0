Date: Mon, 17 Jun 2002 08:32:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: board specific defines in commproc.h !?!?
Message-ID: <20020617153255.GS13541@opus.bloom.county>
References: <3D0DA9C2.D78C43E5@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D0DA9C2.D78C43E5@imc-berlin.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jun 17, 2002 at 11:20:02AM +0200, Steven Scholz wrote:

> Hi there,
>
> I think we should move the board specific defines such as
>
> /***  RPXCLASSIC  *****************************************************/
[snip]
> etc. out of ./include/asm-ppc/commproc.h into the board specific header
> files like ./arch/ppc/platforms/xxx.h

Yes, we should.  Patches vs linuxppc-2.5 (note, you won't be able to
boot 8xx unless you perform some other updates) happily accepted.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
