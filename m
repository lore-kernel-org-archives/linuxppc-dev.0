From: "Kim, Kwansuk" <kskim@neowave.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: serial console on 405GP 
Date: Thu, 7 Mar 2002 11:42:12 +0900
Message-ID: <OMENKEONFDLIGLHPFALBIEDACHAA.kskim@neowave.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3C867302.7080202@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear, everyone!

I'm poring linux-2.4.18-pre7 (from penquinppc.org) on my customized board (with IBM 405GP)

My board has no keyboard, so I'm using serial console on UART0.
I ported ppcboot, and it works well.

When I ported linux on my board, there happened some problem.

After init forks sash (standalone shell as you know),
I can see the prompt of the sash but the character sent wasn't delivered to sash.
So what character I send to the sash. It never respond.

I watch for the serial source (driver/char/serial.c) and enabled DEBUG option and the character sent
was received by kernel.

I don't know why the characters are disappeared.

Anyone know the reason?

Please, help me.

 ==============================================
     Just for fun...
                                                  - Linus Torvalds
 ==============================================
  Kwansuk Kim
  Engineer, NeoWave Inc.
  Tel   +82-31-380-4927    Fax +82-31-380-4747
  E-mail: kskim@neowave.co.kr
==============================================

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
