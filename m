Message-ID: <009601c29250$5016b6a0$0700a8c0@pc005>
Reply-To: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
From: "Ing.Gianfranco Morandi" <gianfranco.morandi@euro-studio.it>
To: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: Problem with FEC
Date: Fri, 22 Nov 2002 18:54:24 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We are using a custom 8260 board (which is based on est8260) where we have
configured the SCC1 as 10Mbit Ethernet (eth0), FCC1 (eth1) and FCC2 (eth2)
as  Fast Ethernet.

We are using the PPcboot 1.2.0 on eth0 together with the ELDK.

When we configure only SCC1 and FCC2 it's all OK, and the two interfaces
have different MAC addresses, when we try to use both FCC1 and FCC2 (or FCC1
only) together with SCC1 we are able to configure the eth1 and eth2 I/Fs but
we do not have any ping out from them. Moreover we have noted that eth0 and
eth1 (when is on FCC1) have the same MAC address.

Any suggestions?

Many thanks

Gianfranco


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
