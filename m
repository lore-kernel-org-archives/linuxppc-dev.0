Date: Tue, 30 Sep 2003 14:21:50 +0200
Message-ID: <3F710B1D00024B94@mssbzhh-int.msg.bluewin.ch>
In-Reply-To: <3F785515.2090406@imc-berlin.de>
From: "Wolfgang Grandegger" <wolfgang.grandegger@bluewin.ch>
Subject: RE: MPC823 and LCD?
To: "Steven Scholz" <steven.scholz@imc-berlin.de>,
	"Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>-- Original Message --
>Date: Mon, 29 Sep 2003 17:51:49 +0200
>From: Steven Scholz <steven.scholz@imc-berlin.de>
>To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
>Subject: MPC823 and LCD?
>
>
>
>Hi there,
>
>two questions about MPC823 and LCD:
>
>1. Has someone a working driver for linux > 2.4.20?

It'm not sure if we have already ported over our LCD
drivers from 2.4.4 to 2.4.20 but Wolfgang can clarify
this, I think.

>2. what's the difference between lcd823.c and video823.c in linux-2.4.4
from
>DENX?

The MPC823 has an interface for LCD displays but also for
video monitors (NTSC/PAL) through a video encoder, typically
a AD7176/7/9. Please have a look to the processor manual for
further information.

Wolfgang.

Wolfgang


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
