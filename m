Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-Id: <sccd40ff.057@mail.frequentis.com>
Date: Mon, 29 Apr 2002 12:47:27 +0200
From: "Gerhard TAEUBL" <Gerhard.TAEUBL@frequentis.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: Queue task Problem
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hallo!

I wrote a device driver which handles the SCC in UART mode of a MPC860T
for a simple protocol. The protocol start with a byte, the other side
send a ack, then the packet will be sent. At last an ack will be send
from the receiver. My problem is, that sometimes the bottom half part of
my software won't be executed.
For example I send the start character, the other side answer with an
ack, but nothing else happens, I got an timeout, and there I compare
counters for hardware interrupt and bottom half part of software, and
they are different.  With an terminal program I see, tht that is my
fault (the ack would be sent). Does anyone knows this phenomenon? On
transmission side I also have sometimes this problem.

Thanks in advanced
Gerhard

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
