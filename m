Message-ID: <001501c01c0a$ce17f0a0$0a00010a@paoloweb>
From: "Paolo Scaffardi" <arsenio@tin.it>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Console output to framebuffer device: how?
Date: Mon, 11 Sep 2000 18:10:22 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I wrote a framebuffer device that i included in the kernel, but i dont know
how to redirect the output of the console to my framebuffer device instead
of the serial console.

During the startup the kernel initializes the framebuffer correctly, and
says:

"Console: switching to frame buffer device"

but nothing happens on it and the output is given only to serial console.

What should i do to make it work correctly, now?

Best regards,
Paolo Scaffardi (arsenio@tin.it - pscaffardi@supereva.it)
AIRVENT SAM s.p.a. - RIMINI (ITALY)
Tel. 0541 383294 - Fax 0541 387086


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
