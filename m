Message-ID: <8D4C69676E66D511A1CB00508BBBB1921BCF4D@ranmx1.ran.harris.com>
From: "Walser, Martin" <mwalser@harris.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: no link changed interrupt
Date: Fri, 5 Jul 2002 01:51:55 -0400 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm using kernel 2.4.4.
The problem is, that I get no link changed interrupt when connecting or
disconnectiong the ethernet. I'm using the DP83846 from National. There is no
hardware interrupt, but it's possible to generate an interrupt flag in a special
register
Is it possible to get this software interrupt in the fec.c ?
Is there another way to get a link change without a hardware interrupt?

best regard
Martin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
