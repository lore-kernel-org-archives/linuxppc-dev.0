Message-ID: <3E3189A3.6030102@tataelxsi.co.in>
Date: Sat, 25 Jan 2003 00:14:51 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: running bdi2000 (cpu in debug mode)
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
We connected bdi2000 to the jtag interface of our mpc8260ads board.
The flash contains ppcboot (we installed it throgh bdi2000). The board
boots up with ppcboot. But when we try to debug our kernel using
bdi2000, it enters the debug mode. How to set break points and run till
that break points?

Once bdi2000 is connected, no output comes in the serial console. The
light showing cpu-run goes off indicating it does not run.

We are able to download files and examine the memory contents.
if you have any idea how to proceed, please let me know.

Thank you,
Om.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
