Date: Mon, 21 Jul 2003 14:10:41 +1200
From: Robin Gilks <robin.gilks@tait.co.nz>
Subject: Clock rate on MPC8xx CPUs
To: linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3F1B4BA1.6000204@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings

Can anyone shed some light on a question of clock rates?

We're playing with the mpc866ads board and currently running both the
CPU core and bus at 50MHz to keep things simple. As a result it seems
that the internal Linux time is 50% out despite passing the clock rate
from u-boot as being 50MHz.

Since the mpc866 can run its core at x2 the bus rate, does the timer
setup in Linux for this port assume that the CPU _will_ be running at x2
from the rate passed at boot time or is there something else
'interesting' with this new '866 CPU :-))


--
Robin Gilks
Senior Design Engineer              Phone: (+64)(3) 357 1569
Tait Electronics                          Fax  :  (+64)(3) 359 4632
PO Box 1645 Christchurch        Email : robin.gilks@tait.co.nz
New Zealand


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
