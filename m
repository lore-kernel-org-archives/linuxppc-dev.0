Message-ID: <004801c2df08$90e5b1e0$0400a8c0@pc002>
From: "AlessandroPPC" <aleppcrossi@libero.it>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: cpu speed
Date: Fri, 28 Feb 2003 10:05:39 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear all,

I 've a MPC8260 board with 2.4.18 kernel version and nfs root fs . First I
have configurated it with cpu_clock = 133 MHz, cpm_clock = 100 MHz and
bus_clock = 33 Mhz with good results.
Then I have changed this configuration with cpu_clock = 166 MHz, cpm_clock =
100 MHz and bus_clock = 33 Mhz with bad results.
With cpu clock at 166 Mhz I have several error but typically "Illegal
istruction " error message is send on the console.
I have checked the bus timing (memory read/write access) with no difference
rispect to cpu_clock at 133 MHz.

Can be a cache problem ?

Tanks to all,
Alessandro.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
