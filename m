Message-ID: <B164B53F5BD6D511888D009027732E1A024975@ntserver.act.domain>
From: Rudolf Ladyzhenskii <rudolf.ladyzhenskii@act-aus.net>
To: "'Dan Malek'" <dan@embeddededge.com>
Cc: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: request_irq () kills kernel
Date: Thu, 22 Nov 2001 15:05:12 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> > .... After I changed that file I am able to use request_8xxirq()
> > and it does not crash anymore.
>
> OK, but does it actually _work_ for you :-).
>
It installs the handler (I can see it in the /proc/interrupts) and does not
crash. I have not checked the interrupts themselves yet. Have to fix up some
other problems first.

Rudolf

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
