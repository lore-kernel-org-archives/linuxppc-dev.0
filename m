Message-ID: <395650F7.9995CF21@pop.agri.ch>
Date: Sun, 25 Jun 2000 20:35:37 +0200
From: Andreas Tobler <toa@pop.agri.ch>
Reply-To: toa@pop.agri.ch
MIME-Version: 1.0
To: Linux -Dev <linuxppc-dev@lists.linuxppc.org>
Subject: macserial & 2.4.0-testX & wallstreet
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

while not being able to ppp under 2.4.0-test2 on my wallstreet I, I
found out that the serial port doesn't work anymore.
I tried a connection linuxbox(minicom) <-> wallstreet(minicom), on the
2.2.17preX series I can 'talk' over the serial line without any
problems.
While doing that under 2.4.0-test2 on the wallstreet I get a hanger when
I send a break over the line. Can't 'talk'.
I also enabled the debug stuff in macserial.c, there it seems that the
SCC is open correctly.

Minicom is 1.82, the modem is external, so it has nothing to do with a
minicom thread a few months ago on this list.
The changes on macserial.c which where made the last months were mostly
on the IrDA side.

Any ideas? Same situation elsewhere?

Thanks

Andreas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
