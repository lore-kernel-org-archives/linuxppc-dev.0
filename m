Date: Mon, 29 Jan 2001 16:15:51 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: <brad@turbolinux.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: powerbook doubles as a frying pan
In-Reply-To: <19341224043310.26390@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.30.0101291602350.2636-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >is everyone *totally* sure that activating the fan is entirely handled in
> >hardware? is there no
> >register for controlling the threshold?
>
> I've seen nothing in Apple's own Darwin OS related to controlling the
> powerbook fan neither. However, they do have code that use the CPU's
> temperature sensors to control the ICTC (instruction cache throttling).

Which would be not-so-useful to control the temperature of the ethernet
chip, right? The PowerPC CPU isn't the primary source of heat in a laptop.
At least not to the extend the Intel CPU would be.
CPU temperature monitoring wouldn't be too useful either - the CPU
core always runs a lot hotter than the rest of the motherboard.

But I'm mostly guessing here - has anybody stuck a couple of temperature
probes on a PB motherboard and really measured the operating temperature?
What would the best 'hot spots' be for such an experiment?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
