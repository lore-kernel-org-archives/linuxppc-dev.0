From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <brad@turbolinux.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: powerbook doubles as a frying pan
Date: Mon, 29 Jan 2001 12:01:26 +0100
Message-Id: <19341224043310.26390@mailhost.mipsys.com>
In-Reply-To: <200101280019.QAA15270@mail.turbolinux.com>
References: <200101280019.QAA15270@mail.turbolinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>is everyone *totally* sure that activating the fan is entirely handled in
>hardware? is there no
>register for controlling the threshold?

I've seen nothing in Apple's own Darwin OS related to controlling the
powerbook fan neither. However, they do have code that use the CPU's
temperature sensors to control the ICTC (instruction cache throttling).

Troy have some code that allow to read the temp from /proc. However, it
looks like a lot of CPUs are so badly calibrated that the information
returned is almost useless... Maybe that's not the case in CPUs used in
portables, that's the case in some of the G4s used in dual G4s.

>/proc/cpuinfo does not report the temperature (i'm not sure the hardware
>can report it).
>
>for now, i put it to sleep whenever it gets hot. i suppose i should put
>sleep statements in
>anything that is cpu bound to save the machine. also i pull out the pc
>card if it's not in use to
>help with ventilation.
>
>(what a day i'm having... i just got it back and spent the day trying to
>find out why java would
>not run. after examing working- and non-working-strace's i noticed that
>the date was set to 1904.
>the java vm will not initialize with a date like that. maybe it's because
>sun realizes that no
>java machine was known to be working in the year 1904.)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
