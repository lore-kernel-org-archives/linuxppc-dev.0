Message-Id: <200101280019.QAA15270@mail.turbolinux.com>
Date: Sun, 28 Jan 2001 00:27:31 -0000
To: linuxppc-dev@lists.linuxppc.org
Subject: powerbook doubles as a frying pan
From: Brad Midgley <brad@turbolinux.com>
Reply-To: brad@turbolinux.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


hi,

the only time i ever noticed the fan on my powerbook turn on was when i could smell something
burning... it was while i was running a long-running java program which was cpu-bound. the program
was probably going for about a half hour.

i shut the machine down as soon as i realized where the smell was coming from. after that it
wouldn't boot. the tech says the ethernet chip had a "blister" on it. replacing the logic board
cost almost $600.

is everyone *totally* sure that activating the fan is entirely handled in hardware? is there no
register for controlling the threshold?

/proc/cpuinfo does not report the temperature (i'm not sure the hardware can report it).

for now, i put it to sleep whenever it gets hot. i suppose i should put sleep statements in
anything that is cpu bound to save the machine. also i pull out the pc card if it's not in use to
help with ventilation.

(what a day i'm having... i just got it back and spent the day trying to find out why java would
not run. after examing working- and non-working-strace's i noticed that the date was set to 1904.
the java vm will not initialize with a date like that. maybe it's because sun realizes that no
java machine was known to be working in the year 1904.)

--
Brad
brad@turbolinux.com      http://www.turbolinux.com/~brad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
