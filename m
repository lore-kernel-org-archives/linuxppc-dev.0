Message-ID: <3A8B0179.5256B176@mvista.com>
Date: Wed, 14 Feb 2001 17:06:49 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Sid <sid@innvo.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux on XPC860
References: <03e901c096c4$fb4bd020$2501000a@sid> <3A8AFA05.F77DB30E@mvista.com> <007501c096d1$3175aa20$2501000a@sid>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sid wrote:

> I am sorry if my questions appear trivial. I am new to PowerPCs and
> am quite lost. I do have a HardHat CDK1.2 cd and I have succeeded
> in running linux on an ARM machine. I'm stuck at the PowerPC and
> one of the things I'm lacking is hardware documentation.

One of the advantages of the MontaVista CDK is it's similarity among
all processors and boards supported.  Since you were successful with
StrongARM, PowerPC should be just as easy.

> The board I have has an embedded XPC860MHZP50C1 processor. Apart
> from this a DRAM slot, a parallel port, 10BaseT slot, standard stuff, I
> assume.

You mentioned in your first message this was a Motorola board.  What
is it?  If the LSP exists in the CDK, it should "just work" and be
documented how to do so.  If the LSP isn't in the CDK, you have
porting work ahead of you (and you are going to need lots more than
the documentation for the board :-).  Did you purchase a subscription
and are entitled to top quality Linux consulting support?  If so,
call them.

> Does this mean that I can use MPC860 documentation without any major
> differences?

It's a Rev. C1 part, and a generic 860 (no 10/100 FEC, SAR, or
enhanced CPM features), so you should be OK.  Not many silicon bugs
left in that one.

Have fun!


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
