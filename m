Message-ID: <002f01c032c7$7e311340$0a00010a@airvent.it>
From: "Paolo Scaffardi" <arsenio@tin.it>
To: "linuxppc-emb" <linuxppc-embedded@lists.linuxppc.org>
Subject: Booting the kernel... how?
Date: Tue, 10 Oct 2000 16:36:26 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I cannot run the kernel from PPCBOOT on my FADS and i dont know why.

I configured bd_t on my 'fads.h' to look the same of 'ppcboot.h', i created
the image using the same procedure explained on the README of PPCBOOT
(getting a zImage.initrd) but after compressing the kernel, nothing happens
to the terminal, and ethernet leds start flashes red.

I tried as Dan Dickey said, but nothing happened, too.

Where did i wrong?

- may the pinguin b with u -

Have a nice day,
Paolo Scaffardi.
AIRVENT SAM s.p.a. - RIMINI - ITALY


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
