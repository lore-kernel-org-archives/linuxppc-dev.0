Content-Type: text/plain;
  charset="us-ascii"
From: Arun Dharankar <ADharankar@ATTBI.Com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem with MPC8260ADS ethernet sending
Date: Sat, 18 May 2002 11:41:38 -0400
MIME-Version: 1.0
Message-Id: <200205181141.38793.ADharankar@ATTBI.Com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings.

On Motorola MPC8260ADS board (as it is), I have ppcboot (1.1.5)
and Linux (2.4.18 and 2.4.19-pre8 both). The network interface is
lxt970 on fcc2. Receive data  is ok (perhaps a bit slow).

When I try to send data out of the board, I see that as long as the
buffer size if less than or equal to 160 bytes, the send is ok. Any
buffer size above 160 bytes (even 161), the buffer does not make
it out of the host.


The above test is with a UDP program. A ping flood from another
host does not seem to cause a problem. Likewise, if I use ftp to
get files to the board, it works ok (again slow), but send of files
will fail after sending some data.


Any pointers to the solution, hints, strategies to debug this would
be very helpful.

Thanks in  advance.
-Arun.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
