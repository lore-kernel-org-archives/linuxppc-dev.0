Message-ID: <3EFFE559.2030902@imc-berlin.de>
Date: Mon, 30 Jun 2003 09:23:05 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: zhu jiangbo <zhujb@szonline.net>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8xx EXT_DIRECT IDE
References: <200306300305.h5U35OLT014769@mail.berlin.imc-berlin.de>
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Zhu jiangbo schrieb:
>
>  I have read the mail listed below on the "lists.linuxppc.org"
> website. It looks like you are the right expert who can help me
> solving my problem. The embedded linux can't detect my SANDISK CF
> card. I choosed the EXT_DIRECT mode (CF's TRUE IDE mode), but now
> I am not sure if my design is right. Would you please send me the
> schematics and documents about MPC8xx IDE?

If you don't need a real PCMCIA slot on your board it would be much
easier to use 8xx_DIRECT instead of EXT_DIRECT!!!
I had to go for EXT_DIRECT since I do need both - PCMCIA slot for
let's say WLAN Cards and IDE for a 2.5" HDD.

So what do you think?

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
