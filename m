Message-Id: <v04003a00b66419331ca3@[24.70.162.12]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 18 Dec 2000 13:58:02 -0600
To: linuxppc-dev@lists.linuxppc.org
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: 2.4.0-test13-pre3 pukes on 9600/200mp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just today rsynced the latest from
rsync://penguinppc.org/linux-pmac-devel, compiled and ran it, and I get the
following on boot:

...
arch: exit
found cpu 1
smp_commence
cpu 0: vector: 200 at pc = f3b8, lr = 3a0, msr = 41000, sp = c01ab240
[c01ab190]

f3b8 is exactly "hash_page_out" in the system map, a rather smp-only chunk
of asm. 3a0 appears to be in the DSI exception handler.

I've been using 2.4.0-test11 before this quite successfully (also rsynced
from the same source). I unfortunatley didn't think to keep the sources
around to look for differences.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
