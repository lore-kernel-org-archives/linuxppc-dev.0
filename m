MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: EST SBC8260 and Canary CTX-1170
Date: Thu, 8 Mar 2001 09:39:13 -0600
Message-ID: <CD5CA14300A9D54A8D13D58CD3C87B422DD729@advcorp-exc01.advent.com>
From: "Oliver Brown" <obrown@adventnetworks.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am having the same problem that was referenced in

http://lists.linuxppc.org/listarcs/linuxppc-embedded/200010/msg00167.htm
l

I can't generate any traffic on the fast ethernet port. There were many
suggestions in the above thread, but I was not sure what the final
solution was. Here what I'm using
-2.4.1 kernel
-Canary CTX-1170 with Lucent LU3X51FT Phy
-133 CPU and CPM clocks
-66 Bus clock

Ppcboot works fine on this setup, so I know that the hardware is
working.

Oliver Brown
Advent Networks

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
