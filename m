Date: Sun, 7 Sep 2003 18:51:00 +0200
From: Matthias Grimm <matthias.grimm@htp-tel.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: [BUG] 2.4.21-benh2 - AC power plug not recognised
Message-Id: <20030907185100.4590f9a4.matthias.grimm@htp-tel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hallo,
I found a bug in kernel 2.4.21-benh2.

I used a G3 Powerbook Pismo for the tests.

If the computer is switched on and boots with empty battery slots
(no battery connected) and with AC power only, the kernel doesn't
recognise the AC power plug.

/proc/pmu/info says:

PMU driver version     : 2
PMU firmware version   : 0c
AC Power               : 0   <-- look here, remember: no battery inside.
Battery count          : 2

After I had put a battery in a slot without changing anything else
/proc/pmu/info showed the following (AC connector still pluged in):

PMU driver version     : 2
PMU firmware version   : 0c
AC Power               : 1   <-- look here
Battery count          : 2

Removing/replugging the battery again didn't change anything. The
phenomenon only occur after boot without any battery.

I hope this will help to remove the bug.

   Best Regards
     Matthias


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
