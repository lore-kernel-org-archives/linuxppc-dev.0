Message-ID: <000201c1c02b$a1abc480$65d71e97@ezio>
From: "RSR - Dominioni Piero" <pdominioni@rsr.it>
To: "Dan Malek" <dan@embeddededge.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <20020215135417.62312.qmail@web14003.mail.yahoo.com> <3C6D6145.5070503@embeddededge.com>
Subject: Re: Litle LCD on MBX860
Date: Thu, 28 Feb 2002 08:40:27 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all.
 I wanted to connect a LCD to a MPC823-based board and to use
microwindows too .

Dan Malek answered:
> You aren't going to connect an LCD to the MBX860 and see anything.
> There isn't any LCD controller on the 860.  You need an 823 or
> some external graphics controller.

Correct.
But what happens when the externel controller is provided?
Is there a LinuxPPC driver for it?
Does the LCD device become such as a character device
(or something like that) that needs a suitable node in /dev
with its own driver to be registered?

I tryed to configure Wolfgang's 2.4.4-2001-11-24 kernel for
TQM860L and while (obviously) there is no LCD driver for
860, the framebuffer is still there...
Does it mean that anyway it is possible to use a LCD with MPC860?
Thank you for any answer!
Bye

Piero


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
