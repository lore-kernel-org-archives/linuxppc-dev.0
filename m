Message-ID: <3E034380.1080404@tataelxsi.co.in>
Date: Fri, 20 Dec 2002 21:51:20 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: E1/T1 on mpc8260.
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings,
We are developing a bridge which will convert 7 E1/T1 channels to
100Mbps ethernet using mpc8260 and Exar XRT84L38 Octal framer.

According the design, TDMs will be fed data from octal T1/E1 framer. I
will have to program the MCC to accept data from the TDMs and give it to
a pppd daemon.

If the TDMs are fed data from the framer (i.e. E1/T1's stripped of
signaling and channeling information), how many channels do I have to
program in the MCC?
Do I have to program one channel for each E1/T1 lines or 30 channels for
each E1 and 24 channels for each T1s? Or any of the approach is OK
provided I do not want the 64kbps granularity and ready to accept it as
a big stram of bytes (64 x 30 kbps)? if I do so, can I demultiplex it
using some other device?

if one E1 is accepted as one channel in MCC, then why is it stated that
it takes 128 channels of 64k each? (MPC8260UM.pdf,

The motorola manual uses the term `channel` both for E1 lines and the
thirty (or 32) 'channels' inside it. I am confused.
Any help is appreciated.

Thanks and regards,
Om.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
