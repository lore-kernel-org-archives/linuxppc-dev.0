Message-ID: <01C0750B.A7F4C420@NB1>
From: torsten.rissel@t-online.de (Torsten Rissel)
To: "Linuxppc-Embedded (E-Mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: swapoff error; buffer memory
Date: Tue, 2 Jan 2001 22:30:47 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Everybody !

I have a strange problem in my newly ported kernel:
The amount of buffer memory is unusually high according to
meminfo (more then 48 MB on a board with 64MB memory);
if I use a swap partition it is immediately completly used
(104 MB size) and when I shut down the system, swapoff
generated a "swap_duplicate" error ?

I have used both a 2.2.16 standard kernel and a 2.2.18 kernel from linuxppc,
the results are identically.

Any idea what is going wrong ?

Torsten Rissel


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
