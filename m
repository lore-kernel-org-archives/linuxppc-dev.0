Message-ID: <E1836A7F3557D311A14000805F9F36FC015189FA@usdfo011.usac.danfoss.net>
From: "Pergola, Michael" <MichaelPergola@Danfoss.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: LCD Framebuffer for MPC8xx
Date: Wed, 17 Apr 2002 17:19:01 +0200
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


All,

Is there a reason, in Linux kernel 2.2.14, why the fb2(2 bits/pixel)
was left out of the LCD framebuffer driver for MPC823(lcd823.c)?
I am trying to I/F a monochrome graphics LCD and need to use
this mode. I will add it in to try but need a sanity check here.

Regards,
     Michael Pergola
     Software Engineer
     Baltimore, MD  21236     (410) 931-6778 x4259


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
