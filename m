Message-ID: <E8F83D6D2A6AD3118E0300902786A20502371430@NTEX>
From: "David Marqvar (DAM)" <DAM@tt.dk>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Strange Ethernet
Date: Mon, 18 Mar 2002 11:05:01 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We have a very strange problem with ethernet.
We have a "standard" MPC8xxFADS with a MPC823 daugther-board.

The strange thing is that the ethernet does work when we connect the
ethernet port (on target) directly to another computer (with a 3com netcard)
using a crossed cable. And it does work when we connect it directly to some
big HP switch.
But it does NOT work if we connect the target to a little 5-ports hub
("Edimax", dual speed). There is transmission acording to the LEDs, but we
don't get any response. The ethernet is just not working.

What do you think of that?
Is it the HUB that is not working correctly? It was probably very cheep....
:)

Regards, David


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
