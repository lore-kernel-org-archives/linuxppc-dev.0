Message-ID: <3843F20B.2C1616E@netx4.com>
Date: Tue, 30 Nov 1999 10:49:31 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: paulus@linuxcare.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: dmasound problems
References: <19991130164439.032538@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:


> I still have one problem with the console beep not coming back after
> sleep (if I launch mpg123, it plays fine and my beep is back. Also,
> sleeping while mpg123 is playing correctly resume the play). This chip
> seems to be very sensitive to timings in general.

As I recall, the beep is a shortcut path through the driver and
makes assumptions about the sound interface configuration (i.e.
powered up, initialized, etc.).  Running some application that
follows the entire path to open and initialize the interface
will then make the beep happy.


> now correctly powered off when the machine goes to sleep (or when
> dmasound module is removed).

If you unload the module, I suspect console beep will go away
as well???


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
