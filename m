Message-ID: <3B8DED0C.5529E64E@elettra.trieste.it>
Date: Thu, 30 Aug 2001 09:36:44 +0200
From: Lorenzo Pivetta <lorenzo.pivetta@elettra.trieste.it>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: MVME5100 disk boot
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm running linuxppc_2_4_devel (kernel 2.4.7) on a MVME5100.
Everithing works quite fine (network boot, flash boot etc) but
to boot from disk I *have* to use the complete pboot command,
(i.e. "pboot 10 0 1" on my system), and this works.
I tried to store the default boot paths either in the environment

PPC6-Bug>env
...
Auto Boot Controller LUN   = 00?
10
Auto Boot Device LUN       = 00?
0
Auto Boot Partition Number = 00? 1
...

or with the "iot" command. Running "pboot;v" to simulate the
AutoBoot feature wont work, trying to boot from CLUN =00, DLUN =00
instead of CLUN =10, DLUN =00. It seems not to store the desired
boot LUNS (am I missing some steps?).
Any suggestions?

Thanks, Lorenzo.

--
Ing. Lorenzo Pivetta       \ e-mail: lorenzo.pivetta@elettra.trieste.it
                            \ tel.:  040 - 3758361 - fax: 040 - 9380902
Sincrotrone Trieste S.C.p.A. \ url:  http://www.elettra.trieste.it

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
