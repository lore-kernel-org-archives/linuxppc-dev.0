Date: Wed, 19 Jun 2002 08:05:20 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>,
	Wolfgang Denk <wd@denx.de>
Subject: Re: board specific defines in commproc.h !?!?
Message-ID: <20020619150520.GA12762@opus.bloom.county>
References: <3D0DA9C2.D78C43E5@imc-berlin.de> <3D106922.7026437A@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D106922.7026437A@imc-berlin.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jun 19, 2002 at 01:21:06PM +0200, Steven Scholz wrote:

> Steven Scholz wrote:
>
> > I think we should move the board specific defines such as
> > etc. out of ./include/asm-ppc/commproc.h into the board specific header
> > files like ./arch/ppc/platforms/xxx.h
>
> Ok,
>
> I'll give it a try now.
>
> Please find the attached patch. It moves the board specific definitions
> for MPC8xx CPM Ethernet out of ./include/asm-ppc/commproc.h into the
> board specific include files in ./arch/ppc/platforms/.
>
> It applies cleanly against today's linuxppc_2_4_devel (2.4.19-pre10)
> _and_ linuxppc_2_5 (2.5.4-pre2).
>
> I only tested it with 2_4_devel for a TQM860L board.
> The recent 2_5 does not even compile for neither TQM860L nor RPXLITE! So
> I had no chance to test it. But it should work just fine.
>
> Hope this helps cleaning up the mess! :o)

I'm sort-of supprised it works.
Isn't:
((uint)0x....)
in assembly bad?

I think we need to have all of these defines enclosed with the
__ASSEMBLY__ test, but I can go fix that.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
