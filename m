Message-Id: <200209101342.g8ADgXH06019@wnaw252.uab.ericsson.se>
Date: Tue, 10 Sep 2002 15:42:32 +0200
From: "Hans dot Feldt at uab.ericsson.se" <"Hans dot Feldt at uab.ericsson.se"@uab.ericsson.se>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC8260 - missing functions
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Could someone please briefly describe the status of the following
functions that all are included in the 860 port. I can't find them in a
patched 2.4.18 kernel.

- KGDB
- Watchdog
- IDE disk support
- ATM driver

I have read the 8260 comments in the archive from Jon Diekema ("Current
state of MPC8260 Linux") but that was 2,5 years ago. What has happened
since then?

I did a quick hack to get the watchdog working. I also ported the 8xx
KGDB stuff in uart.c but it fails badly with a "kernel stack overflow in
process c00d4420". That address is init_task_union. I am over my head
here so I leave this unless someone has a clue.


Regards,
Hans


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
