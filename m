Date: Mon, 7 Dec 1998 15:02:41 -0600 (CST)
From: Troy Benjegerdes <hozer@drgw.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: PReP RTC vs Decrementer accuracy...
In-Reply-To: <19981207133145.029787@mail.mipsys.com>
Message-ID: <Pine.LNX.4.04.9812071456450.13527-100000@narn.local.drgw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



I just reset the time on my two prep boxes, which have apparently drifted
about 30-40 minutes fast over two weeks or so.

The PReP code also tries to reset the RTC to match the Kernel's
(decrementer's) version of the time every 11 minutes or so. The question I
have is, isn't the RTC more accurate for long periods of time?

I had this discussion with Cort awhile ago, and he said 'I used the
decrementer because it's part of the main CPU, which isn't a cheap $1
part'. It seemed reasonable enough logic at the time, but I suspect the
RTC may actually be more accurate (since that's what it's designed for,
and at least the one one my MTX can be software calibrated).

Does anyone have any experience with the RTC and decrementer accuracies on
Motorola boards?

--------------------------------------------------------------------------
| Troy Benjegerdes    |    troybenj@iastate.edu    |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
