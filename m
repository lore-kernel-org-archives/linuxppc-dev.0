Message-Id: <004a01bfe680$e8fc1460$a74901b6@riverton.ccrl.mot.com>
From: "Brett Lindsley" <Brett_Lindsley-ABL001@email.mot.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Wireless Connection
Date: Wed, 5 Jul 2000 07:59:51 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have a need to provide a wireless link between an Embedded Planet
RPX-Lite embedded system and a custom non-PowerPC system. My
requirements are:

1. Minimum data rate of 1 MBit/sec.
2. Source for the driver must be available.
3. The wireless link is not a "network" so the entire protocol stack
    is not necessary (and actually will not be used).

Does anyone have a suggested wireless network card that works
with the RPX-lite? More important, is the source for the driver available?
The source is very important because I need to port it to a *non-Linux*
environment on a specialized non-PowerPC embedded device.
In terms of a "driver" all I really need is the ability to send/receive
packets
directly on top of the network MAC.

I have extensively investigated 802.11 and 802.11b but details on the
wireless
network cards have been too thin to determine how to develop a simple
driver for them. My development group is in the middle of the Linux/MPC823
learning curve as this is our first project using the RPX-lite board and
Linux.

Brett Lindsley, Research Engineer
Motorola Corporate Research & Development Labs


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
