Date: Thu, 24 Oct 2002 10:26:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: PrPMC800 interrupt problem
Message-ID: <20021024172642.GL669@opus.bloom.county>
References: <37671D04-E772-11D6-A4F1-0003931C2BFA@control.lth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <37671D04-E772-11D6-A4F1-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Oct 24, 2002 at 07:01:19PM +0200, Anders Blomdell wrote:
>
> When trying to use the linuxppc_2_4_devel on a PrPMC800, the system stops
> responding to external interrupts after the first serial interrupt. Many
> things works, since the system correctly gets its IP address via DHCP.
>
> The system handles a little more than 100 interrupts that gets routed to
> 'e100intr', then it starts up my shell that does a write to the console.
> This write triggers an interrupt that gets routed to 'rs_interrupt_single'
> . After this no more interrupts are received, but 'rs_interrupt_single' is
> called from the timer task in the serial driver, but the ethernet is
> totally dead. Anybody that has a good idea what to do about this?

Did you update the prpmc800_openpic_initsenses[] table and related?
(Look at how the lopec or sandpoint work now).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
