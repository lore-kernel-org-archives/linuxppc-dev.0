Message-ID: <CA78D1B723D8D411AF0300508BDCF74F3F6D76@NTCORREO>
From: IGOR LURI <iluri@fagorautomation.es>
To: =?ISO-8859-1?Q?EMBEDDED_LINUXPPC_=28Correo_electr=F3nico=29?= <linuxppc-embedded@lists.linuxppc.org>
Subject: Ethernet test program
Date: Tue, 25 Feb 2003 07:59:59 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

We have a embedded system running Linux and we have done a program to test
Ethernet part of the hardware.

Our program uses SOCK_PACKET type of sockets to send a packet itself ( as a
loopback) .

Our problem is that we receive the packet also when the Ethernet wire isn't
conected. It seems that our test program reads the packet from a buffer and
we need to read the packet that arrive from the wire.


Thanks in advance

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
