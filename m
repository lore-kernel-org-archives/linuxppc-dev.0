Date: Mon, 27 Nov 2000 17:09:33 -0600 (CST)
From: Brian Ford <ford@vss.fsi.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: EST SBC8260 and Canary CTX-1170
In-Reply-To: <3A22C5BF.445BF4F1@mvista.com>
Message-ID: <Pine.GSO.4.21.0011271651000.493-100000@eos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am having the same problem that was referenced in:
http://lists.linuxppc.org/listarcs/linuxppc-embedded/200010/msg00167.html

Basically, I can't generate any traffic on the fast Ethernet as seen
by a sniffer.  I could not find any responses to that message, so I will
pose those questions again.

Does Linux support the CTX-1170 MII?  The arch/ppc/8260_io/fcc_enet.c
source code talks about the QS6612.  Will I need to extended fcc_enet.c to
support the CTX-1170?

I know that the hardware can work, because the VxWorks boot rom loads
Linux successfully via this interface and MII.

Thanks for any pointers on where to start.

--
Brian Ford
Software Engineer
Vital Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
