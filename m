Message-ID: <3A9EFA26.8030805@bigpond.com>
Date: Fri, 02 Mar 2001 12:40:54 +1100
From: Brendan J Simon <brendan.simon@bigpond.com>
Reply-To: brendan.simon@bigpond.com
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Cc: Dan Malek <dmalek@jlc.net>
Subject: linuxppc-embedded: mpc8260 bus frequency calculations
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've come accross a problem where our custom embedded 8260 board is
losing time.  I've tracked it down to the bi_busfreq value being set to
66 instead of the true value of
66.6666666666666666666666666666666666666.  One solution is to have the
board_info fields in units of Hz instead of MHz.  I could then set the
bi_busfreq value to 66666667 for much better accuracy.

Another solution might be to regularly read the real time clock.  Does
linux do this normally or does it just read the RTC once at boot up and
then just rely on it's internal timers for the system time.  I can't see
how this can be very accurate.

Thanks,
Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
