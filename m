From: ghannon@cspi.com
To: tvdbroek@tsc.leica.nl
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <85256E85.005DF90C.00@pine.cspi.com>
Date: Thu, 29 Apr 2004 13:15:21 -0400
Subject: Re: ttyS1 on an MVME5100
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> does somebody ever uses the second serial channel on a Motorola MVME5100?

Do you mean the second channel on-board, or one of the serial ports that
are available using the IPMC-761?
I set console=ttyS1, and the result was similar to what you saw, the
board locked up.  I don't recall if I let it reboot (ie was it a panic or
a lock-up.)
I also tried just echoing some text to ttyS1 and it locked up as well.

> I'm using Linux version 2.4.7-timesys-3.1.246 from Timesys. Since this is
a
> free download there is no support from them.

I also tried using the ports available on the IPMC and got no where.
They don't seem to be recognized, unless I left out some kernel option.
I'm using the 2.4.23 kernel from the linuxppc_2_4_devel tree.

Please let me know if you find a solution to this.

G. Hannon


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
