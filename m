Message-ID: <FD52892BD296D71183B400065BFCB69009982F2E@il02exm12>
From: Hawkins Jeffrey-CJH016 <Jeffrey.F.Hawkins@motorola.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Motorola MCP820 Board - 7410 / Harrier ASIC based - System Weirdn
	ess
Date: Mon, 10 May 2004 19:19:49 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I am evaluating a Motorola Computer Group MCP820 Board.  It is 7410 Based, running at 500 Mhz, 256MB RAM, 2MB L2 Cache.  Testing using 2.4.18 and 2.4.20 Kernels utilizing LMBENCH.  I am seeing some strange behavior with the Local Communications Latency Tests.  Comparing to a similarly configured 750 based System, the UDP and TCP operations have a latency that is 2+ times worse than the lesser performing System (MCP750 @ 366 Mhz).  Below is a snippet from the LMBENCH output:

*Local* Communication latencies in microseconds - smaller is better
-------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
M750-01   Linux 2.4.18 0.990 8.471   14    38   103    67   155  255
M750-01   Linux 2.4.18 0.960 8.657   14    38   103    67   154  255
M750-01   Linux 2.4.18 1.000 8.279   14    38   103    67   138  254
M750-01   Linux 2.4.18 0.830 8.425   14    38   102    67   155  255
M750-01   Linux 2.4.18 0.990 8.427   14    38   102    67   154  254
M820-01   Linux 2.4.18 0.770 6.060   10    73   237   133   357  598
M820-01   Linux 2.4.18 0.770 6.076   10    73   238   133   354  594
M820-01   Linux 2.4.18 0.580 6.079   10    73   240   134   357  591
M820-01   Linux 2.4.20 0.770 6.483   11    73   226   139   376  592
M820-01   Linux 2.4.20 0.780 6.608   11    69   222   129   367  577

Can anybody give me some insight into this weirdness ?

Thanks,
Jeff


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
