Date: Mon, 6 Jan 2003 11:23:06 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: request_irq, MPX8xx, IDE, PCMCIA, ...
Message-ID: <20030106182306.GB796@opus.bloom.county>
References: <3E19B8A9.4F1F82E0@imc-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E19B8A9.4F1F82E0@imc-berlin.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jan 06, 2003 at 06:11:05PM +0100, Steven Scholz wrote:

> Hi there,
>
> last year ide-cs was working on MPC8xx platforms.
>
> It was necessary to define
>
> 	define ide_request_irq(irq,hand,flg,dev,id)
> request_8xxirq((irq),(hand),(flg),(dev),(id))
>
> in the board specific header file.
>
> I just relalised that on December 16 code in ide-probe was changed!!!

As part of the IDE cleanup, yes.

> What is the status of the request_8xxirq() vs request_irq() stuff?

At the certain annoyance of Dan Malek (sorry Dan), really really soon
now.  I've got a local (Marcelo-based) 2.4 with the changes in, and lightly
tested.  Once it passes some more heavy 'stress', I'll ask Paul to send
it onto Marcelo.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
